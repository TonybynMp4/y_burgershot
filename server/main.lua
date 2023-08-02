local function hasIngredients(source, recipe, recipeType)
    local Recipe = Config.Recipes[recipeType][recipe]
    if not Recipe then
        print(recipeType, recipe)
        return false
    end
    for k, v in pairs(Recipe.ingredients) do
        local count = exports.ox_inventory:Search(source, 'count', v.item, false)
        if not count or count < Recipe.ingredients[k].amount then
            return false
        end
    end
    return true
end

lib.callback.register('qbx-burgershot:server:hasIngredients', hasIngredients)

RegisterNetEvent('qbx-burgershot:server:CraftMeal', function(recipe, recipeType)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local Recipe = Config.Recipes[recipeType][recipe]
    if not Player then return end
    if not Recipe then return end

    if not hasIngredients(source, recipe, recipeType) then
        return TriggerClientEvent('QBCore:Notify', source, Lang:t('error.missing_ingredients'), 'error')
    end

    for _, v in pairs(Recipe.ingredients) do
        exports.ox_inventory:RemoveItem(source, v.item, v.amount)
    end
    if recipe == 'murdermeal' then
        local success, response = exports.ox_inventory:AddItem(source, 'murdermeal', 1)
        if not success then
            return TriggerClientEvent('QBCore:Notify', source, Lang:t("error.something_went_wrong"), 'error')
        end

        local container = exports.ox_inventory:GetContainerFromSlot(source, response.slot)
        for _, v in pairs(Recipe.ingredients) do
            exports.ox_inventory:AddItem(container.id, v.item, v.amount)
        end
        exports.ox_inventory:AddItem(container.id, 'toy'..math.random(1,2), 1)
        return TriggerClientEvent('QBCore:Notify', source, Lang:t('success.crafted', { recipe = Recipe.label }), 'success')
    end
    TriggerClientEvent('QBCore:Notify', source, Lang:t('success.crafted', { recipe = Recipe.label }), 'success')
    exports.ox_inventory:AddItem(source, recipe, 1)
end)

local stashes = {
    {
        id = 'burgershot_tray',
        label = Lang:t('info.tray'),
        slots = 5,
        weight = 10000,
        groups = nil,
        coords = vector3(-1195.29, -892.31, 14.0),
    },
    {
        id = 'burgershot_hotstorage',
        label = Lang:t('info.storage'),
        slots = 50,
        weight = 75000,
        groups = { ['burgershot'] = 0},
        coords = vector3(-1197.78, -894.45, 14.0),
    },
    {
        id = 'burgershot_storage',
        label = Lang:t('info.storage'),
        slots = 20,
        weight = 100000,
        groups = { ['burgershot'] = 0},
        coords = vector3(-1202.64, -891.77, 14),
    }
}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        for _, stash in pairs(stashes) do
            exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner)
        end
    end
end)