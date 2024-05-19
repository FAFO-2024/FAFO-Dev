local WebHooks = {
    ["exploit"] = "https://discord.com/api/webhooks/1240509290679369811/n5hV0uxI0PTNLzbjrnfut5JWdO0TwaRI_Hacl9AT8AuoWsone1EbFMbktK1iNL8Ufce-",
    ["triggered"] = "https://discord.com/api/webhooks/1240509375244800031/rH5OARBAywsgfPd8MoxufLC1JnhPrCKBF1LWwY7IDdqrNhhN6ZBeW4bH69ZwVx1OrKrH",
    ["report"] = "https://discord.com/api/webhooks/1240509450293612554/HK0WxAFMFgvFwrRFFj0-2HKo3ywhUKgqUkNDw41XFl1UWxIE-lrsKdonA0yot6A1tb7H",
    ["transcript"] = "https://discord.com/api/webhooks/1240509523819757648/yyxcKPMfKYkvEtC3OUlQEL1Bx0PnpaAEP1765te_rUGOVofmerqAQan2HH_y_IVBGdZ3",
    ["bans"] = "https://discord.com/api/webhooks/1240509615012057161/i4yhV4M5HnVbwl4SG7q3NHnUKUE1pyujMLj8mGL5tbFJKCJ4J7HPKthy4cNRdsyj48L4",
}

function SendLogs(source, type, message)
    local colorcode = 5763719
    if type == "exploit" then
        colorcode = 16711680
    end
    local description = ""
    if source == 0 then
        description = "**"..message.."**"
    else
        description = "**"..GetPlayerName(source).."** ("..source..")\n"..message
    end
    if type == "report" then
        description = "**"..GetPlayerName(source).."** ".. message
    end
    local embedData = {
        {
            ["title"] = "Admin Menu Logs" ,
            ["color"] = colorcode,
            ["footer"] = {
                ["text"] = os.date("%c"),
            },
            ["description"] = description,
            ["author"] = {
            ["name"] = 'Snipe Admin Menu Logs',
            },
        }
    }
    if type == "transcript" then
        embedData[1].title = "Chat Transcript (Closed by "..GetPlayerName(source)..")"
        embedData[1].footer.text = "Closed on "..os.date("%c")
        embedData[1].description = message
        description = ""
    end
    PerformHttpRequest(WebHooks[type], function(err, text, headers) end, 'POST', json.encode({ username = "Snipe Logs",embeds = embedData}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent("snipe-menu:server:sendLogs", function(type, message)
    if type == "exploit" then
        SendLogs(source, type, message)
    elseif type == "triggered" then
        SendLogs(source, type, message)
    end
end)