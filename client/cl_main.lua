QBCore = exports['qb-core']:GetCoreObject() -- Core

n = RegisterNetEvent -- I'm lazy
t = Translation[Config.Translation] -- For translations (even lazier)
ped = PlayerPedId() -- Player ped
settings = Config.Settings
onDuty = false

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        PlayerData = QBCore.Functions.GetPlayerData()
        onDuty = PlayerData.job.onduty
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() -- Core stuff
    PlayerData = QBCore.Functions.GetPlayerData()
    onDuty = PlayerData.job.onduty
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo) -- Core stuff
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerData.job = JobInfo
    onDuty = PlayerData.job.onduty
end)

RegisterNetEvent('qb-vanillaunicorn:Client:signOn', function()
    if LocalPlayer.state['isLoggedIn'] and PlayerData.job.name == "vu" then 
        TriggerServerEvent("QBCore:ToggleDuty")
    end
end)

RegisterNetEvent('qb-vanillaunicorn:Client:stash', function()
    if onDuty and PlayerData.job.name == "vu" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "vustash_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "vustash_"..QBCore.Functions.GetPlayerData().citizenid)
    end
end)

CreateThread(function() -- Thread to handle original context menu setup
    setupContext()
   
    while true do
        Wait(0)
        plyCoords = GetEntityCoords(ped)

        for k, v in pairs(settings) do
            local barCoords = vector3(settings[k]['barSettings'].coords.x, settings[k]['barSettings'].coords.y, settings[k]['barSettings'].coords.z)  
            local barHash = settings[k]['barSettings'].hash
            local barHeading = settings[k]['barSettings'].coords.w

            if #(plyCoords - barCoords) < 25 then
                if not madeBar then  

                    RequestModel(barHash)
        
                    while not HasModelLoaded(barHash) do
                        Wait(1)
                    end
                    
                    bartender = CreatePed(4, barHash , barCoords, barHeading, false, true)
                    SetEntityAsMissionEntity(bartender, true, true)
                    SetBlockingOfNonTemporaryEvents(bartender, true)
                    FreezeEntityPosition(bartender, true)
                    SetEntityInvincible(bartender, true)
                    madeBar = true

                    if Config.barPlayAnim then 
                        local dict = "amb@world_human_hang_out_street@male_c@idle_a"
            
                        if not HasAnimDictLoaded(dict) then
                            RequestAnimDict(dict)
                            while not HasAnimDictLoaded(dict) do
                                Wait(100)
                            end
                        end

                        TaskPlayAnim(bartender, dict, "idle_b", 8.0, -8.0, -1, 1, 0, false, false, false)

                        Wait(1000)
                        RemoveAnimDict(dict)
                    end

                end
            else
                Wait(1000)
                SetEntityAsNoLongerNeeded(bartender)
                DeletePed(bartender)
                madeBar = false  
            end

            if settings[k]['bossSettings'].spawnped then 
                local bossCoords = vector3(settings[k]['bossSettings'].coords.x, settings[k]['bossSettings'].coords.y, settings[k]['bossSettings'].coords.z)  
                local bossHash = settings[k]['bossSettings'].hash
                local bossHeading = settings[k]['bossSettings'].coords.w
                

                if #(plyCoords - bossCoords) < 25 then 
                    if not madeBoss then  

                        RequestModel(bossHash)
            
                        while not HasModelLoaded(bossHash) do
                            Wait(1)
                        end
                        
                        boss = CreatePed(4, bossHash, bossCoords, bossHeading, false, true)
                        SetEntityAsMissionEntity(boss, true, true)
                        SetBlockingOfNonTemporaryEvents(boss, true)
                        FreezeEntityPosition(boss, true)
                        SetEntityInvincible(boss, true)
                        madeBoss = true
                    end
                else
                    Wait(1000)
                    SetEntityAsNoLongerNeeded(boss)
                    DeletePed(boss)
                    madeBoss = false  
                end
            end
        end
    end
end)


if Config.debug then 
    RegisterCommand('hayden:test', function() -- debug command
        TriggerServerEvent('hayden:test')
    end, false)
end

RegisterNetEvent('qb-vanillaunicorn:Client:accessBarMenu', function(data) -- Access bar menu, exploit checks
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

RegisterNetEvent('qb-vanillaunicorn:Client:purchaseDrink', function(data) -- purchase drinks, exploit check
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
                txt = t['cost'] .. price .. '',
                params = {
                    isServer = true,
                    event = "qb-vanillaunicorn:Server:handleItem",
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

RegisterNetEvent('qb-vanillaunicorn:Client:barMenu', function() -- Open bar menu
    exports["qb-menu"]:openMenu(drinks)
end)

RegisterNetEvent('qb-vanillaunicorn:Client:employeeManagement', function() -- Open boss menu
    exports["qb-menu"]:openMenu(bossMenu)
end)