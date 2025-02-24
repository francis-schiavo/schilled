Schilled = {}

function Schilled:AddExistingItemType(scriptItems, type)
    local all = getScriptManager():getItemsByType(type)
    for i=1,all:size() do
        local scriptItem = all:get(i-1)
        if not scriptItems:contains(scriptItem) then
            scriptItems:add(scriptItem)
        end
    end
end

function Schilled:AddProceduralDistribution(item, chance, storages)
    local distributionList = ProceduralDistributions.list

    for i, storage in ipairs(storages) do
        local storageList = distributionList[storage]
        if not storageList then
            distributionList[storage] = {}
            distributionList[storage].items = {}
            storageList = distributionList[storage]
        end
        table.insert(storageList.items, item)
        table.insert(storageList.items, chance)
    end
end

function Recipe.OnGiveXP.Tailoring(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Tailoring, 15);
end
