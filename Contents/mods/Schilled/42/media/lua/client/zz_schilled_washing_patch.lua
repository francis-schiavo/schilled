require("TimedActions/ISWashYourself")

local oldGetDuration = ISWashYourself.getDuration

function ISWashYourself:getDuration()
    local duration = oldGetDuration(self)
	return math.max(duration, 50)
end
