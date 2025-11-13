-- by Qwar1e
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/Script%20for%20Executors/Anti-Kick.luau"))()

local function check(a, er)
	if not a then
		error(er)
	end
	
	return a
end

local cloneref = check(cloneref, "Your executor not supported 'cloneref'")
local newcclosure = check(newcclosure, "Your executor not supported 'newcclosure'")
local hookfunction = check(hookfunction, "Your executor not supported 'hookfunction'")
local hookmetamethod = check(hookmetamethod, "Your executor not supported 'hookmetamethod'")
local getnamecallmethod = check(getnamecallmethod, "Your executor not supported 'getnamecallmethod'")

local Players = cloneref(game:GetService("Players")) :: Players

local plr = Players.LocalPlayer

local __namecall; __namecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
	local a = {...}

	local namecall = getnamecallmethod() :: string
	if (namecall == "Kick" or namecall == "kick") and a[1] == plr then
		return warn("Trying kick with namecall with message:", a[2])

	elseif (namecall == "Remove" or namecall == "remove") and a[1] == plr then
		return warn("Trying remove player from game using by namecall")

	elseif (namecall == "Destroy" or namecall == "destroy") and a[1] == plr then
		return warn("Trying destroy player from game using by namecall")
	end

	return __namecall(...)
end))

local Kick; Kick = hookfunction(plr.Kick, newcclosure(function(self: Player, message: string)
	if self == plr then
		return warn("Trying kick without namecall with message:", message)
	end

	return Kick(self, message)
end))

local Destroy; Destroy = hookfunction(game.Destroy, newcclosure(function(self: Instance)
	if self == plr then
		return warn("Trying destroy player from game without namecall")
	end

	return Destroy(self)
end))

local Remove; Remove = hookfunction(game.Remove, newcclosure(function(self: Instance)
	if self == plr then
		return warn("Trying remove player from game without namecall")
	end

	return Remove(self)
end))
