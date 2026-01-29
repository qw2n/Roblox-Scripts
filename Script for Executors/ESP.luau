-- by BinaryCrypt (Aka Qwar1e)
-- Discord: binarycrypt
-- Discord Server: https://discord.gg/pY6nDej76m

-- Script: loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/Script%20for%20Executors/ESP.luau"))()

local function check(a, er)
	if not a then
		error(er)
	end

	return a
end

local getgenv = check(getgenv, "Your executor not supported 'getgenv'")
local cloneref = check(cloneref, "Your executor not supported 'cloneref'")
local Drawing = check(Drawing, "Your executor not supported Drawing library")

local genv = getgenv()

if genv.EspCache and genv.EspCache.Destroy then
	genv.EspCache.Destroy()
end

local Players = cloneref(game:GetService("Players")) :: Players
local RunService = cloneref(game:GetService("RunService")) :: RunService

local Owner = Players.LocalPlayer
local mouse = Owner:GetMouse()

local camera = workspace.CurrentCamera

local g_const_huge = math.huge

type TracerModeType = "Bottom" | "Middle" | "Top" | "Cursor"

local cfg = {
	UI = true,

	ESP = {
		Enabled = false,
        ShowBox = false,
        SelfEsp = false,
		TeamCheck = false,
        ShowHealth = false,
		ShowDistance = false,
		ShowSkeleton = false,
		
		Color = Color3.fromRGB(255, 255, 255)
	},

	Tracer = {
		Enabled = false,
		Origin = "Bottom" :: TracerModeType
	}
}

genv.EspCache = {
	Boxes = {},
	Skeletons = {},
	Connections = {},
	Destroy = function()
		for _, Box in genv.EspCache.Boxes do
			Box:RemoveBox()
		end
		
		for _, skeletonParts in genv.EspCache.Skeletons do
			for _, part in skeletonParts do
				part:Remove()
			end
		end

		for _, i in genv.EspCache.Connections do
			i:Disconnect()
		end
	end
}

local CharacterWhitelistedParts = {
    ["R6"] = {
        {"Head", "Torso"},
        
        {"Torso", "Left Arm"},
        {"Left Arm", "LeftHand"},
        
        {"Torso", "Right Arm"},
        {"Right Arm", "RightHand"},
        
        {"Torso", "Left Leg"},
        {"Left Leg", "LeftFoot"},
        
        {"Torso", "Right Leg"},
        {"Right Leg", "RightFoot"}
    },

    ["R15"] = {
        {"Head", "UpperTorso"},
        {"UpperTorso", "LowerTorso"},
        
        {"UpperTorso", "LeftUpperArm"},
        {"LeftUpperArm", "LeftLowerArm"},
        {"LeftLowerArm", "LeftHand"},
        
        {"UpperTorso", "RightUpperArm"},
        {"RightUpperArm", "RightLowerArm"},
        {"RightLowerArm", "RightHand"},
        
        {"LowerTorso", "LeftUpperLeg"},
        {"LeftUpperLeg", "LeftLowerLeg"},
        {"LeftLowerLeg", "LeftFoot"},
        
        {"LowerTorso", "RightUpperLeg"},
        {"RightUpperLeg", "RightLowerLeg"},
        {"RightLowerLeg", "RightFoot"}
    }
}

