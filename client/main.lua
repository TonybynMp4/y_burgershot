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
		coords = vec3(-1196.95, -902.45, 14.0),
		size = vec3(1.5, 0.5, 2),
		rotation = 33.5,
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
		coords = vec3(-1200.54, -900.92, 13.8),
		size = vec3(1.0, 1.8, 0.8),
		rotation = 34,
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
		coords = vec3(-1202.94, -897.38, 14.0),
		size = vec3(1.0, 1.8, 0.8),
		rotation = 34,
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
		coords = vec3(-1202.01, -899.27, 14.0),
		size = vec3(1.5, 2.5, 0.8),
		rotation = 34,
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
		coords = vec3(-1197.57, -899.41, 14.0),
		size = vec3(0.7, 1.8, 0.8),
		rotation = 304,
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
		coords = vec3(-1199.54, -895.52, 14.0),
		size = vec3(0.6, 2.2, 1),
		rotation = 34,
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
		coords = vec3(-1193.87, -894.38, 14.0),
		size = vec3(1, 1.05, 0.5),
		rotation = 35,
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
		coords = vec3(-1197.78, -894.45, 14.0),
		size = vec3(1.2, 4.6, 1.8),
		rotation = 35,
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
		coords = vec3(-1202.64, -891.77, 14),
		size = vec3(1, 3, 1.8),
		rotation = 35,
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