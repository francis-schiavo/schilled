SchilledEletrician = {}
SchilledEletrician.OnTest = {}

SchilledEletrician.OnTest.LightBulbColor = function(item, player)
    if item:getType() ~= "LightBulb" then
        return true
    end

    return item:getColor() ~= Color.white
end
