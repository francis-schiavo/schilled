require("TimedActions/ISWashYourself")
require("TimedActions/ISWashClothing")

local oldSoapRemaining = ISWashClothing.GetSoapRemaining

function ISWashClothing.GetSoapRemaining(soaps, character)
    -- Allow a sponge to replace soaps
    if character then
        local inventory = character:getInventory()
        local sponge = inventory:contains("Sponge")
        if sponge then
            return 100
        end
    end

    return oldSoapRemaining(soaps)
end

function ISWashYourself:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	local waterUnits = math.min(ISWashYourself.GetRequiredWater(self.character), self.sink:getFluidAmount());
	if self.soaps:isEmpty() then
		return waterUnits * 55;
	else
		return waterUnits * 30;
	end
end

function ISWashYourself:new(character, sink)
	local o = ISBaseTimedAction.new(self, character)
	o.sink = sink;
	o.soaps = character:getInventory():getSoapList(nil, false)
	o.useSoap = (ISWashYourself.GetRequiredSoap(character) <= ISWashClothing.GetSoapRemaining(o.soaps))
	o.maxTime = o:getDuration();
	o.forceProgressBar = true;
	return o;
end
