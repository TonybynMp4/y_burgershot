# A Burgershot job for the Qbox Framework

You can add / remove items from the config.lua file.
Obtaining the ingredients can be done by using an ox_inventory shop, but you can do it however you want (like having a farming company that sells these ingredients to the BurgerShot).

I don't provide a location for qbx-management, i'll let you do it for yourself.

Compatible with two MLOs "out of the box" (default uniqx, Smallo's config is a bit further down in this readme)

Smallo: https://www.gta5-mods.com/maps/gtaiv-burgershot-interior-sp-and-fivem

Uniqx: https://www.gta5-mods.com/maps/mlo-burgershot-2023-add-on-sp-fivem

## Dependencies :

Qbox Framework - https://github.com/qbox-project/qbx-core

ox_lib - https://github.com/overextended/ox_lib

ox_inventory - https://github.com/overextended/ox_inventory

ox_target - https://github.com/overextended/ox_target

## Add the following to your server.cfg
```
ensure qbx-burgershot
```

## Insert into @qb-smallresources --> server --> consumables.lua
```
RegisterNetEvent('consumables:client:bs_burger', function(item)
    if lib.progressBar({
        duration = 5000,
        label = 'Eating..',
        useWhileDead = false,
        canCancel = true,
        disable = {
            combat = true,
        },
        anim = {
            dict = 'mp_player_inteat@burger',
            clip = 'mp_player_int_eat_burger'
        },
        prop = {
            model = `prop_food_bs_burg1`,
            bone = 18905,
            pos = vec3(0.13, 0.05, 0.02),
            rot = vec3(-50.0, 16.0, 60.0)
        },
    })then
        if lib.callback.await("qbx-smallresources:RemoveItem", false, item) then
            TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Config.ConsumablesEat[item.name])
            TriggerServerEvent('hud:server:RelieveStress', math.random(10, 20))
        end
    else
        QBCore.Functions.Notify("Cancelled", "error")
    end
end)

RegisterNetEvent('consumables:client:bs_fries', function(item)
    if lib.progressBar({
        duration = 5000,
        label = 'Eating..',
        useWhileDead = false,
        canCancel = true,
        disable = {
            combat = true,
        },
        anim = {
            dict = 'mp_player_inteat@burger',
            clip = 'mp_player_int_eat_burger'
        },
        prop = {
            model = `prop_food_bs_chips`,
            bone = 18905,
            pos = vec3(0.13, 0.05, 0.02),
            rot = vec3(-50.0, 16.0, 60.0)
        },
    })then
        if lib.callback.await("qbx-smallresources:RemoveItem", false, item) then
             TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Config.ConsumablesEat[item.name])
            TriggerServerEvent('hud:server:RelieveStress', math.random(5, 10))
        end
    else
        QBCore.Functions.Notify("Cancelled", "error")
    end
end)

RegisterNetEvent('consumables:client:bs_Drink', function(item)
    if lib.progressBar({
        duration = 5000,
        label = 'Drinking..',
        useWhileDead = false,
        canCancel = true,
        disable = {
            combat = true,
        },
        anim = {
            dict = 'amb@world_human_drinking@coffee@male@idle_a',
            clip = 'idle_c'
        },
        prop = {
            model = `prop_cs_bs_cup`,
            bone = 28422,
            pos = vec3(0.0, 0.0, 0.0,),
            rot = vec3(0.0, 0.0, 0.0)
        },
    })then
       if lib.callback.await("qbx-smallresources:RemoveItem", false, item) then
            TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Config.ConsumablesDrink[item.name])
            TriggerServerEvent('hud:server:RelieveStress', math.random(20, 45))
        end
    else
        QBCore.Functions.Notify("Cancelled", "error")
    end
end)
```

## Insert into @qb-smallresources --> server --> consumables.lua
```
--Burgershot
QBCore.Functions.CreateUseableItem("fries", function(source, item)
    local LocalPlayer = Player(source).state
	if not LocalPlayer.invBusy then
        TriggerClientEvent("consumables:client:bs_fries", source, item)
    end
end)

QBCore.Functions.CreateUseableItem("bleeder", function(source, item)
    local LocalPlayer = Player(source).state
	if not LocalPlayer.invBusy then
        TriggerClientEvent("consumables:client:bs_burger", source, item)
    end
end)

QBCore.Functions.CreateUseableItem("moneyshot", function(source, item)
    local LocalPlayer = Player(source).state
	if not LocalPlayer.invBusy then
        TriggerClientEvent("consumables:client:bs_burger", source, item)
    end
end)

QBCore.Functions.CreateUseableItem("torpedo", function(source, item)
    local LocalPlayer = Player(source).state
	if not LocalPlayer.invBusy then
        TriggerClientEvent("consumables:client:bs_burger", source, item)
    end
end)

QBCore.Functions.CreateUseableItem("burger", function(source, item)
    local LocalPlayer = Player(source).state
	if not LocalPlayer.invBusy then
        TriggerClientEvent("consumables:client:bs_burger", source, item)
    end
end)

QBCore.Functions.CreateUseableItem("heartstopper", function(source, item)
    local LocalPlayer = Player(source).state
	if not LocalPlayer.invBusy then
        TriggerClientEvent("consumables:client:bs_burger", source, item)
    end
end)

QBCore.Functions.CreateUseableItem("meatfree", function(source, item)
    local LocalPlayer = Player(source).state
	if not LocalPlayer.invBusy then
        TriggerClientEvent("consumables:client:bs_burger", source, item)
    end
end)

QBCore.Functions.CreateUseableItem("meatshake", function(source, item)
    local LocalPlayer = Player(source).state
	if not LocalPlayer.invBusy then
        TriggerClientEvent("consumables:client:bs_Drink", source, item)
    end
end)

QBCore.Functions.CreateUseableItem("milkshake", function(source, item)
    local LocalPlayer = Player(source).state
	if not LocalPlayer.invBusy then
        TriggerClientEvent("consumables:client:bs_Drink", source, item)
    end
end)
```

## Insert into @qb-smallresources --> config.lua
```
ConsumablesEat = {
    ["burger"] = math.random(20, 40),
    ["bleeder"] = math.random(35, 50),
    ["moneyshot"] = math.random(35, 45),
    ["torpedo"] = math.random(35, 50),
    ["heartstopper"] = math.random(100, 150),
    ["meatfree"] = math.random(25, 50),
    ["fries"] = math.random(10, 20),
}

ConsumablesDrink  = {
    ["meatshake"] = math.random(35, 60),
    ["milkshake"] = math.random(40, 75),
}
```

## Insert into ox_inventory/data/items.lua

Add the pictures of the image folder to ox_inventory/web/images

```
['toy2'] = {
		label = 'Ours Rose',
		weight = 50,
		stack = false,
		close = false,
		description = "A Fluffy Pink Teddy from the Atic"
	},

	['toy1'] = {
		label = 'Figurinne',
		weight = 50,
		stack = false,
		close = false,
		description = "An Action Figure From the late 90's"
	},

	['burger'] = {
		label = 'Burger',
		weight = 100,
		stack = true,
		close = true,
		description = "A regular burger for boring people."
	},

	['murdermeal'] = {
		label = 'Murder Meal',
		weight = 50,
		stack = true,
		close = true,
		description = "An Amazing Murder Meal with a chance of a toy."
	},

	['heartstopper'] = {
		label = 'Burger Heartstopper',
		weight = 500,
		stack = true,
		close = true,
		description = "Sates Hunger."
	},

	['torpedo'] = {
		label = 'Burger Torpedo',
		weight = 310,
		stack = true,
		close = true,
		description = "Sates Hunger."
	},

	['milkshake'] = {
		label = 'Milkshake',
		weight = 125,
		stack = true,
		close = true,
		description = "Hand-scooped for you!"
	},

	['moneyshot'] = {
		label = 'Burger Moneyshot',
		weight = 300,
		stack = true,
		close = true,
		description = "Sates Hunger."
	},

	['bleeder'] = {
		label = 'Burger Bleeder',
		weight = 250,
		stack = true,
		close = true,
		description = "Sates Hunger."
	},

	['meatshake'] = {
		label = 'Meat Shake',
		weight = 125,
		stack = true,
		close = true,
		description = "Nice'N'Chunky MeatShake remulsified just for you"
	},

	['meatfree'] = {
		label = 'Burger Végétarien',
		weight = 125,
		stack = true,
		close = true,
		description = "Sates Hunger."
	},

	['fries'] = {
		label = 'Barquette de Frites',
		weight = 125,
		stack = true,
		close = true,
		description = "Sates Hunger."
	},

	['rawmeat'] = {
		label = 'Steak Cru',
		weight = 125,
		stack = true,
		close = true,
		description = "An Ingredient"
	},

	['lettuce'] = {
		label = 'laitue',
		weight = 125,
		stack = true,
		close = true,
		description = "An Ingredient"
	},

	['bun'] = {
		label = 'Pain à burger',
		weight = 125,
		stack = true,
		close = true,
		description = "An Ingredient"
	},

	['steak'] = {
		label = 'Steak Cuit',
		weight = 125,
		stack = true,
		close = true,
		description = "An Ingredient"
	},

	['tomato'] = {
		label = 'Tomate',
		weight = 125,
		stack = true,
		close = true,
		description = "An Ingredient"
	},

	['mshakeformula'] = {
		label = 'Formule à Milkshake',
		weight = 125,
		stack = true,
		close = true,
		description = "An Ingredient"
	},

	['potato'] = {
		label = 'Sac de Patates',
		weight = 1500,
		stack = true,
		close = true,
		description = "An Ingredient"
	},
```

Optionnal:
If you want to make the raw meat a eat-able thing i guess :) (thanks to PrinceAlbert (discord @noornahas))
```
client = {
            status = { hunger = -200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            notification = 'You ate raw meat! GROSS!'
        },
```

