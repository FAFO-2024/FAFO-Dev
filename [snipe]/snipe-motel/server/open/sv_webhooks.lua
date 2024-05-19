local webhooks = {
    ["lockdown"] = ""
}

function SendLogs(type, source, message, state)

    local embedData = {
        {
            ["title"] = "Motel Logs" ,
            ["color"] = state and 16711680 or 5763719,
            ["footer"] = {
                ["text"] = os.date("%c"),
            },
            ["description"] = message,
            ["author"] = {
            ["name"] = 'Snipe Motel Logs',
            },
        }
    }
    PerformHttpRequest(webhooks[type], function(err, text, headers) end, 'POST', json.encode({ username = "Snipe Motel System",embeds = embedData}), { ['Content-Type'] = 'application/json' })
end