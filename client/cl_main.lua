QBCore = exports['qb-core']:GetCoreObject()

n = RegisterNetEvent -- I'm lazy
t = Translation[Config.Translation] -- For translations (even lazier)
ped = PlayerPedId() -- Player ped

barCoords = Config.barCoords -- Coords for bar npc
barHash = Config.barHash -- bar npc hash
barHeading = Config.barHeading -- Heading of Bartender NPC

CreateThread(function() -- Thread to handle original context menu setup
    setupContext()
end)

if Config.debug then 
    RegisterCommand('hayden:test', function() -- debug command
        exports["zf_context"]:openMenu(barMenu)
    end, false)
end

n('qb-vanillaunicorn:accessBarMenu', function(data) -- Access bar menu, exploit checks
    canUse = data.args.canUse
    plyCoords = GetEntityCoords(ped) 
    if canUse and #(plyCoords - barCoords) < 5 then 
        exports["zf_context"]:openMenu(barMenu)
    else
        print("User is attempting to access menu whilst not near - exploit")
    end
end)

n('qb-vanillaunicorn:purchaseDrink', function(data) -- purchase drinks, exploit check
    type = data.pass 
    name = type.name

    barConfirmation = {
        {
            id = 1,
            header = t['confirmDrink'] .. name .. "?",
            txt = ' '
        },
        {
            id = 2,
            header = t['yes'],
            txt = 'This will cost $' .. type.price,
            params = {
                isServer = true,
                event = "qb-vanillaunicorn:handleItem",
                args = {
                    type = type.item,
                    amount = type.amount, 
                    price = type.price, 
                }
            }
        },
        {
            id = 3,
            header = t['no'],
            txt = ' ',
            params = {
                event = "",
            }
        },
    }

    exports["zf_context"]:openMenu(barConfirmation)  
end)

n('qb-vanillaunicorn:barMenu', function() -- Open bar menu
    exports["zf_context"]:openMenu(drinks)
end)