DiscordConfig = {
    enabled = false, -- Should discord webhooks be used?
    webhook_url = '', -- See https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks
    webhook_title = '{{EVENT_TYPE}} Alert', -- The title of the webhook embed
    webhook_message = 'An ATM on {{STREET}} ({{POSTAL}}) is currently being stolen' -- The message that the webhook displays
}
