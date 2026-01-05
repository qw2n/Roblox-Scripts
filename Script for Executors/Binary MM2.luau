-- by BinaryCrypt (Aka Qwar1e)
-- Discord: binarycrypt
-- Discord Server: https://discord.gg/pY6nDej76m

-- Script: loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/Script%20for%20Executors/Binary%20MM2.luau"))()

local function check(a: any, b: string, throw_error: boolean, fn: () -> ()): any
    if not a then
        if throw_error then
			error(b, 2)
		end

		return fn
    end

    return a
end

local getgenv = check(getgenv, nil, false, function()
	if not _G.__hidden_env then
		_G.__hidden_env = {}
	end

	return _G.__hidden_env
end)

local cloneref = check(cloneref, nil, false, function(object)
	return object
end)

local setclipboard = check(setclipboard, nil, false, nil)
local firetouchinterest = check(firetouchinterest, nil, false, nil)

local g_const_huge = math.huge
local g_kill_mainthread = false
local g_connections = {}

local c_tween = nil
local c_dropped_gun = nil
local c_bodyvelocity = nil

local genv = getgenv()

if genv.BinaryMM2 then
	genv.BinaryMM2.Destroy()
end

local TweenService = cloneref(game:GetService("TweenService")) :: TweenService
local RunService = cloneref(game:GetService("RunService")) :: RunService
local Players = cloneref(game:GetService("Players")) :: Players

local plr = Players.LocalPlayer
local PlayerGui = plr.PlayerGui

local cfg = {
	Autofarm = {
		Enabled = false,

		DeathOnMaxCoins = false
	},

	Misc = {
		Noclip = false,
		AntiFling = false
	},

	GunUtility = {
		HighlightGun = false,
		AutoGunTaking = false
	}
}

local ServerInfo = {
	PlayersCount = 0,
	MaxPlayersCount = Players.MaxPlayers
}

local CoinContainer = nil
local CoinCounter = nil

local function IsCoinsBagFull(): boolean
	if not CoinCounter then
		return false
	end

	local Full = CoinCounter:FindFirstChild("Full")
	if not Full then return false end

	return Full.Visible == true
end

local function IsInLobby(): boolean
	return plr.NameDisplayDistance == 100
end

local function IsReadyToFarm(): boolean
    if not CoinContainer or not CoinCounter then
        return false
    end

	return IsInLobby() == false
end

local function IsObjectAlive(Object): boolean
	return Object and Object.Parent ~= nil
end

local function IsCoinAlive(Coin: Part): boolean
	return IsObjectAlive(Coin) and Coin:FindFirstChild("CoinVisual") and Coin.CoinVisual.Transparency == 0
end

local function IsThreadQueueToDestroy(): boolean
	return g_kill_mainthread == true
end

local function FeatchObject(Object: Instance, Name: string, ClassName: string): Instance?
    for _, i in Object:GetDescendants() do
        if i:IsA(ClassName) and i.Name == Name then
            return i
        end
    end

    return nil
end

local function SetBodyVelocity(RootPart)
	if c_bodyvelocity then return end

	if not RootPart then return end
	if RootPart:FindFirstChildOfClass("BodyVelocity") then return end

	c_bodyvelocity = Instance.new("BodyVelocity", RootPart)
end

local function GetRootPart(): Part?
	local Character = plr.Character
	if not Character then return end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if HumanoidRootPart then
		return HumanoidRootPart
	end

	return nil
end

local function GetNearestCoin(RootPart: Part): Part & number
	if not RootPart then return nil end
	if not CoinContainer then return nil end

	local lastCoin = nil
	local lastDistance = g_const_huge

	for _, i in CoinContainer:GetChildren() do
		if i:IsA("Part") then
			if not IsCoinAlive(i) then continue end

			local Distance = (i.Position - RootPart.Position).Magnitude
			if Distance < lastDistance then
				lastCoin = i
				lastDistance = Distance
			end
		end
	end

	local Time = lastDistance/10
	return lastCoin, if Time > 2 then 2
	else if
		Time < 1.5 then 0.1
		else 1
end

