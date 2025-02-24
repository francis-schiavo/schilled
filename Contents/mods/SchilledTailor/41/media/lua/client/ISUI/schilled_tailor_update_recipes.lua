SchilledTailor = {}

function SchilledTailor.ChangeRecipes()
    local recipes = getAllRecipes()

    for i=0,recipes:size()-1 do
        local recipe = recipes:get(i)
        if recipe:getName() == "Rip Clothing" then
            if recipe:getTimeToMake() == 100 then
                recipe:setIsHidden(true)
                recipe:setNeedToBeLearn(true)
            end
        end
    end
end

Events.OnGameStart.Add(SchilledTailor.ChangeRecipes)