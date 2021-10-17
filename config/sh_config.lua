Config = {}

Config.debug = true -- Debug mode, disable on prod servers

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

Config.Settings = {
    ['duty'] = { -- On Duty Settings
        [1] = {
            vector3(1,1,1)
        }
    },
    ['bossSettings'] = { -- Boss Action Settings
        [1] = {
            hash = `a_m_y_business_02`,
            coords = vector4(92.97, -1292.39, 28.27, 298.99)
        }
    },
    ['barSettings'] = { -- Bartender Settings
        [1] = {
            hash = `a_m_y_business_02`,
            coords = vector4(128.72, -1282.9, 28.27, 123.15),
            playAnimation = true
        }
    }
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