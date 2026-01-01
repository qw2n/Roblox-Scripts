-- by BinaryCrypt (Aka Qwar1e)

--[[

More explanation in my discord server

]]

local script_t = script

script = nil
script_t.Parent = nil
script_t = nil

getfenv().script = nil
for level = 0, 1 do
	getfenv(level).script = nil
end

local test = (function()
	return debug.info(2, "s")
end)

while task.wait(0.1) do
	print(test())
end
