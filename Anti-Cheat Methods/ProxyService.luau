-- by BinaryCrypt (Aka Qwar1e)

local module = {}

function module.new(Object: Instance)
	return setmetatable({
		__properties = {}	
	}, {
		__index = function(self, index)
			if not Object then
				return error("Object is nil!")
			end
			
			local ModuleProperty = module[index]
			if ModuleProperty then
				return ModuleProperty
			end
			
			local HiddenProperty = self.__properties[index]
			if HiddenProperty then
				return HiddenProperty
			end
			
			local Property = Object[index]
			if typeof(Property) == "function" then
				return function(self, ...)
					return Object[index](Object, ...)
				end
			end

			return Property
		end,
		
		__newindex = function(self, index, value)
			if not Object then
				return error("Object is nil!")
			end
			
			local ModuleProperty = module[index]
			if ModuleProperty then
				error(`Cannot set module property '{index}'`)
			end
			
			if self.__properties[index] ~= nil then
				self.__properties[index] = value
				
				return
			end
			
			Object[index] = value
		end,

        __tostring = function()
            return tostring(Object)
        end
	}) :: typeof(Object) & typeof(module)
end

function module:SetHiddenProperty(Property: string, Data: any)
	self.__properties[Property] = Data
end

function module:GetHiddenProperty(Property: string): any
	return self.__properties[Property]
end

function module:CallHiddenProperty(Property: string, ...): any
	local Call = self.__properties[Property]
	if Call then
		return Call(...)
	end
	
	return error(`Hidden caller '{Property}' is nil!`)
end

return module

----> Example <----

local ProxyService = require(
	script.ProxyService
)

local game = ProxyService.new(game)
local workspace = ProxyService.new(workspace)

print("Game Hidden namecall:", game:GetService("Players")) -- hidden for getnamecallmethod
print("Workspace Hidden namecall:", workspace:GetServerTimeNow()) -- hidden for getnamecallmethod

game:SetHiddenProperty("hidden", 123)

print(game:GetHiddenProperty("hidden"))

game:SetHiddenProperty("call hidden?", function(num: number)
	return 123 + num
end)

print(game:CallHiddenProperty("call hidden?", 3))

print(game["hidden"])
print(game["call hidden?"])

game.hidden = 10

print(game.hidden)
