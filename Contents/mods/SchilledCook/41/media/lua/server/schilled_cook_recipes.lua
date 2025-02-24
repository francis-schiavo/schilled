function Recipe.GetItemTypes.Vinegar(scriptItems)
    scriptItems:addAll(getScriptManager():getItemsTag("Vinegar"))
    Schilled:AddExistingItemType(scriptItems, "RiceVinegar")
    Schilled:AddExistingItemType(scriptItems, "Vinegar")
end

function Recipe.OnCreate.OpenCannedFood(items, result, player)
    local jar = items:get(0);
    local aged = jar:getAge() / jar:getOffAgeMax();

    result:setAge(result:getOffAgeMax() * aged);

    player:getInventory():AddItem("Base.EmptyJar");
    player:getInventory():AddItem("Base.JarLid");
end

function Recipe.OnCreate.ReturnLid(items, result, player)
    player:getInventory():AddItem("Base.JarLid");
end

function Recipe.OnCreate.OpenCannedFoodHomeMade(items, result, player)
    player:getInventory():AddItem("SchilledCook.ImprovisedLid");
end
