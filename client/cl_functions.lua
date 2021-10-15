madePed = false


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

    while true do 
        Wait(5000)
        plyCoords = GetEntityCoords(ped)

        if #(plyCoords - barCoords) < 10 then
            if not madePed then  

                RequestModel(barHash)
    
                while not HasModelLoaded(barHash) do
                    Wait(1)
                end
                
                bartender = CreatePed(4, barHash , barCoords, barHeading, false, false)
                SetEntityAsMissionEntity(bartender, true, true)
                SetBlockingOfNonTemporaryEvents(bartender, true)
                FreezeEntityPosition(bartender, true)
                SetEntityInvincible(bartender, true)
                madePed = true

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
            madePed = false  
        end
    end


end