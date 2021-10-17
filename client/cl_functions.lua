madeBar = false
madeBoss = false

setupContext = function()
    bossMenu = {
        {
            id = 1,
            header = t['employeeTitle'],
            txt = ' '
        },
        {
            id = 2,
            header = t['employeeHire'],
            txt = t['employeeHireDesc'],
            params = {
                event = "qb-bossmenu:client:openMenu",
            }
        },
    }

    barMenu = {
        {
            id = 1,
            header = t['barMenu'],
            txt = ' '
        },
        {
            id = 2,
            header = t['browseDrinks'],
            txt = t['browseDesc'],
            params = {
                event = "qb-vanillaunicorn:barMenu",
            }
        },
    }

    drinks = { -- read below on how to add more drinks
        {
            id = 1,
            header = t['barMenu'],
            txt = ' '
        },
        {
            id = 2, -- Unique ID
            header = t['coke'], -- Title of the drink
            txt = t['cokedesc'], -- short description
            params = {
                event = "qb-vanillaunicorn:purchaseDrink",
                args = {
                    type = Config.Drinks['coke'], -- Ensure you also create a config for the drink
                }
            }
        },
        {
            id = 3,
            header = t['whiskey'],
            txt = t['whiskeyDesc'],
            params = {
                event = "qb-vanillaunicorn:purchaseDrink",
                args = {
                    type = Config.Drinks['whiskey'],
                }
            }
        },
        {
            id = 4,
            header = t['rum'],
            txt = t['rumDesc'],
            params = {
                event = "qb-vanillaunicorn:purchaseDrink", 
                args = {
                    type = Config.Drinks['rum'],
                }
            }
        },
        {
            id = 5,
            header = t['vodka'],
            txt = t['vodkaDesc'],
            params = {
                event = "qb-vanillaunicorn:purchaseDrink",
                args = {
                    type = Config.Drinks['vodka'],
                }
            }
        },
    }

    for i, v in pairs(settings) do
        print(settings[i]['barSettings'].hash) 
        exports['qb-target']:AddTargetModel(settings[i]['barSettings'].hash, {
            options = {
                {
                    event = "qb-vanillaunicorn:accessBarMenu",
                    icon = "fas fa-sack-dollar",
                    label = "Access Bar Menu",
                    args = {
                        canUse = true 
                    },
                    canInteract = function() -- Have yet to implement the actual job 
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
    
                        local barCoords = vector3(settings[i]['barSettings'].coords.x, settings[i]['barSettings'].coords.y, settings[i]['barSettings'].coords.z)

                        print(#(pos - barCoords))
                        if #(pos - barCoords) <= 10 then
                            print("returning true") 
                            return true 
                        elseif #(pos- barCoords) > 15 then 
                            print("returning false")
                            return false
                        end
                    end, 
                },
            },
            distance = 5.0,
        })
    end

    for i, v in pairs(settings) do 
        exports['qb-target']:AddTargetModel(settings[i]['bossSettings'].hash, {
            options = {
                {
                    event = "qb-vanillaunicorn:employeeManagement",
                    icon = "fas fa-sack-dollar",
                    label = "Open Employee Management",
                    job = settings[i]['bossSettings'].bossJob,
                    canInteract = function() -- Have yet to implement the actual job 
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                       
                        local bossCoords = vector3(settings[i]['bossSettings'].coords.x, settings[i]['bossSettings'].coords.y, settings[i]['bossSettings'].coords.z)
                        if #(pos - bossCoords) <= 10 then
                            print("returning true") 
                            return true 
                        else
                            print("returning false")
                            return false
                        end
                    end, 
                },
            },
            distance = 5.0,
        })
    end

    while true do 
        Wait(1000)
        plyCoords = GetEntityCoords(ped)

        for i, v in pairs(settings) do 
            local barCoords = vector3(settings[i]['barSettings'].coords.x, settings[i]['barSettings'].coords.y, settings[i]['barSettings'].coords.z)  
            local barHash = settings[i]['barSettings'].hash
            local barHeading = settings[i]['barSettings'].coords.w

            if #(plyCoords - barCoords) < 25 then
                if not madeBar then  

                    RequestModel(barHash)
        
                    while not HasModelLoaded(barHash) do
                        Wait(1)
                    end
                    
                    bartender = CreatePed(4, barHash , barCoords, barHeading, false, false)
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
                Wait(2000)
                SetEntityAsNoLongerNeeded(bartender)
                DeletePed(bartender)
                madeBar = false  
            end
        end

        for i, v in pairs(settings) do
            local bossCoords = vector3(settings[i]['bossSettings'].coords.x, settings[i]['bossSettings'].coords.y, settings[i]['bossSettings'].coords.z)  
            local bossHash = settings[i]['bossSettings'].hash
            local bossHeading = settings[i]['bossSettings'].coords.w
            

            if #(plyCoords - bossCoords) < 25 then 
                if not madeBoss then  

                    RequestModel(bossHash)
        
                    while not HasModelLoaded(bossHash) do
                        Wait(1)
                    end
                    
                    boss = CreatePed(4, bossHash, bossCoords, bossHeading, false, false)
                    SetEntityAsMissionEntity(boss, true, true)
                    SetBlockingOfNonTemporaryEvents(boss, true)
                    FreezeEntityPosition(boss, true)
                    SetEntityInvincible(boss, true)
                    madeBoss = true
                end
            else
                Wait(2000)
                SetEntityAsNoLongerNeeded(boss)
                DeletePed(boss)
                madeBoss = false  
            end
        end

    end
end

getClosestPlayer = function() -- Just taken from Qb-Policejob
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end