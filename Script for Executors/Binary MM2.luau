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

local getgenv = check(getgenv, "Your executor not support getgenv")
local cloneref = check(cloneref, "Your executor not support cloneref")

local g_huge = math.huge
local g_kill_mainthread = false

local c_tween = nil
local c_bodyvelocity = nil

local genv = getgenv()

if genv.AutoFarmer then
	genv.AutoFarmer.Destroy()
end

genv.AutoFarmer = {
	Destroy = function()
		g_kill_mainthread = true

		if c_tween then
			c_tween:Cancel()
		end

		if c_bodyvelocity then
			c_bodyvelocity:Destroy()
		end
	end
}

local TweenService = cloneref(game:GetService("TweenService")) :: TweenService
local Players = cloneref(game:GetService("Players")) :: Players

local plr = Players.LocalPlayer
local PlayerGui = plr.PlayerGui

local cfg = {
	Autofarm = {
		Enabled = false
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
	if not RootPart then print("rootpart not found") return nil end
	if not CoinContainer then print("CoinContainer not found") return nil end

	local lastCoin = nil
	local lastDistance = g_huge

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
		Time < 1 then 0.1
		else 1
end

local __module = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau")
	--readfile("ui_library.txt")
)()

local Window = __module:MakeWindow({
	name = "Binary MM2 | v1.0.0",
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
			Text = "AutoFarm",
			Column = 1
		})

		section:MakeToggle({
			Text = "Enabled",
			Flag = cfg.Autofarm.Enabled,
			callback = function(v: boolean)
				cfg.Autofarm.Enabled = v

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
	end
end

while task.wait() do
	if IsThreadQueueToDestroy() then
		break
	end

	if not cfg.Autofarm.Enabled then
		if c_bodyvelocity then
			c_bodyvelocity:Destroy()
		end

		continue
	end

	CoinContainer = FeatchObject(workspace, "CoinContainer", "Model")
	CoinCounter = FeatchObject(PlayerGui, "SnowToken", "Frame")
	
	if not IsReadyToFarm() then continue end

	if IsCoinsBagFull() then
		local Humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			Humanoid.Health = 0
		end

		continue
	end

	local RootPart = GetRootPart()
	if not RootPart then continue end

	SetBodyVelocity(RootPart)

	local Coin, Time = GetNearestCoin(RootPart)
	if not Coin then continue end
	if not IsCoinAlive(Coin) then continue end

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

	while Tween.PlaybackState == Enum.PlaybackState.Playing and task.wait(0.1) do
		if IsThreadQueueToDestroy() then
			break
		end

		if not IsCoinAlive(Coin) then
			break
		end
	end

	if not IsCoinAlive(Coin) then continue end

	local lastTick = tick()
	while tick() - lastTick > 1 and task.wait(0.1) do
		if IsThreadQueueToDestroy() then
			break
		end

		if not IsCoinAlive(Coin) then
			break
		end
	end
end
