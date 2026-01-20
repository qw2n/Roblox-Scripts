-- by BinaryCrypt (Aka Qwar1e)
-- Tested on Potassium
-- PATCHED

local __index, __newindex, __namecall

xpcall(function ()
    return game.__
end, function ()
    __index = debug.info(2, "f")
end)

xpcall(function ()
    game.__ = 10
end, function ()
    __newindex = debug.info(2, "f")
end)

xpcall(function ()
    game.__()
end, function ()
    __namecall = debug.info(2, "f")
end)

while task.wait() do
    local s, r = pcall(__index, 123)
    if r ~= "invalid argument #1 (Instance expected, got number)" then
        print("__index detected | hookmetamethod")
    end

    local s, r = pcall(__newindex, 123)
    if r ~= "invalid argument #1 (Instance expected, got number)" then
        print("__newindex detected | hookmetamethod")
    end

    local s, r = pcall(__namecall, 123)
    if r ~= "invalid argument #1 (Instance expected, got number)" then
        print("__namecall detected | hookmetamethod")
    end
end
