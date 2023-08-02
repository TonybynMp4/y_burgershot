local Translations = {
    error = {
        cancel = "Annulé..",
        notOnDuty = "Vous devez être en service",
        missing_ingredients = "Vous n'avez pas les ingrédients requis!",
        something_went_wrong = "Quelque chose s'est mal passé..",
    },
    success= {
       crafted = "Vous avez fait un %{recipe}",
    },
    progress = {
        cooking = "Vous cuisinez..",
        making_drink = "Vous faites une boisson..",
        making_burger = "Vous faites un burger..",
    },
    info = {
        craft = "Confectionner quelque chose..",
        duty = "On / Off Service",
        tray = "Plateau",
        burger_cook = "Cuire Steak",
        fries_cook = "Faire des Frites",
        storage = "Stockage",
    },
    menus = {
        burger_title = "BurgerShot Cuisine",
        drinks_title = "BurgerShot Boissons",
    }
}

if GetConvar("qb_locale", "en") == "fr" then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end