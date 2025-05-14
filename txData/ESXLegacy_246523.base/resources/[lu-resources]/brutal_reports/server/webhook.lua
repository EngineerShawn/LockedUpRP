--------------------------------------------------------------------------
-------------------------------| WEBHOOK |--------------------------------
--------------------------------------------------------------------------

BotName = 'Brutal Reports'

function DiscordWebhook(TITLE, MESSAGE, COLOR)
    local information = {
        {
            ["color"] = COLOR,
            ["author"] = {
                ["icon_url"] = 'https://i.ibb.co/KV7XX6m/brutal-scripts.png',
                ["name"] = BotName..' - Logs',
            },
            ["title"] = '**'.. TITLE ..'**',
            ["description"] = MESSAGE,
            ["fields"] = {
                {
                    ["name"] = Config.Webhooks.Locale['Time'],
                    ["value"] = os.date('%d/%m/%Y - %X')
                }
            },
            ["footer"] = {
                ["text"] = 'Brutal Scripts - Made by Keres & Dév',
                ["icon_url"] = 'https://i.ibb.co/KV7XX6m/brutal-scripts.png'
            }
        }
    }
    PerformHttpRequest(GetWebhook(), function(err, text, headers) end, 'POST', json.encode({avatar_url = IconURL, username = BotName, embeds = information}), { ['Content-Type'] = 'application/json' })
end