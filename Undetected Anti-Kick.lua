-- by BinaryCrypt
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/Undetected%20Anti-Kick.lua"))()

assert(cloneref, "Your executor not supported 'cloneref'")
assert(clonefunction, "Your executor not supported 'clonefunction'")
assert(hookmetamethod, "Your executor not supported 'hookmetamethod'")
assert(newcclosure, "Your executor not supported 'newcclosure'")
assert(getnamecallmethod, "Your executor not supported 'getnamecallmethod'")
assert(hookfunction, "Your executor not supported 'hookfunction'")

local Players = cloneref(game:GetService("Players")) :: Players

local plr = Players.LocalPlayer

local oldKick, oldRemove, oldDestroy = clonefunction(plr.Kick), clonefunction(game.Remove), clonefunction(game.Destroy)

local oldcall; oldcall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local a = {...}

    local namecall = getnamecallmethod() :: string
    if (namecall == "Kick" or namecall == "kick") and a[1] == plr then
        warn("Trying kick with namecall with message:", a[2])

        return

    elseif (namecall == "Remove" or namecall == "remove") and a[1] == plr then
        warn("Trying remove player from game using by namecall")

        return

    elseif (namecall == "Destroy" or namecall == "destroy") and a[1] == plr then
        warn("Trying destroy player from game using by namecall")

        return
    end

    return oldcall(...)
end))

hookfunction(plr.Kick, newcclosure(function(self: Player, message: string)
    if not self then
        error("Expected ':' not '.' calling member function Kick", 2)
    end

    if type(self) ~= "userdata" then
        error("Expected ':' not '.' calling member function Kick", 2)
    end

    if not self:IsA("Player") then
        error("Expected ':' not '.' calling member function Kick", 2)
    end

    if self == plr then
        warn("Trying kick without namecall with message:", message)

        return
    end

    oldKick(self, message)

    return
end))

hookfunction(game.Destroy, newcclosure(function(self: Instance)
    if not self then
        error("Expected ':' not '.' calling member function Destroy", 2)

        return
    end

    if typeof(self) ~= "Instance" then
        error("Expected ':' not '.' calling member function Destroy", 2)

        return
    end

    if self:IsA("Player") and self == plr then
        warn("Trying destroy player from game without namecall")

        return
    end

    oldDestroy(self)

    return
end))

hookfunction(game.Remove, newcclosure(function(self: Instance)
    if not self then
        error("Expected ':' not '.' calling member function Remove", 2)
    end

    if typeof(self) ~= "Instance" then
        error("Expected ':' not '.' calling member function Remove", 2)
    end

    if self:IsA("Player") and self == plr then
        warn("Trying remove player from game without namecall")

        return
    end

    oldRemove(self)

    return
end))
