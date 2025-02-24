require("TimedActions/ISInflateTire")

function ISInflateTire:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    local multiplier = 100 - (self.character:getPerkLevel(Perks.Mechanics) * 10)
    if multiplier <= 5 then
        multiplier = 5
    end
    return math.ceil(self.psiTarget - self.part:getContainerContentAmount()) * multiplier
end