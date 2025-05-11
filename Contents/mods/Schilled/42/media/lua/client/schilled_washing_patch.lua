require("TimedActions/ISWashYourself")

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
    if not self.useSoap then
        return waterUnits * 55;
    else
        return waterUnits * 30;
    end
end

function ISWashYourself:new(character, sink, soaps)
    local o = ISBaseTimedAction.new(self, character)
    o.sink = sink;
    o.soaps = soaps;
    o.useSoap = (ISWashYourself.GetRequiredSoap(character) <= ISWashClothing.GetSoapRemaining(soaps, character))
    o.maxTime = o:getDuration();
    o.forceProgressBar = true;
    return o;
end
