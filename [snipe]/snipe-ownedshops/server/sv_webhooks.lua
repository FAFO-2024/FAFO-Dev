local WebHooks = {
    ["add"] = "https://discord.com/api/webhooks/1240514723586510869/NI5xN9Lnr5brx9rJ0r1a3LVZUtDDhuHjZRB4XPmS71S0bKyPvpKGDtECaJJZvnLS8HHo",
    ["buy"] = "https://discord.com/api/webhooks/1240514788119937095/_vR4axUWfezKWFS0ZncNc-eGBDa9qJsaRM2WvHeCWPXIIqozeBi5SrGMG1hFPoNE0P7Y",
    ["buyNormal"] = "https://discord.com/api/webhooks/1240514854284955680/e2FpuSN3X6daWBhOO03-R0Vl9LeiHT2RQajgUHo62JnLgxTbEPUCMpbJl_r1BNtZ5zPG",
}

local function GetBuyItemMessage(source, data)
    local message = "**"..GetPlayerName(source).."** ("..source..") \n"
    for k, v in pairs(data.items) do
        message = message.." **Bought Item**: "..v.item.." **Amount**: "..v.amount.." \n"
    end
    message = message.." **From Shop**: "..data.shopName.. "\n"
    message = message.." **Total Price**: "..data.cost
    return message
end

function SendLogs(source, data)
    local colorcode = 1752220
    local message = ""
    if data.type == "add" then -- Add Item to shops
        colorcode = 5763719
        message = "**"..GetPlayerName(source).."** ("..source..")\n**Added Item**: "..data.item.." **Shop**: "..data.shopName.." **Amount Added**: "..data.amount
    elseif data.type == "buy" then -- buy owned shops
        colorcode = 15548997
        message = GetBuyItemMessage(source, data)
    elseif data.type == "buyNormal" then -- Normal Shops
        message = GetBuyItemMessage(source, data)
        colorcode = 16776960
    end
    -- local description = ""
    -- if source == 0 then
    --     description = "**"..message.."**"
    -- else
    --     description = "**"..GetPlayerName(source).."** ("..source..")\n"..message
    -- end
    -- if type == "report" then
    --     description = "**"..GetPlayerName(source).."** ".. message
    -- end
    local embedData = {
        {
            ["title"] = "Owned Shop Logs" ,
            ["color"] = colorcode,
            ["footer"] = {
                ["text"] = os.date("%c"),
            },
            ["description"] = message,
            ["author"] = {
            ["name"] = 'Snipe Owned Shop Logs',
            },
        }
    }
    PerformHttpRequest(WebHooks[data.type], function(err, text, headers) end, 'POST', json.encode({ username = "Snipe Logs",embeds = embedData}), { ['Content-Type'] = 'application/json' })
end

