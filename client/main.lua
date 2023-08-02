local onDuty = false

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
	onDuty = duty
end)

local function getDescription(ingredients)
	local desc = ""
	for _, v in pairs(ingredients) do
		desc = desc .. Config.IngredientsLabels[v.item] .. " x" .. v.amount .. " | "
	end
	desc = string.sub(desc, 1, -4)
	return desc
end

local function craftPrep(recipe)
	if not onDuty then
		return QBCore.Functions.Notify(Lang:t('error.notOnDuty'), "error")
	end

	local HasIngredients = lib.callback.await('qbx-burgershot:server:hasIngredients', false, recipe, "prep")
	if not HasIngredients then
		return QBCore.Functions.Notify(Lang:t("error.missing_ingredients"), 'error', 7500)
	end

	QBCore.Functions.Progressbar("pickup", Lang:t('progress.cooking'), 4000, false, true, {
		disableMovement = true,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {
		animDict = "amb@prop_human_bbq@male@base",
	    anim = "base",
	    flags = 8,
	}, {
		model = "prop_cs_fork",
		bone = 28422,
		coords = vector3(-0.005, 0.00, 0.00),
		rotation = vector3(175.0, 160.0, 0.0),
	}, {}, function()
		TriggerServerEvent('qbx-burgershot:server:CraftMeal', recipe, "prep")
	end, function()
		QBCore.Functions.Notify('Annulé!', 'error', 7500)
	end)
end

local function craftDrink(recipe)
	if not onDuty then
		return QBCore.Functions.Notify(Lang:t('error.notOnDuty'), "error")
	end

	local HasIngredients = lib.callback.await('qbx-burgershot:server:hasIngredients', false, recipe, "drinks")
	if not HasIngredients then
		return QBCore.Functions.Notify(Lang:t("error.missing_ingredients"), 'error', 7500)
	end

	QBCore.Functions.Progressbar("pickup", Lang:t('progress.making_drink'), 4000, false, true, {
		disableMovement = true,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function()
		TriggerServerEvent('qbx-burgershot:server:CraftMeal', recipe, "drinks")
	end, function()
		QBCore.Functions.Notify('Annulé!', 'error', 7500)
	end)
end

local function craftMeal(recipe)
	if not onDuty then
		return QBCore.Functions.Notify(Lang:t('error.notOnDuty'), "error")
	end

	local HasIngredients = lib.callback.await('qbx-burgershot:server:hasIngredients', false, recipe, 'burgers')
	if not HasIngredients then
		return QBCore.Functions.Notify(Lang:t("error.missing_ingredients"), 'error', 7500)
	end

	QBCore.Functions.Progressbar("pickup_sla", Lang:t('progress.making_burger'), 4000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mp_common",
		anim = "givetake1_a",
		flags = 8,
	}, {}, {}, function() -- Done
		TriggerServerEvent('qbx-burgershot:server:CraftMeal', recipe, 'burgers')
	end, function()
		QBCore.Functions.Notify(Lang:t('error.cancel'), "error")
	end)
end

local function openDrinksMenu()
	local Recipes = Config.Recipes.drinks
	-- ox_lib menu that has all the recipes and triggers the craft function
	local options = {}

	for k, v in pairs(Recipes) do
		local description = getDescription(v.ingredients)
		options[#options + 1] = {
			title = v.label,
			description = description,
			icon = 'utensils',
			onSelect = function()
				craftDrink(k)
			end,
		}
	end

	lib.registerContext({
		id = 'BurgerShot_CraftMenu',
		title = Lang:t('menus.drinks_title'),
		options = options,
	})
	lib.showContext('BurgerShot_CraftMenu')
end

local function openBurgerMenu()
	local Recipes = Config.Recipes.burgers
	local options = {}

	for k, v in pairs(Recipes) do
		local description = getDescription(v.ingredients)
		options[#options + 1] = {
			title = v.label,
			description = description,
			icon = 'utensils',
			onSelect = function()
				craftMeal(k)
			end,
		}
	end

	lib.registerContext({
		id = 'BurgerShot_CraftMenu',
		title = Lang:t('menus.burger_title'),
		options = options,
	})
	lib.showContext('BurgerShot_CraftMenu')
end

CreateThread(function()
	exports.ox_target:addBoxZone({
		name = "BurgerShot_Duty",
		coords = Config.coords.duty.coords,
		size = Config.coords.duty.size,
		rotation = Config.coords.duty.rotation,
		debug = false,
		options = {
			{
				type = "client",
				onSelect = function()
					onDuty = not onDuty
					TriggerServerEvent("QBCore:ToggleDuty")
				end,
				icon = "fa fa-clipboard",
				label = Lang:t('info.duty'),
				distance = 3.0,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "BurgerShot_Cook",
		coords = Config.coords.cook.coords,
		size = Config.coords.cook.size,
		rotation = Config.coords.cook.rotation,
		debug = false,
		options = {
			{
				type = "client",
				onSelect = function()
					craftPrep("steak")
				end,
				icon = "fa fa-hamburger",
				label = Lang:t('info.burger_cook'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "BurgerShot_Cook_2",
		coords = Config.coords.cook_2.coords,
		size = Config.coords.cook_2.size,
		rotation = Config.coords.cook_2.rotation,
		debug = false,
		options = {
			{
				type = "client",
				onSelect = function()
					craftPrep("steak")
				end,
				icon = "fa fa-hamburger",
				label = Lang:t('info.burger_cook'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "BurgerShot_Fry",
		coords = Config.coords.fry.coords,
		size = Config.coords.fry.size,
		rotation = Config.coords.fry.rotation,
		debug = false,
		options = {
			{
				type = "client",
				onSelect = function()
					craftPrep("fries")
				end,
				icon = "fa fa-hamburger",
				label = Lang:t('info.fries_cook'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "BurgerShot_Burgers_Craft",
		coords = Config.coords.burgers.coords,
		size = Config.coords.burgers.size,
		rotation = Config.coords.burgers.rotation,
		debug = false,
		options = {
			{
				type = "client",
				onSelect = openBurgerMenu,
				icon = "fa fa-utensils",
				label = Lang:t('info.craft'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "BurgerShot_Drinks_Craft",
		coords = Config.coords.drinks.coords,
		size = Config.coords.drinks.size,
		rotation = Config.coords.drinks.rotation,
		debug = false,
		options = {
			{
				type = "client",
				onSelect = openDrinksMenu,
				icon = "fa fa-utensils",
				label = Lang:t('info.craft'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "burger_tray",
		coords = Config.coords.tray.coords,
		size = Config.coords.tray.size,
		rotation = Config.coords.tray.rotation,
		debug = false,
		options = {
			{
				type = "client",
				onSelect = function()
					exports.ox_inventory:openInventory('stash', 'burgershot_tray')
				end,
				icon = "fa fa-clipboard",
				label = Lang:t('info.tray'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "burgershot_hotstorage",
		coords = Config.coords.hotstorage.coords,
		size = Config.coords.hotstorage.size,
		rotation = Config.coords.hotstorage.rotation,
		debug = false,
		options = {
			{
				type = "client",
				onSelect = function()
					exports.ox_inventory:openInventory('stash', 'burgershot_hotstorage')
				end,
				icon = "fa fa-box",
				label = Lang:t('info.storage'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "burgershot_storage",
		coords = Config.coords.storage.coords,
		size = Config.coords.storage.size,
		rotation = Config.coords.storage.rotation,
		debug = false,
		options = {
			{
				type = "client",
				onSelect = function()
					exports.ox_inventory:openInventory('stash', 'burgershot_storage')
				end,
				icon = "fa fa-box",
				label = Lang:t('info.storage'),
				distance = 2,
				groups = "burgershot",
			}
		}
	})
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		onDuty = QBCore.Functions.GetPlayerData().job.onduty
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	onDuty = QBCore.Functions.GetPlayerData().job.onduty
end)