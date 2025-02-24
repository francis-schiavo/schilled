function Recipe.OnCreate.Repair_OnCreate(items, result, player)
    result:setCondition(result:getConditionMax())
end