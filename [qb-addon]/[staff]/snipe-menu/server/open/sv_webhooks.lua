local WebHooks = {
    ["exploit"] = "https://discord.com/api/webhooks/1125136833492287488/t9Pn2X6w5Q9wAflJ7l3XTWmUMpf4TlOM1K_Urp4ZtqM74ztl2OH75Hx-BIXaV7JAGgqA",
    ["triggered"] = "https://discord.com/api/webhooks/1125136883777802411/InHC88rd-43LmXcAlkDvViYIuKiIUxa7EoafHnLWZalh-h1P6cxy3ic3HNfcc4u9uzYj",
    ["report"] = "https://discord.com/api/webhooks/1125136935128670378/P6z3fq8-DSSH81HylDnllxyjYEyRnvyw0KI9ZRpE2uDSEiatmGt_MPrierzR_dFq_mZm",
    ["transcript"] = "https://discord.com/api/webhooks/1125136990531231754/9nCtnUv7EKtDxulOAIbjYy-t4RMSYJDULUMakDjnNvOmrkh_t_SZhAalycX2TUeEZjCV",
    ["bans"] = "https://discord.com/api/webhooks/1140777672574771341/95mURZIj9tGGIYKC0hrPpXFHtAfBroAMi_psFyw4NSu2jm4feyHgDbUlfSuUDiTYHsK4",
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