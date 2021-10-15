QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-vanillaunicorn:handleItem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = data.type 
    local amount = data.amount 
    local price = data.price
    local plyCoords = GetEntityCoords(GetPlayerPed(src))
    local enough = Player.Functions.GetMoney('cash') >= price

    if #(plyCoords - Config.barCoords) < 10 and item and amount and price then
        if enough then 
            print("Giving item " .. item .. " which costs the player $" .. price)  
            Player.Functions.AddItem(item, amount, 10, nil) -- Adds the item
            Player.Functions.RemoveMoney('cash', price)
        else 
            print("Player doesn't have enough money")
        end 
    else
        print("Player with ID " .. source .. " attempted to give himself an item")
    end
    
end)