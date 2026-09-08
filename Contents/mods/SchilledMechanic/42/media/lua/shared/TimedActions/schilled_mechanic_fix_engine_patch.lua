require("TimedActions/ISRepairEngine")

local original_ISRepairEngine_complete = ISRepairEngine.complete

function ISRepairEngine:complete()
    original_ISRepairEngine_complete(self)
    local script = self.vehicle:getScript()

    local engineLoudness = script:getEngineLoudness() or 100;
    engineLoudness = engineLoudness * (SandboxVars.ZombieAttractionMultiplier or 1);
    local enginePower = script:getEngineForce() * 1.6;

    if self.part:getCondition() >= 100 then
        self.vehicle:setEngineFeature(100, engineLoudness, enginePower);
    end
end
