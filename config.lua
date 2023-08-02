Config = {}

Config.Zonedebug = false

Config.coords = {
    duty = {
        coords = vector3(-1196.95, -902.45, 14.0),
        size = vector3(1.5, 0.5, 2),
        rotation = 33.5,
    },
    cook = {
        coords = vector3(-1200.54, -900.92, 13.8),
        size = vector3(1.0, 1.8, 0.8),
        rotation = 34,
    },
    cook_2 = {
        coords = vector3(-1202.94, -897.38, 14.0),
        size = vector3(1.0, 1.8, 0.8),
        rotation = 34,
    },
    fry = {
        coords = vector3(-1202.01, -899.27, 14.0),
        size = vector3(1.5, 2.5, 0.8),
        rotation = 34,
    },
    burgers = {
        coords = vector3(-1197.57, -899.41, 14.0),
        size = vector3(0.7, 1.8, 0.8),
        rotation = 304,
    },
    drinks = {
        coords = vector3(-1199.54, -895.52, 14.0),
        size = vector3(0.6, 2.2, 1),
        rotation = 34,
    },
    tray = {
        coords = vector3(-1193.87, -894.38, 14.0),
        size = vector3(1, 1.05, 0.5),
        rotation = 35,
    },
    hotstorage = {
        coords = vector3(-1197.78, -894.45, 14.0),
        size = vector3(1.2, 4.6, 1.8),
        rotation = 35,
    },
    storage = {
        coords = vector3(-1202.64, -891.77, 14),
        size = vector3(1, 3, 1.8),
        rotation = 35,
    },
}

Config.IngredientsLabels = {
    ["tomato"] = "Tomates",
    ["mshakeformula"] = "Formule à Milkshake",
    ["water_bottle"] = "Bouteille d'eau",
    ["co2_bottle"] = "Bouteille de CO2",
    ["lettuce"] = "Laitue",
    ["bun"] = "Pain à burger",
    ["steak"] = "Steak",
    ["fries"] = "Frites",
    ["mshake"] = "Milkshake",
    ["meatshake"] = "MeatShake",
    ["meatfree"] = "Burger Végétarien",
    ["burger"] = "Burger",
    ["torpedo"] = "Torpedo",
    ["heartstopper"] = "HeartStopper"
}

Config.Recipes = {
    prep = {
        steak = {
            label = "Steak",
            ingredients = {
                {
                    item = "rawmeat",
                    amount = 1,
                },
            }
        },
        fries = {
            label = "Barquette de frites",
            ingredients = {
                {
                    item = "potato",
                    amount = 1,
                },
            }
        },
    },
    drinks = {
        milkshake = {
            label = "MilkShake",
            ingredients = {
                {
                    item = "mshakeformula",
                    amount = 1,
                },
                {
                    item = "water_bottle",
                    amount = 1,
                }
            }
        },
        meatshake = {
            label = "MeatShake",
            ingredients = {
                {
                    item = "steak",
                    amount = 1,
                },
                {
                    item = "water_bottle",
                    amount = 1,
                }
            }
        },
    },
    burgers = {
        meatfree = {
            label = "Meat Free",
            ingredients = {
                {
                    item = "bun",
                    amount = 2,
                },
                {
                    item = "tomato",
                    amount = 2,
                },
                {
                    item = "lettuce",
                    amount = 2,
                },
            }
        },
        burger = {
            label = "Burger",
            ingredients = {
                {
                    item = "bun",
                    amount = 2,
                },
                {
                    item = "steak",
                    amount = 1,
                },
                {
                    item = "tomato",
                    amount = 2,
                },
                {
                    item = "lettuce",
                    amount = 1,
                },
            }
        },
        torpedo = {
            label = "Torpedo",
            ingredients = {
                {
                    item = "bun",
                    amount = 2,
                },
                {
                    item = "steak",
                    amount = 2,
                },
                {
                    item = "tomato",
                    amount = 2,
                },
            }
        },
        murdermeal = {
            label = "Murder Meal",
            ingredients = {
                {
                    item = "fries",
                    amount = 2,
                },
                {
                    item = "bleeder",
                    amount = 1,
                },
                {
                    item = "meatshake",
                    amount = 2,
                },
            }
        },
        heartstopper = {
            label = "Heart-Stopper",
            ingredients = {
                {
                    item = "bun",
                    amount = 2,
                },
                {
                    item = "steak",
                    amount = 3,
                },
                {
                    item = "tomato",
                    amount = 4,
                },
                {
                    item = "lettuce",
                    amount = 2,
                },
            }
        },
        bleederburger = {
            label = "Bleeder Burger",
            ingredients = {
                {
                    item = "bun",
                    amount = 2,
                },
                {
                    item = "steak",
                    amount = 2,
                },
                {
                    item = "lettuce",
                    amount = 2,
                },
            }
        },
        moneyshot = {
            label = "MoneyShot",
            ingredients = {
                {
                    item = "bun",
                    amount = 2,
                },
                {
                    item = "steak",
                    amount = 1,
                },
            }
        },
    },
}
