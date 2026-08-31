SchilledMetalworker = {}
SchilledMetalworker.OnCreate = {}

function SchilledMetalworker.OnCreate.RefillBlowTorch(craftRecipeData, character)
    local blowTorch = nil;
    local propaneTank = nil;

    local inputItems = craftRecipeData:getAllInputItems();

    for i=0, inputItems:size()-1 do
        if inputItems:get(i):getType() == "BlowTorch" then
            blowTorch = inputItems:get(i);
        elseif inputItems:get(i):getType() == "PropaneTank" then
            propaneTank = inputItems:get(i);
        end
    end
    missingUses = blowTorch:getMaxUses() - blowTorch:getCurrentUsesFloat();
    availableUses = propaneTank:getMaxUses() - propaneTank:getCurrentUsesFloat() * 2;
    delta = math.min(missingUses, availableUses);

    propaneTank:setCurrentUses(propaneTank:getCurrentUses() - (delta / 2));
    blowTorch:setCurrentUses(blowTorch:getCurrentUses() + delta);
end
