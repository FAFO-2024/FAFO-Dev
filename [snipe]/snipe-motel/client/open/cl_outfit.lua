function OpenOutfit()
    if Config.Clothing == "qb" then
        TriggerEvent("qb-clothing:client:openOutfitMenu")
    elseif Config.Clothing == "illenium" then
        TriggerEvent("illenium-appearance:client:openOutfitMenu")
    elseif Config.Clothing == "fivem" then
        TriggerEvent("fivem-appearance:browseOutfits")
    elseif Config.Clothing == "rcore" then
        TriggerEvent("rcore_clothes:openOutfits")
    end
end