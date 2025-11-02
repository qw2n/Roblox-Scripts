-- by BinaryCrypt

local Players = game:GetService("Players")

local plr = Players.LocalPlayer
local Kick = plr.Kick

while task.wait(0.5) do
    local lastTick, isDone = tick(), false

    local Thread = coroutine.create(function()
        xpcall(function()
            Kick(123)

            print("[INFO]: Anti-Kick Detected! 0x1")
        end, function()
            -- nothing
        end)

        xpcall(function()
            Kick(workspace)

            print("[INFO]: Anti-Kick Detected! 0x2")
        end, function()
            -- nothing
        end)

        xpcall(function()
            Kick("")

            print("[INFO]: Anti-Kick Detected! 0x3")
        end, function()
            -- nothing
        end)

        xpcall(function()
            Kick({})

            print("[INFO]: Anti-Kick Detected! 0x4")
        end, function()
            -- nothing
        end)

        xpcall(function()
            Kick(nil)

            print("[INFO]: Anti-Kick Detected! 0x5")
        end, function()
            -- nothing
        end)

        xpcall(function()
            local Object = newproxy(true)
            local meta = getmetatable(Object)
            meta.__index = function()
                error("asdasdasasasd")
            end
            
            meta.__tostring = function()
                error("asdasdasasasd")
            end

            Kick(Object)
        end, function(msg)
            if msg ~= "Expected ':' not '.' calling member function Kick" then
                warn("[INFO]: Anti-Kick Detected! 0x6")
            end
        end)

        xpcall(function()
            plr:kIcK()

            warn("[INFO]: Anti-Kick Detected! 0x7")
        end, function()
            -- nothing
        end)

        isDone = true
    end)

    coroutine.resume(Thread)

    while not isDone and task.wait(1) do
        if tick()-lastTick > 5 then
            coroutine.close(Thread)

            warn("[INFO]: Anti-Kick Detected! 0x8")
        end
    end

    print("[INFO]: OK")
end
