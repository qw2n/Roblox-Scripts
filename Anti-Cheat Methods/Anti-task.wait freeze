-- by Qwar1e

local RunService = game:GetService("RunService")

local Sleep = (function(Time: number): number --> will be faster then default task.wait and if task.wait will be hooked by exploit our script dont be break
	local Start = tick()

	local Result = nil do
		repeat Result = tick() - Start until Result >= Time and RunService.RenderStepped:Wait()
	end

	return Result
end)

while true do
	local lastTick = tick()

	local FreezeDetected = true

	local Thread = coroutine.create(function()
		task.wait(2)

		FreezeDetected = false
	end)

	coroutine.resume(Thread)

	while FreezeDetected and Sleep(1) do
		if tick()-lastTick >= 4 then
			break
		end
	end

	coroutine.close(Thread)

	if FreezeDetected then
		print("[INFO]: task.wait freeze detected")

		break
	end

	print("[OK]: task.wait not freezed")
end
