function ShowNotification(msg, type)
    if Config.Notify == "ox" then
        lib.notify({type = type, description = msg})
    elseif Config.Notify == "qb" then
        QBCore.Functions.Notify(msg, type)
    elseif Config.Notify == "esx" then
        ESX.ShowNotification(msg)
    elseif Config.Notify == "okok" then
        exports['okokNotify']:Alert("Bundles", msg, 5000, type)
    end
end

function DrawTexts()
    drawTxt(0.8, 0.60, 0.4,0.4,0.30, "D to change Z coordinates", 55, 155, 55, 255)
    drawTxt(0.8, 0.63, 0.4,0.4,0.30, "W to change y", 55, 155, 55, 255)
    drawTxt(0.8, 0.66, 0.4,0.4,0.30, "G to change x", 55, 155, 55, 255)
    drawTxt(0.8, 0.69, 0.4,0.4,0.30, "H to change heading", 55, 155, 55, 255)
    drawTxt(0.8, 0.72, 0.4,0.4,0.30, "Scroll Wheel to move it around selected", 55, 155, 55, 255)
    drawTxt(0.8, 0.75, 0.4,0.4,0.30, "Press E to place, Esc/backspace to cancel", 55, 155, 55, 255)
    drawTxt(0.8, 0.78, 0.4,0.4,0.4, "Currently Selected: "..change, 255, 0, 0, 255)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


local function OpenStash(stash_id, itemName)
    if Config.Inventory == "qb" or Config.Inventory == "qsv2" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "furniture_stash_"..stash_id, {
            maxweight = Config.FurnitureStash[itemName].size,
            slots = Config.FurnitureStash[itemName].slots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "furniture_stash_"..stash_id)
    elseif Config.Inventory == "ox" then
        TriggerServerEvent("snipe-furniturestash:server:registerStash", "furniture_stash_"..stash_id, "ox", itemName)
        exports.ox_inventory:openInventory("stash", "furniture_stash_"..stash_id)
    end
end

function DoTargetStuff(entity, stashId, roomNo, itemName)
    exports["qb-target"]:AddTargetEntity(entity, {
        options = {
            {
                action = function()
                    OpenStash(stashId, itemName)
                end,
                icon = "fas fa-door-open",
                label = "Open Stash",
                canInteract = function()
                    return (Config.AllowEveryoneToAccessStash or roomNo == exports["snipe-motel"]:currentPlayerRoom())
                end
            },
            {
                action = function()
                    PickUpStash(stashId, itemName)
                end,
                icon = "fas fa-door-open",
                label = "Pick Up Stash",
                canInteract = function()
                    return (roomNo == exports["snipe-motel"]:currentPlayerRoom())
                end
            }
        },
        distance = 1.5
    })
end