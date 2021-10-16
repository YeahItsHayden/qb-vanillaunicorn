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
                event = "",
                args = {
                    amount = 1
                }
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
            id = 2,
            header = t['coke'],
            txt = t['cokedesc'],
            params = {
                event = "qb-vanillaunicorn:purchaseDrink",
                args = {
                    type = Config.Drinks['coke'],
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

    exports['qb-target']:AddBoxZone("bartenderScript", Config.polyBar, Config.polyLength, Config.polyWidth, {
        name="bartenderScript",
        heading=Config.polyHeading,
        debugPoly= false,
        minZ=Config.polyMin,
        maxZ=Config.polyMax,
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-vanillaunicorn:accessBarMenu",
                    icon = "fas fa-sign-in-alt",
                    label = "Access Bar Menu",
                    args = {
                        canUse = true
                    }, 
                },
            },
            distance = 5.0
    })

    exports['qb-target']:AddTargetModel(Config.bossHash, {
        options = {
            {
                event = "qb-vanillaunicorn:employeeManagement",
                icon = "fas fa-sack-dollar",
                label = "Open Employee Management",
                canInteract = function() -- Have yet to implement the actual job 
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    print("Debug 1")
                    if #(pos - Config.bossCoords) <= 10 then
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

    while true do 
        Wait(1000)
        plyCoords = GetEntityCoords(ped)

        if #(plyCoords - barCoords) < 10 then
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

        if #(plyCoords - bossCoords) < 10 then 
            if not madeBoss then  

                RequestModel(barHash)
    
                while not HasModelLoaded(barHash) do
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