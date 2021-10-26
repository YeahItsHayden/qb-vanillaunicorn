madeBar = false
madeBoss = false

setupContext = function()
    --[[bossMenu = {
        {
            id = 1,
            header = t['employeeTitle'],
            isMenuHeader = true,
        },
        {
            id = 2,
            header = t['employeeHire'],
            txt = t['employeeHireDesc'],
            params = {
                event = "qb-bossmenu:client:openMenu",
            }
        },
    }--]] -- Not used currently, will be implemented better in the near future

    barMenu = {
        {
            header = t['barMenu'],
            isMenuHeader = true,
        },
        {
            header = t['browseDrinks'],
            txt = t['browseDesc'],
            params = {
                event = "qb-vanillaunicorn:Client:barMenu",
            }
        },
    }


    drinks = { -- read below on how to add more drinks
        {
            header = t['barMenu'],
            isMenuHeader = true,
        },
        {
            header = t['coke'], -- Title of the drink
            txt = t['cokedesc'], -- short description
            params = {
                event = "qb-vanillaunicorn:Client:purchaseDrink",
                args = {
                    type = Config.Drinks['coke'], -- Ensure you also create a config for the drink
                }
            }
        },
        {
            header = t['whiskey'],
            txt = t['whiskeyDesc'],
            params = {
                event = "qb-vanillaunicorn:Client:purchaseDrink",
                args = {
                    type = Config.Drinks['whiskey'],
                }
            }
        },
        {
            header = t['rum'],
            txt = t['rumDesc'],
            params = {
                event = "qb-vanillaunicorn:Client:purchaseDrink", 
                args = {
                    type = Config.Drinks['rum'],
                }
            }
        },
        {
            header = t['vodka'],
            txt = t['vodkaDesc'],
            params = {
                event = "qb-vanillaunicorn:Client:purchaseDrink",
                args = {
                    type = Config.Drinks['vodka'],
                }
            }
        },
        {
            header = t['goBack'],
        },
    }

    for k, v in pairs(settings) do
        print(settings[k]['barSettings'].hash) 
        exports['qb-target']:AddTargetModel(settings[k]['barSettings'].hash, {
            options = {
                {
                    event = "qb-vanillaunicorn:Client:accessBarMenu",
                    icon = "fas fa-sack-dollar",
                    label = t['accessBarMenu'],
                    args = {
                        canUse = true 
                    },
                    canInteract = function() -- Have yet to implement the actual job 
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
    
                        local barCoords = vector3(settings[k]['barSettings'].coords.x, settings[k]['barSettings'].coords.y, settings[k]['barSettings'].coords.z)

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

        exports['qb-target']:AddBoxZone("EnableDuty", settings[k]['duty'].coords, settings[k]['duty'].length, settings[k]['duty'].width, {
            name="EnableDuty",
            heading=settings[k]['duty'].heading,
            debugPoly=false,
            minZ = settings[k]['duty'].minZ,
            maxZ = settings[k]['duty'].maxZ,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-vanillaunicorn:Client:signOn",
                        icon = "fas fa-sign-in-alt",
                        label = t['toggleDuty'],
                        job = "vu",
                    },
                },
            distance = 3.5
        })

        exports['qb-target']:AddBoxZone("StashVU", settings[k]['stash'].coords, settings[k]['stash'].length, settings[k]['stash'].width, {
            name="StashVU",
            heading=settings[k]['stash'].heading,
            debugPoly=false,
            minZ = settings[k]['stash'].minZ,
            maxZ = settings[k]['stash'].maxZ,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-vanillaunicorn:Client:stash",
                        icon = "fas fa-sign-in-alt",
                        label = t['openStash'],
                        job = "vu",
                    },
                },
            distance = 3.5
        })

        exports['qb-target']:AddTargetModel(settings[k]['bossSettings'].hash, {
            options = {
                {
                    event = "qb-vanillaunicorn:Client:employeeManagement",
                    icon = "fas fa-sack-dollar",
                    label = t['openEmployee'],
                    job = settings[k]['bossSettings'].bossJob,
                    canInteract = function() -- Have yet to implement the actual job 
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                       
                        local bossCoords = vector3(settings[k]['bossSettings'].coords.x, settings[k]['bossSettings'].coords.y, settings[k]['bossSettings'].coords.z)
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
end  