local function FixCharacterCollisions(Character: Model)
	if not Character then return end

	local LowerTorso = Character:FindFirstChild("LowerTorso")
	if LowerTorso and not LowerTorso.CanCollide then
		LowerTorso.CanCollide = true
	end

	local UpperTorso = Character:FindFirstChild("UpperTorso")
	if UpperTorso and not UpperTorso.CanCollide then
		UpperTorso.CanCollide = true
	end
end

local function ConvertTime(Time: number): string
    if Time < 0 then
        return "0s"
    end

	local parts = {}
    
    local days = math.floor(Time / 86400)
    Time = Time % 86400
    
    local hours = math.floor(Time / 3600)
    Time = Time % 3600
    
    local minutes = math.floor(Time / 60)
    local seconds = Time % 60
    
    if days > 0 then
        table.insert(parts, days .. "d")
    end
    
    if hours > 0 then
        table.insert(parts, hours .. "h")
    end
    
    if minutes > 0 then
        table.insert(parts, minutes .. "m")
    end
    
    if seconds > 0 or #parts == 0 then
        table.insert(parts, math.floor(seconds) .. "s")
    end
    
    return table.concat(parts, " : ")
end

local function setHighlight(Object)
	Instance.new("Highlight", Object)
end

local function TakeGun(a)
	if not firetouchinterest then return end
	if IsInLobby() then return end

	local RootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not RootPart then return end
	
	local Gun = a or c_dropped_gun or FeatchObject(workspace, "GunDrop", "Part")
	if not Gun then return end

	pcall(function()
		repeat task.wait(0.1)
			firetouchinterest(Gun, RootPart, false)
		until IsObjectAlive(Gun) == false
	end)
end

local function GetHumanoidFromPlayer(plr: Player): Humanoid
	return plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
end

genv.BinaryMM2 = {
	Destroy = function()
		g_kill_mainthread = true

		for s, i in g_connections do
			if i then
				i:Disconnect()
				g_connections[s] = nil
			end
		end

		if c_tween then
			c_tween:Cancel()
		end

		if c_bodyvelocity then
			c_bodyvelocity:Destroy()
		end

		for _, i in Players:GetPlayers() do
			FixCharacterCollisions(i)
		end

		local Humanoid = GetHumanoidFromPlayer(plr)
		if Humanoid then
			Humanoid.WalkSpeed = 16
			Humanoid.JumpPower = 50
		end
	end
}

local __module = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau")
	--readfile("ui_library.luau")
)()

local Window = __module.new({
	Name = "Binary MM2 | v1.0.3",
	Theme = "Metalic",

	SizeX = 330,
	SizeY = 400,

	OpenGuiKeyCode = Enum.KeyCode.Z
}) 

