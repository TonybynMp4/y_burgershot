local onDuty = QBX?.PlayerData?.job?.onduty
local config = require 'config.client'
local sharedConfig = require 'config.shared'

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
	onDuty = duty
end)

local function getDescription(ingredients)
	local desc = ""
	for _, v in pairs(ingredients) do
		if not config.ingredientsLabels[v.item] then
			lib.print.warn("Missing ingredient label for: ", v.item)
		end
		desc = desc .. (config.ingredientsLabels?[v.item] or v?.item) .. " x" .. (v?.amount or 1) .. " | "
	end
	desc = string.sub(desc, 1, -4)
	return desc
end

local function craftPrep(recipe)
	if not onDuty then
		return exports.qbx_core:Notify(locale('error.notOnDuty'), "error")
	end

	local HasIngredients = lib.callback.await('qbx-burgershot:server:hasIngredients', false, recipe, "prep")
	if not HasIngredients then
		return exports.qbx_core:Notify(locale("error.missing_ingredients"), 'error', 7500)
	end

	if lib.progressBar({
		duration = 4000,
		label = locale('progress.cooking'),
		useWhileDead = false,
		canCancel = true,
		disable = {
			car = true,
			combat = true,
			move = true,
		},
		anim = {
			dict = 'amb@prop_human_bbq@male@base',
			clip = 'base'
		},
		prop = {
			model = `prop_cs_fork`,
			bone = 28422,
			pos = vec3(-0.005, 0.00, 0.00),
			rot = vec3(175.0, 160.0, 0.0)
		},
	}) then
		TriggerServerEvent('qbx-burgershot:server:CraftMeal', recipe, "prep")
	else
		exports.qbx_core:Notify(locale('error.cancel'), 'error', 7500)
	end
end

local function craftDrink(recipe)
	if not onDuty then
		return exports.qbx_core:Notify(locale('error.notOnDuty'), "error")
	end

	local HasIngredients = lib.callback.await('qbx-burgershot:server:hasIngredients', false, recipe, "drinks")
	if not HasIngredients then
		return exports.qbx_core:Notify(locale("error.missing_ingredients"), 'error', 7500)
	end

	if lib.progressBar({
		duration = 4000,
		label = locale('progress.making_drink'),
		useWhileDead = false,
		canCancel = true,
		disable = {
			car = true,
			combat = true,
			move = true,
		},
	}) then
		TriggerServerEvent('qbx-burgershot:server:CraftMeal', recipe, "drinks")
	else
		exports.qbx_core:Notify(locale('error.cancel'), 'error', 7500)
	end
end

local function craftMeal(recipe)
	if not onDuty then
		return exports.qbx_core:Notify(locale('error.notOnDuty'), "error")
	end

	local HasIngredients = lib.callback.await('qbx-burgershot:server:hasIngredients', false, recipe, 'burgers')
	if not HasIngredients then
		return exports.qbx_core:Notify(locale("error.missing_ingredients"), 'error', 7500)
	end


	if lib.progressBar({
		duration = 4000,
		label = locale('progress.making_burger'),
		useWhileDead = false,
		canCancel = true,
		disable = {
			car = true,
			combat = true,
			move = true,
		},
		anim = {
			dict = 'mp_common',
			clip = 'givetake1_a'
		},
	}) then
		TriggerServerEvent('qbx-burgershot:server:CraftMeal', recipe, 'burgers')
	else
		exports.qbx_core:Notify(locale('error.cancel'), 'error', 7500)
	end
end

local function openDrinksMenu()
	local Recipes = sharedConfig.recipes.drinks
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
		title = locale('menus.drinks_title'),
		options = options,
	})
	lib.showContext('BurgerShot_CraftMenu')
end

local function openBurgerMenu()
	local Recipes = sharedConfig.recipes.burgers
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
		title = locale('menus.burger_title'),
		options = options,
	})
	lib.showContext('BurgerShot_CraftMenu')
end

