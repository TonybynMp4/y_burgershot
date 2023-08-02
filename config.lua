Config = {}

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
