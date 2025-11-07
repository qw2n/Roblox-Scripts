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

local game: typeof(game) = setmetatable({}, {
	__index = function(self, key)
		if key == "GetService" or key == "FindService" then
			return function(self, Name: string)
				return GetService(Name)
			end
		end
		
		return _game[key]
	end,
})

print(
	game:GetService("Players"),
	game:FindService("Players")
)