## Insert into ox_inventory/modules/items/containers.lua
```
setContainerProperties('murdermeal', {
	slots = 4,
	maxWeight = 2500,
	whitelist = { "bleeder", "meatshake", "fries", "toy1", "toy2" }
})
```

## Insert into @qbx-core/shared/jobs.lua
```
["burgershot"] = {
	label = "Burgershot Employee",
	defaultDuty = false,
    offDutyPay = true,
	grades = {
        ['0'] = {
            name = "Trainee",
            payment = 50
        },
		['1'] = {
            name = "Employee",
            payment = 75
        },
		['2'] = {
            name = "Manager",
            payment = 125
        },
		['3'] = {
            name = "CEO",
			isboss = true,
            payment = 150
        },
    },
},
```

## Uniqx coords Config
```
    duty = {
        coords = vector3(-1200.5, -902.27, 14.75),
        size = vector3(2.0, 0.5, 2),
        rotation = 125,
    },
    cook = {
        coords = vector3(-1195.02, -897.35, 14),
        size = vector3(0.5, 0.7, 0.8),
        rotation = 74,
    },
    cook_2 = {
        coords = vector3(-1195.75, -897.15, 14),
        size = vector3(0.5, 0.75, 0.8),
        rotation = 74,
    },
    fry = {
        coords = vector3(-1196.08, -900.08, 13.5),
        size = vector3(0.70, 2.5, 1.5),
        rotation = 74,
    },
    burgers = {
        coords = vector3(-1195.29, -897.55, 13.80),
        size = vector3(1, 4.5, 0.2),
        rotation = 74,
    },
    drinks = {
        coords = vector3(-1191, -898.75, 13.89),
        size = vector3(0.6, 2.2, 1.5),
        rotation = 125,
    },
    tray = {
        coords = vector3(-1194.93, -893.3, 14.15),
        size = vector3(1, 1.05, 0.5),
        rotation = 165,
    },
    hotstorage = {
        coords = vector3(-1203.08, -896.96, 14.5),
        size = vector3(1.2, 3, 1.8),
        rotation = 35,
    },
    storage = {
        coords = vector3(-1196, -901, 13.89),
        size = vector3(0.75, 3, 1.8),
        rotation = 75,
    },
    ```