local espClass do
	espClass = {}
	espClass.__index = espClass

	function espClass.new(plr: Player)
		local old = genv.EspCache.Boxes[plr]
		if old then return old end

		local self = setmetatable({
			plr = plr,
			Components = nil,
			__cache = {
				lastColor = nil,
				lastTracerColor = nil,
				lastTracerThickness = nil,
				isR6 = nil
			}
		}, espClass)

		local Up = Drawing.new("Line")
		Up.Visible = false
		Up.Color = cfg.ESP.Color
		Up.Thickness = 2
		Up.Transparency = 1

		local Down = Drawing.new("Line")
		Down.Visible = false
		Down.Color = cfg.ESP.Color
		Down.Thickness = 2
		Down.Transparency = 1

		local Left = Drawing.new("Line")
		Left.Visible = false
		Left.Color = cfg.ESP.Color
		Left.Thickness = 2
		Left.Transparency = 1

		local Right = Drawing.new("Line")
		Right.Visible = false
		Right.Color = cfg.ESP.Color
		Right.Thickness = 2
		Right.Transparency = 1

		local Tracer = Drawing.new("Line")
		Tracer.Visible = false
		Tracer.Color = cfg.ESP.Color
		Tracer.Thickness = 1
		Tracer.Transparency = 1

		local Distance = Drawing.new("Text")
		Distance.Visible = false
		Distance.Color = cfg.ESP.Color
		Distance.Size = 13
		Distance.Center = true
		Distance.Outline = true
		Distance.Transparency = 1

		local HP = Drawing.new("Line")
		HP.Visible = false
		HP.Color = Color3.fromRGB(0, 255, 0)
		HP.Thickness = 3
		HP.Transparency = 1

		self.Components = {
			Up = Up,
			Down = Down,
			Left = Left,
			Right = Right,
			Tracer = Tracer,
			Distance = Distance,
			HP = HP
		}

		genv.EspCache.Boxes[plr] = self
		
		genv.EspCache.Skeletons[plr] = {}
		local maxConnections = math.max(#CharacterWhitelistedParts["R15"], #CharacterWhitelistedParts["R6"])
		for i = 1, maxConnections do
			local line = Drawing.new("Line")
			line.Visible = false
			line.Color = cfg.ESP.Color
			line.Thickness = 1
			line.Transparency = 1

			table.insert(genv.EspCache.Skeletons[plr], line)
		end

		return self
	end

	function espClass:RemoveBox()
		for _, i in self.Components do
			i:Remove()
		end
		
		local skeleton = genv.EspCache.Skeletons[self.plr]
		if skeleton then
			for _, line in skeleton do
				line:Remove()
			end

			genv.EspCache.Skeletons[self.plr] = nil
		end

		if genv.EspCache.Boxes[self.plr] then
			genv.EspCache.Boxes[self.plr] = nil
		end
	end

	function espClass:HideBox()
		for _, component in self.Components do
			component.Visible = false
		end
		
		local skeleton = genv.EspCache.Skeletons[self.plr]
		if skeleton then
			for _, line in skeleton do
				line.Visible = false
			end
		end
	end
end

local function detectRigType(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		return humanoid.RigType.Name
	end
	
	return nil
end

local function findPartByName(character, partName)
	local part = character:FindFirstChild(partName)
	if part then return part end
	
	local altName = CharacterWhitelistedParts["R6"][partName]
	if altName then
		return character:FindFirstChild(altName)
	end
	
	for _, child in character:GetChildren() do
		if child:IsA("BasePart") then
			local lowerChildName = string.lower(child.Name)
			local lowerTargetName = string.lower(partName)
			
			if string.find(lowerChildName, lowerTargetName) or string.find(lowerTargetName, lowerChildName) then
				return child
			end
		end
	end
	
	return nil
end

local function updateSkeleton(character, plr, box)
	if not cfg.ESP.ShowSkeleton then return end
	
	local skeleton = genv.EspCache.Skeletons[plr]
	if not skeleton then return end
	
	local rigType = detectRigType(character)
	
	if box.__cache.isR6 ~= (rigType == "R6") then
		box.__cache.isR6 = (rigType == "R6")
	end
	
	local connections
	if rigType == "R15" then
		connections = CharacterWhitelistedParts["R15"]
	else
		connections = CharacterWhitelistedParts["R6"]
	end
	
	for _, line in skeleton do
		line.Visible = false
	end
	
	for i, connection in connections do
		local line = skeleton[i]
		if not line then break end
		
		local part1Name, part2Name = connection[1], connection[2]
		local part1 = findPartByName(character, part1Name)
		local part2 = findPartByName(character, part2Name)
		
		if part1 and part2 then
			local pos1 = part1.Position
			local pos2 = part2.Position
			
			local screenPos1, onScreen1 = camera:WorldToViewportPoint(pos1)
			local screenPos2, onScreen2 = camera:WorldToViewportPoint(pos2)
			
			if onScreen1 and onScreen2 then
				line.From = Vector2.new(screenPos1.X, screenPos1.Y)
				line.To = Vector2.new(screenPos2.X, screenPos2.Y)
				line.Visible = true
				line.Color = cfg.ESP.Color
			end
		end
	end
end

local function getCharacterBoundingBox(character)
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return nil end
	
	local minX, minY, minZ = g_const_huge, g_const_huge, g_const_huge
	local maxX, maxY, maxZ = -g_const_huge, -g_const_huge, -g_const_huge
	
	for _, part in character:GetChildren() do
		if part:IsA("BasePart") and part ~= rootPart then
			local cf = part.CFrame
			local size = part.Size
			
			local corners = {
				cf * CFrame.new(size.X/2, size.Y/2, size.Z/2),
				cf * CFrame.new(-size.X/2, size.Y/2, size.Z/2),
				cf * CFrame.new(size.X/2, -size.Y/2, size.Z/2),
				cf * CFrame.new(-size.X/2, -size.Y/2, size.Z/2),
				cf * CFrame.new(size.X/2, size.Y/2, -size.Z/2),
				cf * CFrame.new(-size.X/2, size.Y/2, -size.Z/2),
				cf * CFrame.new(size.X/2, -size.Y/2, -size.Z/2),
				cf * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2)
			}
			
			for _, corner in corners do
				local pos = corner.Position
				minX = math.min(minX, pos.X)
				minY = math.min(minY, pos.Y)
				minZ = math.min(minZ, pos.Z)
				maxX = math.max(maxX, pos.X)
				maxY = math.max(maxY, pos.Y)
				maxZ = math.max(maxZ, pos.Z)
			end
		end
	end
	
	if minX == g_const_huge then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			local height = humanoid.HipHeight + 2
			local width = 2
			local center = rootPart.Position
			
			minX = center.X - width
			minY = center.Y - height/2
			minZ = center.Z - width
			maxX = center.X + width
			maxY = center.Y + height/2
			maxZ = center.Z + width
		else
			return nil
		end
	end
	
	return {
		Min = Vector3.new(minX, minY, minZ),
		Max = Vector3.new(maxX, maxY, maxZ),

		Center = Vector3.new((minX + maxX)/2, (minY + maxY)/2, (minZ + maxZ)/2)
	}
end

local function calculateDistance(position1, position2)
	return (position1 - position2).Magnitude
end

if cfg.UI then
	local __module = loadstring(
		game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau")
		--readfile("ui_library.luau")
	)()

	local Window = __module.new({
		Name = "Undetected ESP | v1.2.4",
	    Theme = "Metalic",

		SizeX = 330,
		SizeY = 420,

        OpenGuiKeyCode = Enum.KeyCode.Z
	})

	do
		local tab = Window:MakeTab({
			Text = "Main"
		})

		do
			local section = tab:MakeSection({
				Text = "ESP",
				Column = 1
			})

			section:MakeToggle({
				Text = "Enabled",
				Flag = cfg.ESP.Enabled,
				Callback = function(v: boolean)
					cfg.ESP.Enabled = v
				end
			})

			section:MakeToggle({
				Text = "Team Check",
				Flag = cfg.ESP.TeamCheck,
				Callback = function(v: boolean)
					cfg.ESP.TeamCheck = v
				end
			})

			section:MakeToggle({
				Text = "Self",
				Flag = cfg.ESP.SelfEsp,
				Callback = function(v: boolean)
					cfg.ESP.SelfEsp = v
				end
			})

			section:MakeToggle({
				Text = "Box",
				Flag = cfg.ESP.ShowBox,
				Callback = function(v: boolean)
					cfg.ESP.ShowBox = v
				end
			})

			section:MakeToggle({
				Text = "Distance",
				Flag = cfg.ESP.ShowDistance,
				Callback = function(v: boolean)
					cfg.ESP.ShowDistance = v
				end
			})

			section:MakeToggle({
				Text = "Health",
				Flag = cfg.ESP.ShowHealth,
				Callback = function(v: boolean)
					cfg.ESP.ShowHealth = v
				end
			})
			
			section:MakeToggle({
				Text = "Skeleton",
				Flag = cfg.ESP.ShowSkeleton,
				Callback = function(v: boolean)
					cfg.ESP.ShowSkeleton = v
				end
			})

			section:MakeColorPicker({
				Text = "Color",
				Default = cfg.ESP.Color,
				Callback = function(v)
					cfg.ESP.Color = v
				end
			})
		end

		do
			local section = tab:MakeSection({
				Text = "Tracer",
				Column = 1
			})

			section:MakeToggle({
				Text = "Tracer Enabled",
				Flag = cfg.Tracer.Enabled,
				Callback = function(v: boolean)
					cfg.Tracer.Enabled = v
				end
			})

			section:MakeDropdown({
				Default = cfg.Tracer.Origin,
				Content = {"Bottom", "Middle", "Top", "Cursor"},
				MultiChoice = false,
				Callback = function(v)
					cfg.Tracer.Origin = v
				end
			})
		end
	end
end

for _, i in Players:GetPlayers() do
	espClass.new(i)
end

table.insert(genv.EspCache.Connections, Players.PlayerRemoving:Connect(function(plr)
	if Owner == plr then return end

	local box = genv.EspCache.Boxes[plr]
	if box then 
		box:RemoveBox()
	end
end))

table.insert(genv.EspCache.Connections, Players.PlayerAdded:Connect(espClass.new))

table.insert(genv.EspCache.Connections, RunService.RenderStepped:Connect(function()
	for _, i in Players:GetPlayers() do
        local Box = genv.EspCache.Boxes[i]
		if not Box then continue end

		if not cfg.ESP.SelfEsp and i == Owner then
            Box:HideBox() continue
        end

		if not cfg.ESP.Enabled then
			Box:HideBox() continue
		end

		local Character = i.Character
		if not Character then Box:HideBox() continue end

		local RootPart = Character:FindFirstChild("HumanoidRootPart")
		if not RootPart then Box:HideBox() continue end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if not Humanoid then Box:HideBox() continue end
		if Humanoid.Health == 0 then Box:HideBox() continue end

		local Head = Character:FindFirstChild("Head")
		if not Head then Box:HideBox() continue end

		if Humanoid.Health < 0 then Box:HideBox() continue end

		if cfg.ESP.TeamCheck and Owner.TeamColor == i.TeamColor then Box:HideBox() continue end

		if Box.__cache.lastColor ~= cfg.ESP.Color then
			Box.__cache.lastColor = cfg.ESP.Color

			for _, component in Box.Components do
				component.Color = cfg.ESP.Color
			end
		end

		local _, OnScreen = camera:WorldToViewportPoint(RootPart.Position)
		if not OnScreen then Box:HideBox() continue end

		do
			local bbox = getCharacterBoundingBox(Character)
			if not bbox then Box:HideBox() continue end
			
			local corners = {
				TopLeft = Vector3.new(bbox.Min.X, bbox.Max.Y, bbox.Min.Z),
				TopRight = Vector3.new(bbox.Max.X, bbox.Max.Y, bbox.Min.Z),
				BottomLeft = Vector3.new(bbox.Min.X, bbox.Min.Y, bbox.Min.Z),
				BottomRight = Vector3.new(bbox.Max.X, bbox.Min.Y, bbox.Min.Z),
				TopLeftBack = Vector3.new(bbox.Min.X, bbox.Max.Y, bbox.Max.Z),
				TopRightBack = Vector3.new(bbox.Max.X, bbox.Max.Y, bbox.Max.Z),
				BottomLeftBack = Vector3.new(bbox.Min.X, bbox.Min.Y, bbox.Max.Z),
				BottomRightBack = Vector3.new(bbox.Max.X, bbox.Min.Y, bbox.Max.Z)
			}
			
			local screenCorners = {}
			for name, corner in corners do
				local screenPos, visible = camera:WorldToViewportPoint(corner)
				if visible then
					screenCorners[name] = Vector2.new(screenPos.X, screenPos.Y)
				else
					local centerPos = camera:WorldToViewportPoint(bbox.Center)
					screenCorners[name] = Vector2.new(centerPos.X, centerPos.Y)
				end
			end
			
			local minScreenX, minScreenY = g_const_huge, g_const_huge
			local maxScreenX, maxScreenY = -g_const_huge, -g_const_huge
			
			for _, screenPos in screenCorners do
				minScreenX = math.min(minScreenX, screenPos.X)
				minScreenY = math.min(minScreenY, screenPos.Y)
				maxScreenX = math.max(maxScreenX, screenPos.X)
				maxScreenY = math.max(maxScreenY, screenPos.Y)
			end
			
			if cfg.ESP.Enabled then
				if cfg.ESP.ShowBox then
					Box.Components.Up.From = Vector2.new(minScreenX, minScreenY)
					Box.Components.Up.To = Vector2.new(maxScreenX, minScreenY)

					Box.Components.Down.From = Vector2.new(minScreenX, maxScreenY)
					Box.Components.Down.To = Vector2.new(maxScreenX, maxScreenY)

					Box.Components.Left.From = Vector2.new(minScreenX, minScreenY)
					Box.Components.Left.To = Vector2.new(minScreenX, maxScreenY)

					Box.Components.Right.From = Vector2.new(maxScreenX, minScreenY)
					Box.Components.Right.To = Vector2.new(maxScreenX, maxScreenY)

					Box.Components.Up.Visible = true
					Box.Components.Down.Visible = true
					Box.Components.Left.Visible = true
					Box.Components.Right.Visible = true
				else
					Box.Components.Up.Visible = false
					Box.Components.Down.Visible = false
					Box.Components.Left.Visible = false
					Box.Components.Right.Visible = false
				end

				if cfg.ESP.ShowDistance then
					local localCharacter = Owner.Character
					local localRootPart = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
					
					if localRootPart then
						local distance = calculateDistance(localRootPart.Position, RootPart.Position)
						
						Box.Components.Distance.Position = Vector2.new(
                            (minScreenX + maxScreenX) / 2,
                            maxScreenY + 10
                        )

						Box.Components.Distance.Text = string.format("%.1f studs", distance)
					end

					Box.Components.Distance.Visible = true
				else
					Box.Components.Distance.Visible = false
				end

				local HP = Box.Components.HP
				if cfg.ESP.ShowHealth then
					local hpPercent = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)

					local barX = minScreenX - 6
					local barTop = minScreenY
					local barBottom = maxScreenY

					local hpY = barBottom - (barBottom - barTop) * hpPercent

					local hpColor
					if hpPercent > 0.5 then
						hpColor = Color3.fromRGB(0, 255, 0)

					elseif hpPercent > 0.2 then
						hpColor = Color3.fromRGB(255, 255, 0)
					else
						hpColor = Color3.fromRGB(255, 0, 0)
					end

					HP.Color = hpColor
					HP.From = Vector2.new(barX, barBottom)
					HP.To = Vector2.new(barX, hpY)

					HP.Visible = true
				else
					HP.Visible = false
				end
				
				updateSkeleton(Character, i, Box)
			end

			if cfg.Tracer.Enabled then
				local tracerOrigin, tracerEnd = nil, nil

				tracerEnd = Vector2.new(
					(minScreenX + maxScreenX) / 2,
					maxScreenY
				)

				if cfg.Tracer.Origin == "Bottom" then
					tracerOrigin = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
				
                elseif cfg.Tracer.Origin == "Middle" then
					tracerOrigin = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
				
                elseif cfg.Tracer.Origin == "Top" then
					tracerOrigin = Vector2.new(camera.ViewportSize.X/2, 0)
				
                elseif cfg.Tracer.Origin == "Cursor" then
					tracerOrigin = Vector2.new(mouse.X, mouse.Y + 36)
				end

				Box.Components.Tracer.From = tracerOrigin
				Box.Components.Tracer.To = tracerEnd

				Box.Components.Tracer.Visible = true
			else
				Box.Components.Tracer.Visible = false
			end
		end
	end
end))
