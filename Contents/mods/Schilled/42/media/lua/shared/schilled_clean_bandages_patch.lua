require "TimedActions/ISWashClothing"

local oldGetRequiredWater = ISWashClothing.GetRequiredWater

local bandages = { "Base.BandageDirty", "Base.RippedSheetsDirty", "Base.DenimStripsDirty", "Base.LeatherStripsDirty" }

function bandages:contains(itemType)
    for _, v in ipairs(self) do
        if itemType == v then
            return true
        end
    end
    return false
end

function ISWashClothing.GetRequiredWater(item)
    if bandages:contains(item:getFullType()) then
        return 0.2
    end

    local amount = oldGetRequiredWater(item)
	if amount > 1 then
        amount = 1
    end
    return amount
end

function ISWashClothing:getDuration()
    if self.character:isTimedActionInstant() then
		return 1;
	end

	local maxTime = ((self.bloodAmount + self.dirtAmount) * 15);
	if maxTime > 80 then
		maxTime = 80;
	end

	if self.noSoap == true then
		maxTime = maxTime * 5;
	end

	if maxTime > 100 then
		maxTime = 100;
	end

	if maxTime < 10 then
		maxTime = 10;
	end

	return self:adjustMaxTime(maxTime);
end
