Schilled = {}

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