CreateThread(function()
	exports.ox_target:addBoxZone({
		name = "BurgerShot_Duty",
		coords = sharedConfig.coords.duty.coords,
		size = sharedConfig.coords.duty.size,
		rotation = sharedConfig.coords.duty.rotation,
		debug = config.zoneDebug,
		options = {
			{
				type = "client",
				onSelect = function()
					onDuty = not onDuty
					TriggerServerEvent("QBCore:ToggleDuty")
				end,
				icon = "fa fa-clipboard",
				label = locale('info.duty'),
				distance = 3.0,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "BurgerShot_Cook",
		coords = sharedConfig.coords.cook.coords,
		size = sharedConfig.coords.cook.size,
		rotation = sharedConfig.coords.cook.rotation,
		debug = config.zoneDebug,
		options = {
			{
				type = "client",
				onSelect = function()
					craftPrep("steak")
				end,
				icon = "fa fa-hamburger",
				label = locale('info.burger_cook'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "BurgerShot_Cook_2",
		coords = sharedConfig.coords.cook_2.coords,
		size = sharedConfig.coords.cook_2.size,
		rotation = sharedConfig.coords.cook_2.rotation,
		debug = config.zoneDebug,
		options = {
			{
				type = "client",
				onSelect = function()
					craftPrep("steak")
				end,
				icon = "fa fa-hamburger",
				label = locale('info.burger_cook'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "BurgerShot_Fry",
		coords = sharedConfig.coords.fry.coords,
		size = sharedConfig.coords.fry.size,
		rotation = sharedConfig.coords.fry.rotation,
		debug = config.zoneDebug,
		options = {
			{
				type = "client",
				onSelect = function()
					craftPrep("fries")
				end,
				icon = "fa fa-hamburger",
				label = locale('info.fries_cook'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "BurgerShot_Burgers_Craft",
		coords = sharedConfig.coords.burgers.coords,
		size = sharedConfig.coords.burgers.size,
		rotation = sharedConfig.coords.burgers.rotation,
		debug = config.zoneDebug,
		options = {
			{
				type = "client",
				onSelect = openBurgerMenu,
				icon = "fa fa-utensils",
				label = locale('info.craft'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "BurgerShot_Drinks_Craft",
		coords = sharedConfig.coords.drinks.coords,
		size = sharedConfig.coords.drinks.size,
		rotation = sharedConfig.coords.drinks.rotation,
		debug = config.zoneDebug,
		options = {
			{
				type = "client",
				onSelect = openDrinksMenu,
				icon = "fa fa-utensils",
				label = locale('info.craft'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "burger_tray",
		coords = sharedConfig.coords.tray.coords,
		size = sharedConfig.coords.tray.size,
		rotation = sharedConfig.coords.tray.rotation,
		debug = config.zoneDebug,
		options = {
			{
				type = "client",
				onSelect = function()
					exports.ox_inventory:openInventory('stash', 'burgershot_tray')
				end,
				icon = "fa fa-clipboard",
				label = locale('info.tray'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "burgershot_hotstorage",
		coords = sharedConfig.coords.hotstorage.coords,
		size = sharedConfig.coords.hotstorage.size,
		rotation = sharedConfig.coords.hotstorage.rotation,
		debug = config.zoneDebug,
		options = {
			{
				type = "client",
				onSelect = function()
					exports.ox_inventory:openInventory('stash', 'burgershot_hotstorage')
				end,
				icon = "fa fa-box",
				label = locale('info.storage'),
				distance = 1.5,
				groups = "burgershot",
			}
		}
	})

	exports.ox_target:addBoxZone({
		name = "burgershot_storage",
		coords = sharedConfig.coords.storage.coords,
		size = sharedConfig.coords.storage.size,
		rotation = sharedConfig.coords.storage.rotation,
		debug = config.zoneDebug,
		options = {
			{
				type = "client",
				onSelect = function()
					exports.ox_inventory:openInventory('stash', 'burgershot_storage')
				end,
				icon = "fa fa-box",
				label = locale('info.storage'),
				distance = 2,
				groups = "burgershot",
			}
		}
	})
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	onDuty = QBX?.PlayerData?.job?.onduty
end)
