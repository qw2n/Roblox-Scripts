-- by Qwar1e

local _game = game

local GetService do
	local oGetService, oFindService = _game.GetService, _game.FindService
	
	local __services = {}
	
	GetService = (function(Name: string): Instance
		local CachedService = __services[Name]
		if CachedService then
			return CachedService
		end
		
		local Service = oFindService(_game, Name) or oGetService(_game, Name)
		if Service then
			__services[Name] = Service
		end
		
		return Service
	end)
end

print(
	GetService("Players")
)
