-- by BinaryCrypt (Aka Qwar1e)
-- Discord: binarycrypt
-- Discord Server: https://discord.gg/pY6nDej76m

-- Script: loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/Script%20for%20Executors/Binary%20MM2.luau"))()

local function check(a, b): any
    if not a then
        error(b, 2)
    end

    return a
end

local getgenv = check(getgenv, "Your executor not support 'getgenv'")
local cloneref = check(cloneref, "Your executor not support 'cloneref'")
local setclipboard = check(setclipboard, "Your executor not support 'setclipboard'")

local g_const_huge = math.huge
local g_kill_mainthread = false

local c_tween = nil
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
		Enabled = false
	},

	Misc = {
		Noclip = false,
		AntiFling = false
	}
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

local function IsCoinAlive(Coin: Part): boolean
	return Coin and Coin:FindFirstChild("CoinVisual") and Coin.CoinVisual.Transparency == 0
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
		Time < 1.2 then 0.1
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

genv.BinaryMM2 = {
	Destroy = function()
		g_kill_mainthread = true

		if c_tween then
			c_tween:Cancel()
		end

		if c_bodyvelocity then
			c_bodyvelocity:Destroy()
		end

		for _, i in Players:GetPlayers() do
			FixCharacterCollisions(i)
		end
	end
}

local __module = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau")
	--readfile("ui_library.txt")
)()

local Window = __module:MakeWindow({
	name = "Binary MM2 | v1.0.1",
	theme = "Metalic",

	sizeX = 330,
	sizeY = 400,
}) 

local StatusLabel do
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

            section:MakeButton({
                Text = "Copy discord link",

				callback = function()
					setclipboard("https://discord.gg/pY6nDej76m")
				end
            })
        end
    end

	local tab = Window:MakeTab({
		Text = "Main"
	}) do
		local NoclipButton, AntiFlingButton

		local section = tab:MakeSection({
			Text = "AutoFarm",
			Column = 1
		}) do
            section:MakeToggle({
                Text = "Enable",
                Flag = cfg.Autofarm.Enabled,
                callback = function(v: boolean)
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
        end

		local section = tab:MakeSection({
			Text = "Misc",
			Column = 2
		}) do
			NoclipButton = section:MakeToggle({
				Text = "Noclip",
				Flag = cfg.Misc.Noclip,
				callback = function(v)
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
		end
	end
end

local connection; connection = RunService.RenderStepped:Connect(function()
	if IsThreadQueueToDestroy() then
		return connection:Disconnect()
	end

	local Character = plr.Character
	if Character then
		if cfg.Misc.AntiFling then
			for _, i in Players:GetPlayers() do
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

while task.wait(0.01) do
	if IsThreadQueueToDestroy() then
		break
	end

	if not cfg.Autofarm.Enabled then
		if c_bodyvelocity then
			c_bodyvelocity:Destroy()
		end

        StatusLabel:SetText("Status: Disabled")

		continue
	end

	if not CoinContainer or (CoinContainer and CoinContainer.Parent == nil) then
        CoinContainer = FeatchObject(workspace, "CoinContainer", "Model")
    end

	if not CoinCounter or (CoinCounter and CoinCounter.Parent == nil) then
        CoinCounter = FeatchObject(PlayerGui, "SnowToken", "Frame")
    end
	
	if not IsReadyToFarm() then StatusLabel:SetText("Status: Waiting game...") continue end

	if IsCoinsBagFull() then
		local Humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			Humanoid.Health = 0
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
		CFrame = Coin.CFrame
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
