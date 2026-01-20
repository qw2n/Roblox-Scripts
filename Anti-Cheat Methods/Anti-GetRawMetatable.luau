-- by BinaryCrypt (Aka Qwar1e)
-- Tested on Potassium

local __index, __newindex, __namecall

xpcall(function ()
    return game.______
end, function ()
    __index = debug.info(2, "f")
end)

xpcall(function ()
    game.______ = 1
end, function ()
    __newindex = debug.info(2, "f")
end)

xpcall(function ()
    game:______()
end, function ()
    __namecall = debug.info(2, "f")
end)

while task.wait(1) do
    xpcall(function ()
        return game.______
    end, function ()
        local index = debug.info(2, "f")
        if index ~= __index then
            print("__index detected | getrawmetatable")
        end
    end)

    xpcall(function ()
        game.______ = 1
    end, function ()
        local newindex = debug.info(2, "f")
        if newindex ~= __newindex then
            print("__newindex detected | getrawmetatable")
        end
    end)

    xpcall(function ()
        game:______()
    end, function ()
        local namecall = debug.info(2, "f")
        if namecall ~= __namecall then
            print("__namecall detected | getrawmetatable")
        end
    end)
end