local StatusLabel, RuntimeLabel, PlayersCountLabel do
    local tab = Window:MakeTab({
        Text = "Home"
    }) do
        local section = tab:MakeSection({
            Text = "Info",
            Column = 1
        }) do
            section:MakeLabel({
                Text = "by Qwar1e"
            })

			section:MakeLabel({
                Text = "Open/Close: Z"
            })

            section:MakeButton({
                Text = "Copy discord link",

				Callback = function()
					if setclipboard then
						setclipboard("https://discord.gg/pY6nDej76m")
					end
				end
            })
        end

		local section = tab:MakeSection({
			Text = "Server Info",
			Column = 2
		}) do
			PlayersCountLabel = section:MakeLabel({
				Text = "Players: 0/"..tostring(Players.MaxPlayers)
			})

			RuntimeLabel = section:MakeLabel({
				Text = "Runtime: 0"
			})

			section:MakeButton({
				Text = "Copy Server Id",
				Callback = function()
					if setclipboard then
						setclipboard(game.JobId)
					end
				end
			})
		end
    end

	local tab = Window:MakeTab({
		Text = "Main"
	}) do
		local NoclipButton, AntiFlingButton

		local section = tab:MakeSection({
			Text = "Auto-Farm",
			Column = 1
		}) do
            section:MakeToggle({
                Text = "Enable",
                Flag = cfg.Autofarm.Enabled,
                Callback = function(v: boolean)
                    cfg.Autofarm.Enabled = v

					NoclipButton:Toggle(v)
					AntiFlingButton:Toggle(v)

                    if not cfg.Autofarm.Enabled then
                        if c_tween then
                            c_tween:Cancel()
                        end

                        if c_bodyvelocity then
                            c_bodyvelocity:Destroy()
                        end
                    end
                end
            })

            StatusLabel = section:MakeLabel({
                Text = "Status: None"
            })

			section:MakeLabel({
                Text = ""
            })

			section:MakeLabel({
                Text = "Auto-Farm Rules:"
            })

			section:MakeToggle({
                Text = "Death on max coins",
                Flag = cfg.Autofarm.DeathOnMaxCoins,

                Callback = function(v: boolean)
					cfg.Autofarm.DeathOnMaxCoins = v
                end
            })
        end

		local section = tab:MakeSection({
			Text = "Misc",
			Column = 2
		}) do
			NoclipButton = section:MakeToggle({
				Text = "Noclip",
				Flag = cfg.Misc.Noclip,

				Callback = function(v)
					cfg.Misc.Noclip = v

					if not cfg.Misc.Noclip then
						FixCharacterCollisions(plr.Character)
					end
				end
			})

			AntiFlingButton = section:MakeToggle({
				Text = "Anti-Fling",
				Flag = cfg.Misc.AntiFling,

				callback = function(v)
					cfg.Misc.AntiFling = v

					if not cfg.Misc.AntiFling then
						for _, i in Players:GetPlayers() do
							if i == plr then continue end

							FixCharacterCollisions(i.Character)
						end
					end
				end
			})

			local WalkSpeedSlider = section:MakeSlider({
				Text = "WalkSpeed",
				ValueType = "/",
				
				Min = 1,
				Max = 300,
				
				Decimals = 1,
				Default = 16,

				Callback = function(v: number)
					local Humanoid = GetHumanoidFromPlayer(plr)
					if not Humanoid then return end

					Humanoid.WalkSpeed = v
				end
			})

			local JumpPowerSlider = section:MakeSlider({
				Text = "JumpPower",
				ValueType = "/",
				
				Min = 1,
				Max = 300,
				
				Decimals = 1,
				Default = 50,

				Callback = function(v: number)
					local Humanoid = GetHumanoidFromPlayer(plr)
					if not Humanoid then return end
					
					Humanoid.JumpPower = v
				end
			})

			section:MakeButton({
				Text = "Reset",

				Callback = function()
					WalkSpeedSlider:SetValue(16)
					JumpPowerSlider:SetValue(50)

					local Humanoid = GetHumanoidFromPlayer(plr)
					if Humanoid then
						Humanoid.WalkSpeed = 16
						Humanoid.JumpPower = 50
					end
				end
			})

			section:MakeButton({
				Text = "Reset Character",

				Callback = function()
					local Character = plr.Character
					if not Character then return end

					local RootPart = Character:FindFirstChild("HumanoidRootPart")
					if not RootPart then return end

					local Humanoid = GetHumanoidFromPlayer(plr)
					if not Humanoid then return end

					local last = RootPart.CFrame

					Humanoid.Health = 0

					local Yes = 0
					while Yes < 100 and task.wait() do
						Character = plr.Character
						if not Character then continue end

						RootPart = Character:FindFirstChild("HumanoidRootPart")
						if RootPart then
							RootPart.CFrame = last

							if RootPart.CFrame == last then
								Yes += 1
							end
						end
					end
				end
			})
		end

		local section = tab:MakeSection({
			Text = "Gun Utility",
			Column = 1
		}) do
			section:MakeToggle({
				Text = "Highlight Gun",
				Flag = cfg.GunUtility.HighlightGun,

				Callback = function(v)
					cfg.GunUtility.HighlightGun = v

					local Gun = c_dropped_gun or FeatchObject(workspace, "GunDrop", "Part")
					if not Gun then return end

					if cfg.GunUtility.HighlightGun then
						setHighlight(Gun)
					else
						local Highlighter = Gun:FindFirstChildOfClass("Highlight")
						if Highlighter then
							Highlighter:Destroy()
						end
					end
				end
			})

			section:MakeToggle({
				Text = "Auto Gun Taking",
				Flag = cfg.GunUtility.AutoGunTaking,

				Callback = function(v)
					cfg.GunUtility.AutoGunTaking = v

					if cfg.GunUtility.AutoGunTaking then
						TakeGun()
					end
				end
			})

			section:MakeButton({
				Text = "Take Gun",

				Callback = TakeGun
			})
		end
	end
