-- by BinaryCrypt (Aka Qwar1e)
-- Discord: binarycrypt
-- Discord Server: https://discord.gg/pY6nDej76m

-- Script: loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/Script%20for%20Executors/Anti-Kick.luau"))()

local function check(a, er)
	if not a then
		error(er)
	end
	
	return a
end

local cloneref = check(cloneref, "Your executor not supported 'cloneref'")
local newcclosure = check(newcclosure, "Your executor not supported 'newcclosure'")
local hookfunction = check(hookfunction, "Your executor not supported 'hookfunction'")
local iscalledfromroblox = check(checkcaller, "Your executor not support 'checkcaller'")
local hookmetamethod = check(hookmetamethod, "Your executor not supported 'hookmetamethod'")
local getnamecallmethod = check(getnamecallmethod, "Your executor not supported 'getnamecallmethod'")

local TeleportService = cloneref(game:GetService("TeleportService")) :: TeleportService
local Players = cloneref(game:GetService("Players")) :: Players

local plr = Players.LocalPlayer

local owarn = warn
local warn = newcclosure(function(...)
    owarn("[!]", ...)
end)

local __namecall; __namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    if iscalledfromroblox() then
       local args = {...}
    
        local namecall = getnamecallmethod() :: string
        if self == plr then
            if namecall == "Kick" or namecall == "kick" then
                return warn("Trying kick player from game using by namecall with message:", args[1])

            elseif namecall == "Remove" or namecall == "remove" then
                return warn("Trying remove player from game using by namecall")

            elseif namecall == "Destroy" or namecall == "destroy" then
                return warn("Trying destroy player from game using by namecall")
            end

        elseif self.ClassName == "TeleportService" then
            if namecall == "Teleport" or namecall == "teleport" then
                return warn("Trying to use 'TeleportService:Teleport' to kick player from game with namecall |", ...)
            
            elseif namecall == "TeleportAsync" then
                return warn("Trying to use 'TeleportService:TeleportAsync' to kick player from game with namecall |", ...)

            elseif namecall == "TeleportPartyAsync" then
                return warn("Trying to use 'TeleportService:TeleportPartyAsync' to kick player from game with namecall |", ...)

            elseif namecall == "TeleportToPlaceInstance" then
                return warn("Trying to use 'TeleportService:TeleportToPlaceInstance' to kick player from game with namecall |", ...)

            elseif namecall == "TeleportToPrivateServer" then
                return warn("Trying to use 'TeleportService:TeleportToPrivateServer' to kick player from game with namecall |", ...)

            elseif namecall == "TeleportToSpawnByName" then
                return warn("Trying to use 'TeleportService:TeleportToSpawnByName' to kick player from game with namecall |", ...)
            end
        end 
    end

	return __namecall(self, ...)
end))

local Kick; Kick = hookfunction(plr.Kick, newcclosure(function(self: Player, message: string)
	if iscalledfromroblox() and self == plr then
		return warn("Trying kick without namecall with message:", message)
	end

	return Kick(self, message)
end))

local Destroy; Destroy = hookfunction(game.Destroy, newcclosure(function(self: Instance)
	if iscalledfromroblox() and self == plr then
		return warn("Trying destroy player from game without namecall")
	end

	return Destroy(self)
end))

local Remove; Remove = hookfunction(game.Remove, newcclosure(function(self: Instance)
	if iscalledfromroblox() and self == plr then
		return warn("Trying remove player from game without namecall")
	end

	return Remove(self)
end))

--// Teleport Service \\--

local Teleport; Teleport = hookfunction(TeleportService.Teleport, newcclosure(function(self: TeleportService, ...)
    local args = {...}
    if iscalledfromroblox() and args[2] == plr then
        return warn("Trying to use 'TeleportService:Teleport' to kick player from game without namecall |", ...)
    end

    return Teleport(self, ...)
end))

local TeleportAsync; TeleportAsync = hookfunction(TeleportService.TeleportAsync, newcclosure(function(self: TeleportService, ...)
    local args = {...}
    if iscalledfromroblox() and args[2] and typeof(args[2]) == "table" and table.find(args[2], plr) then
        return warn("Trying to use 'TeleportService:TeleportAsync' to kick player from game without namecall |", ...)
    end

    return TeleportAsync(self, ...)
end))

local TeleportPartyAsync; TeleportPartyAsync = hookfunction(TeleportService.TeleportPartyAsync, newcclosure(function(self: TeleportService, ...)
    local args = {...}
    if iscalledfromroblox() and args[2] and typeof(args[2]) == "table" and table.find(args[2], plr) then
        return warn("Trying to use 'TeleportService:TeleportPartyAsync' to kick player from game without namecall |", ...)
    end

    return TeleportPartyAsync(self, ...)
end))

local TeleportToPlaceInstance; TeleportToPlaceInstance = hookfunction(TeleportService.TeleportToPlaceInstance, newcclosure(function(self: TeleportService, ...)
    local args = {...}
    if iscalledfromroblox() and args[3] == plr then
        return warn("Trying to use 'TeleportService:TeleportToPlaceInstance' to kick player from game without namecall |", ...)
    end

    return TeleportToPlaceInstance(self, ...)
end))

local TeleportToPrivateServer; TeleportToPrivateServer = hookfunction(TeleportService.TeleportToPrivateServer, newcclosure(function(self: TeleportService, ...)
    local args = {...}
    if iscalledfromroblox() and args[3] and typeof(args[3]) == "table" and table.find(args[3], plr) then
        return warn("Trying to use 'TeleportService:TeleportToPrivateServer' to kick player from game without namecall |", ...)
    end

    return TeleportToPrivateServer(self, ...)
end))

local TeleportToSpawnByName; TeleportToSpawnByName = hookfunction(TeleportService.TeleportToSpawnByName, newcclosure(function(self: TeleportService, ...)
    local args = {...}
    if iscalledfromroblox() and args[3] == plr then
        return warn("Trying to use 'TeleportService:TeleportToSpawnByName' to kick player from game without namecall |", ...)
    end

    return TeleportToSpawnByName(self, ...)
end))
