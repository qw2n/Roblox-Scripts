-- by Qwar1e

local Players = game:GetService("Players")

local plr = Players.LocalPlayer

local Kicks = {
	new = plr.Kick,
	old = plr.kick
}

while task.wait(0.5) do
	local lastTick, isDone, isDetected = tick(), false, false

	local Thread = coroutine.create(function()
		if xpcall(function()
				for _, Kick in Kicks do
					Kick(123)
				end

				return true, print("[INFO]: Anti-Kick Detected! 0x1")
			end, function()
				return false
			end)
		then
			isDetected = true
			isDone = true
			
			return
		end

		if xpcall(function()
				for _, Kick in Kicks do
					Kick(workspace)
				end

				return true, print("[INFO]: Anti-Kick Detected! 0x2")
			end, function()
				return false
			end)
		then
			isDetected = true
			isDone = true

			return
		end

		if xpcall(function()
				for _, Kick in Kicks do
					Kick("")
				end

				return true, print("[INFO]: Anti-Kick Detected! 0x3")
			end, function()
				return false
			end)
		then
			isDetected = true
			isDone = true

			return
		end

		if xpcall(function()
				for _, Kick in Kicks do
					Kick({})
				end

				return true, print("[INFO]: Anti-Kick Detected! 0x4")
			end, function()
				return false
			end)
		then
			isDetected = true
			isDone = true

			return
		end

		if xpcall(function()
				for _, Kick in Kicks do
					Kick(nil)
				end

				return true, print("[INFO]: Anti-Kick Detected! 0x5")
			end, function()
				return false
			end)
		then
			isDetected = true
			isDone = true

			return
		end

		if xpcall(function()
				local Object = newproxy(true)
				local meta = getmetatable(Object) do
					meta.__eq = error
					meta.__lt = error
					meta.__le = error
					meta.__add = error
					meta.__sub = error
					meta.__mul = error
					meta.__div = error
					meta.__mod = error
					meta.__pow = error
					meta.__unm = error
					meta.__len = error
					meta.__call = error
					meta.__index = error
					meta.__concat = error
					meta.__tostring = error
					meta.__newindex = error
				end

				for _, Kick in Kicks do
					Kick(Object)
				end

				return false
			end, function(msg)
				if msg ~= "Expected ':' not '.' calling member function Kick" then
					return true, warn("[INFO]: Anti-Kick Detected! 0x6")
				end
			end)
		then
			isDetected = true
			isDone = true

			return
		end

		if xpcall(function()
				plr:kIcK()

				return true, warn("[INFO]: Anti-Kick Detected! 0x7")
			end, function()
				return false
			end)
		then
			isDetected = true
			isDone = true

			return
		end
		
		isDone = true
	end)
	
	coroutine.resume(Thread)

	while not isDone and task.wait(1) do
		if tick()-lastTick > 5 then
			coroutine.close(Thread)

			warn("[INFO]: Anti-Kick Detected! 0x9")
		end
	end

	if not isDetected then
		print("[INFO]: OK")
	end
end
