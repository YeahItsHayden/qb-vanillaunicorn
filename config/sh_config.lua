Config = {}

Config.debug = true -- Debug mode, disable on prod servers

Config.barCoords = vector3(128.72, -1282.9, 28.27) -- Coords of the bartender
Config.barHeading = 123.15 -- Heading of bar ped
Config.barHash = `a_m_y_business_02` -- Hash of the bartender ped
Config.barPlayAnim = true -- Whether or not the ped should play an animation

Config.bossCoords = vector3(92.97, -1292.39, 28.27)
Config.bossHeading = 298.99
Config.bossHash = `a_m_y_business_02`

-- Bartender Polyzone settings
Config.polyBar = vector3(128.66, -1282.92, 29.27) -- pz coords
Config.polyLength = 0.6 -- Length of poly
Config.polyWidth = 0.6 -- Width of poly
Config.polyHeading = 116.8 -- Heading of the polyzone
Config.polyMin = 25 
Config.polyMax = 30


Config.Drinks = {
    ['coke'] = {
        name = 'Coke', -- The name of the drink
        item = 'cocacola', -- The actual item name (in shared.lua)
        amount = 1, -- The amount it gives
        price = 200 -- THe price of the drink
    },
    ['whiskey'] = {
        name = 'Whiskey',
        item = 'whiskey',
        amount = 1,
        price = 100 
    },
    ['vodka'] = {
        name = 'Vodka',
        item = 'vodka',
        amount = 1,
        price = 100
    },
    ['rum'] = {
        name = 'Rum',
        item = 'rum',
        amount = 1,
        price = 100
    },
}

Config.Translation = 'en'

Translation = {
    ['en'] = {
        -- Drinks + bar handling
        ['coke'] = "CoCa Cola",
        ['vodka'] = "Vodka",
        ['vodkaDesc'] = "You russian or something?",
        ['rumDesc'] = "I'm sure that person wants to fight!",
        ['whiskeyDesc'] = "What are you? 60?",
        ['rum'] = "Rum",
        ['whiskey'] = "Whiskey",
        ['cokedesc'] = "Designated Driver? No worries, have this!",
        ['browseDrinks'] = "Browse the drinks",
        ['browseDesc'] = "Click here to browse what the bartender has to offer",
        ['barMenu'] = "Bar Menu",
        ['confirmDrink'] = "Are you sure you wish to purchase a ",
        ['yes'] = "Yes",
        ['no'] = "No",
        -- Employee Management
        ['employeeTitle'] = "Employee Management",
        ['employeeHire'] = "Hire Employee",
        ['employeeHireDesc'] = "Click here to hire an employee",
    }
}