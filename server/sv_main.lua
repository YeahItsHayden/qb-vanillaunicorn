QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-vanillaunicorn:Server:handleItem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = data.type 
    local amount = data.amount 
    local price = data.price
    local plyCoords = GetEntityCoords(GetPlayerPed(src))
    local enough = Player.Functions.GetMoney('cash') >= price

    if item and amount and price then
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

QBCore.Commands.Add('invoice', 'Invoice A Player', {{
    name = 'id',
    help = 'Player ID'
}, {
    name = 'amount',
    help = 'Invoice Amount'
}}, false, function(source, args)
    local worker = QBCore.Functions.GetPlayer(source)
    local customer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local amount = tonumber(args[2])

    if worker.PlayerData.job.name == "vu" then 
        if customer then
            if worker.PlayerData.citizenid ~= customer.PlayerData.citizenid then
                if amount and amount > 0 then
                    exports.oxmysql:insert(
                        'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',
                        {customer.PlayerData.citizenid, amount, worker.PlayerData.job.name,
                        worker.PlayerData.charinfo.firstname, worker.PlayerData.citizenid})
                    TriggerClientEvent('qb-phone:RefreshPhone', customer.PlayerData.source)
                    TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
                    TriggerClientEvent('QBCore:Notify', customer.PlayerData.source, 'New Invoice Received')
                else
                    TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'You Cannot Invoice Yourself', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error')
    end
end)