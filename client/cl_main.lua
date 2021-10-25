QBCore = exports['qb-core']:GetCoreObject() -- Core

n = RegisterNetEvent -- I'm lazy
t = Translation[Config.Translation] -- For translations (even lazier)
ped = PlayerPedId() -- Player ped
settings = Config.Settings


n('QBCore:Client:OnPlayerLoaded', function() -- Core stuff
    PlayerData = QBCore.Functions.GetPlayerData()
end)

n('QBCore:Client:OnJobUpdate', function(JobInfo) -- Core stuff
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerData.job = JobInfo
end)

CreateThread(function() -- Thread to handle original context menu setup
    while not LocalPlayer.state['isLoggedIn'] do
        Wait(500)
    end
    if LocalPlayer.state['isLoggedIn'] then 
        setupContext()
    end
end)

if Config.debug then 
    RegisterCommand('hayden:test', function() -- debug command
        TriggerServerEvent('hayden:test')
    end, false)
end

n('qb-vanillaunicorn:accessBarMenu', function(data) -- Access bar menu, exploit checks
    canUse = data.args.canUse
    plyCoords = GetEntityCoords(ped)

    for i, v in pairs(settings) do
        local barCoords = vector3(settings[i]['barSettings'].coords.x, settings[i]['barSettings'].coords.y, settings[i]['barSettings'].coords.z)  
        if canUse and #(plyCoords - barCoords) < 5 then 
            exports["qb-menu"]:openMenu(barMenu)
        else
            print("User is attempting to access menu whilst not near - exploit")
        end
    end
end)

n('qb-vanillaunicorn:purchaseDrink', function(data) -- purchase drinks, exploit check
    name = data.type.name
    price = data.type.price

    if name and price then 
        barConfirmation = {
            {
                header = t['confirmDrink'] .. name .. "?",
                isMenuHeader = true,
            },
            {
                header = t['yes'],
                txt = 'This will cost $' .. price .. '',
                params = {
                    isServer = true,
                    event = "qb-vanillaunicorn:handleItem",
                    args = {
                        type = data.type.item,
                        amount = data.type.amount, 
                        price = data.type.price, 
                    }
                }
            },
            {
                header = t['no'],
                txt = ' ',
                params = {
                    event = "",
                }
            },
            {
                header = t['goBack']
            },
        }

        exports["qb-menu"]:openMenu(barConfirmation)  
    else
        print("How did you get here?")
    end
end)

n('qb-vanillaunicorn:barMenu', function() -- Open bar menu
    exports["qb-menu"]:openMenu(drinks)
end)

n('qb-vanillaunicorn:employeeManagement', function() -- Open boss menu
    exports["qb-menu"]:openMenu(bossMenu)
end)