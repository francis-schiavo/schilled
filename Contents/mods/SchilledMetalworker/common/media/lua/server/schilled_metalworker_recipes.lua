function Recipe.OnCreate.RefillBlowTorch(items, result, player)
    local previousBT = nil;
    local propaneTank = nil;
    for i=0, items:size()-1 do
        if items:get(i):getType() == "BlowTorch" then
            previousBT = items:get(i);
        elseif items:get(i):getType() == "PropaneTank" then
            propaneTank = items:get(i);
        end
    end
    result:setUsedDelta(previousBT:getUsedDelta() + result:getUseDelta() * 200);

    while result:getUsedDelta() < 1 and propaneTank:getUsedDelta() > 0 do
        result:setUsedDelta(result:getUsedDelta() + result:getUseDelta() * 400);
        propaneTank:Use();
    end

    if result:getUsedDelta() > 1 then
        result:setUsedDelta(1);
    end
end

function Recipe.OnCreate.Repair_OnCreate(items, result, player)
    result:setCondition(result:getConditionMax())
end