end

local local_delta_value = 0
local connection; connection = RunService.RenderStepped:Connect(function(delta)
	if IsThreadQueueToDestroy() then
		return connection:Disconnect()
	end

	local_delta_value += delta

	local PlayersContainer = Players:GetPlayers()

	ServerInfo.PlayersCount = #PlayersContainer

	if local_delta_value >= 1 then
		RuntimeLabel:SetText("Runtime: "..ConvertTime(workspace.DistributedGameTime))

		local_delta_value = 0
	end

	PlayersCountLabel:SetText(`Players: {ServerInfo.PlayersCount}/{ServerInfo.MaxPlayersCount}`)

	local Character = plr.Character
	if Character then
		if cfg.Misc.AntiFling then
			for _, i in PlayersContainer do
				if i == plr then continue end

				local Character = i.Character
				if Character then
					for _, i in Character:GetChildren() do
						if i and i:IsA("BasePart") and i.CanCollide then
							i.CanCollide = false
						end
					end
				end
			end
		end

		if cfg.Misc.Noclip then
			for _, i in plr.Character:GetDescendants() do
				if i:IsA("BasePart") and i.CanCollide then
					i.CanCollide = false
				end
			end
		end
	end
end)

table.insert(g_connections, workspace.DescendantAdded:Connect(function(Object)
	if IsObjectAlive(Object) and Object.Name == "GunDrop" then
		c_dropped_gun = Object

		if cfg.GunUtility.HighlightGun then
			setHighlight(Object)
		end

		if cfg.GunUtility.AutoGunTaking then
			TakeGun(Object)
		end
	end
end))

while task.wait(0.01) do
	if IsThreadQueueToDestroy() then
		break
	end

	if not cfg.Autofarm.Enabled then
		if c_bodyvelocity then
			c_bodyvelocity:Destroy()
		end

        StatusLabel:SetText("Status: Disabled")

		task.wait(1)

		continue
	end

	if not CoinContainer or (CoinContainer and CoinContainer.Parent == nil) then
        CoinContainer = FeatchObject(workspace, "CoinContainer", "Model")
    end

	if not CoinCounter or (CoinCounter and CoinCounter.Parent == nil) then
        CoinCounter = FeatchObject(PlayerGui, "SnowToken", "Frame")
    end
	
	if not IsReadyToFarm() then StatusLabel:SetText("Status: Waiting game...") task.wait(1) continue end

	if IsCoinsBagFull() then
		if cfg.Autofarm.DeathOnMaxCoins then
			local Humanoid = GetHumanoidFromPlayer(plr)
			if Humanoid then
				Humanoid.Health = 0
			end
		end

        StatusLabel:SetText("Status: Coins bag is full!")

		continue
	end

	local RootPart = GetRootPart()
	if not RootPart then StatusLabel:SetText("Status: Player is dead!") continue end

	SetBodyVelocity(RootPart)

	local Coin, Time = GetNearestCoin(RootPart)
	if not Coin then continue end
	if not IsCoinAlive(Coin) then continue end

    StatusLabel:SetText("Status: Farming coins...")

	local Tween = TweenService:Create(RootPart, TweenInfo.new(
		Time,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.In,
		0,
		false,
		0
	), {
		CFrame = CFrame.new(Coin.Position)
	})

	Tween:Play()

	c_tween = Tween

    repeat task.wait(0.1)
    until Tween.PlaybackState == Enum.PlaybackState.Playing or IsThreadQueueToDestroy() or not IsCoinAlive(Coin)

	if not IsCoinAlive(Coin) then continue end

    local lastTick = tick()

    repeat task.wait(0.1)
    until tick() - lastTick > 1 or IsThreadQueueToDestroy() or not IsCoinAlive(Coin)
end
