-- by Qwar1e
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/Script%20for%20Executors/ESP.luau"))()

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
local camera = workspace.CurrentCamera

type espClassType = {
	new: (plr: Player) -> espClassType,
	RemoveBox: () -> nil,
	HideBox: () -> nil,

	plr: Player,

	Components: {
		Up: Frame,
		Down: Frame,
		Left: Frame,
		Right: Frame,
		Tracer: Frame?,
		Distance: TextLabel?
	},

	__cache: {
		lastColor: Color3,
		lastTracerColor: Color3,
		lastTracerThickness: number
	}
}

type TracerModeType = "Bottom" | "Middle" | "Top" | "Cursor"

local cfg = {
	UI = true,

	ESP = {
		Enabled = false,
        ShowBox = false,
		TeamCheck = false,
        ShowHealth = false,
		ShowDistance = false,
		
		Color = Color3.fromRGB(255, 255, 255)
	},

	Tracer = {
		Enabled = false,

		Origin = "Bottom" :: TracerModeType
	}
}

genv.EspCache = {
	Boxes = {},
	Connections = {},
	Destroy = function()
		for _, Box in genv.EspCache.Boxes do
			Box:RemoveBox()
		end

		for _, i in genv.EspCache.Connections do
			i:Disconnect()
		end
	end
}

local espClass do
	espClass = {}
	espClass.__index = espClass

	function espClass.new(plr: Player): espClassType
		local old = genv.EspCache.Boxes[plr]
		if old then return old end

		local self = setmetatable({
			plr = plr,

			Components = nil,

			__cache = {
				lastColor = nil,
				lastTracerColor = nil,
				lastTracerThickness = nil
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

		return self
	end

	function espClass:RemoveBox()
		for _, i in self.Components do
			i:Remove()
		end

		if genv.EspCache.Boxes[self.plr] then
			genv.EspCache.Boxes[self.plr] = nil
		end
	end

	function espClass:HideBox()
		for _, component in self.Components do
			component.Visible = false
		end
	end
end

local function getCharacterBoundingBox(character)
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return nil end
	
	local minX, minY, minZ = math.huge, math.huge, math.huge
	local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge
	
	for _, part in ipairs(character:GetChildren()) do
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
			
			for _, corner in ipairs(corners) do
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
	
	if minX == math.huge then
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
		game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau") -- readfile("ui_library.txt")
	)()

	local Window = __module:MakeWindow({
		name = "Undetected ESP | v1.2.1",
		theme = "Dark",

		sizeX = 330,
		sizeY = 400,
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
				callback = function(v: boolean)
					cfg.ESP.Enabled = v
				end
			})

			section:MakeToggle({
				Text = "Team Check",
				Flag = cfg.ESP.TeamCheck,
				callback = function(v: boolean)
					cfg.ESP.TeamCheck = v
				end
			})

            section:MakeToggle({
				Text = "Show Box",
				Flag = cfg.ESP.ShowBox,
				callback = function(v: boolean)
					cfg.ESP.ShowBox = v
				end
			})

			section:MakeToggle({
				Text = "Show Distance",
				Flag = cfg.ESP.ShowDistance,
				callback = function(v: boolean)
					cfg.ESP.ShowDistance = v
				end
			})

            section:MakeToggle({
				Text = "Show Health",
				Flag = cfg.ESP.ShowHealth,
				callback = function(v: boolean)
					cfg.ESP.ShowHealth = v
				end
			})

			section:MakeColorPicker({
				Text = "Color",
				Default = cfg.ESP.Color,

				callback = function(v)
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

				callback = function(v: boolean)
					cfg.Tracer.Enabled = v
				end
			})

			section:MakeDropdown({
				Default = cfg.Tracer.Origin,
				Content = {"Bottom", "Middle", "Top", "Cursor"},
				multiChoice = false,

				callback = function(v)
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
	local mouse = Owner:GetMouse()

	for _, i in Players:GetPlayers() do
		if i == Owner then continue end

		local Box = genv.EspCache.Boxes[i]
		if not Box then continue end

		if not cfg.ESP.Enabled and not cfg.Tracer.Enabled then
			Box:HideBox()

			continue
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
			for name, corner in pairs(corners) do
				local screenPos, visible = camera:WorldToViewportPoint(corner)
				if visible then
					screenCorners[name] = Vector2.new(screenPos.X, screenPos.Y)
				else
					local centerPos = camera:WorldToViewportPoint(bbox.Center)
					screenCorners[name] = Vector2.new(centerPos.X, centerPos.Y)
				end
			end
			
			local minScreenX, minScreenY = math.huge, math.huge
			local maxScreenX, maxScreenY = -math.huge, -math.huge
			
			for _, screenPos in pairs(screenCorners) do
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
                        
                        local distanceText = string.format("%.1f studs", distance)
                        
                        local textPosition = Vector2.new(
                            (minScreenX + maxScreenX) / 2,
                            minScreenY - 20
                        )
                        
                        Box.Components.Distance.Position = textPosition
                        Box.Components.Distance.Text = distanceText
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
