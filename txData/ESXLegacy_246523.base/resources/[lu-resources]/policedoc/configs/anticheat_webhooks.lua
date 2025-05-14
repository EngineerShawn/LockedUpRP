Webhooks = {}  -- [[ Do not change ]]

Webhooks.WebHook = '' -- [[ Main Webhook for all of your detections | REQUIRED]]
Webhooks.WebHookConnect = '' -- [[ Webhook for logging all connecting players | OPTIONAL ]]
Webhooks.OCR = '' -- [[ Webhook for saving player's screenshots, used for checking afterwards via OCR. You will receive A LOT of screenshots there ]]

-- [ You can set different webhooks here for different logs ]
Webhooks.ExplosionWebhook = ''  -- [[ Explosion data logs | OPTIONAL ]]
Webhooks.ObjectWebhook = '' -- [[ Object creation logs | OPTIONAL ]]
Webhooks.ChatWebhook = '' -- [[ Chat messages logs | OPTIONAL ]]
Webhooks.ResourceWebhook = '' -- [[ Resource Start/Stop logs | OPTIONAL ]]
Webhooks.AdminMenuLogs = '' -- [[ Logging of admin menu actions (options, bans, ...) | REQUIRED ]]
Webhooks.UnbanWebhook = '' -- [[ Logs for player unbans | REQUIRED ]]

-- [ Webhook Settings ]
Webhooks.WebhookUsername = 'WX AntiCheat' -- [[ Username for all of your webhooks | OPTIONAL ]]
Webhooks.WebhookColor = 16419304  -- [[ Decimal color for all of your webhooks (use https://spycolor.com) | OPTIONAL ]]
Webhooks.WebhookAvatar ='https://media.discordapp.net/attachments/1132686300026241106/1175499450106511450/wxaclogo.png' -- [[ Profile picture (image) link for all of your webhooks | OPTIONAL ]]
Webhooks.WebhookInlines = true  -- [[ true = Webhook fields will be mostly in one line / false = Every field on new line | REQUIRED ]]
