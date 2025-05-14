


----------------------------------------------------------------------------------------------
------------------------------------| BRUTAL REPORTS :) |-------------------------------------
----------------------------------------------------------------------------------------------

--[[

Hi, thank you for buying our script, We are very grateful!

For help join our Discord server:     https://discord.gg/85u2u5c8q9
More informations about the script:   https://docs.brutalscripts.com

--]]

Config = {
    Core = 'ESX',  -- ESX / QBCORE / STANDALONE  | Other core setting on the 'core' folder and the client and server utils.lua
    ReportMenu = {Command = 'report', CommandLabel = 'Use the command to open the Report Menu'},
    AdminMenu = {Command = 'reports', CommandLabel = 'Use the command to open the Report List'},
    AdminNotify = {Command = 'an', CommandLabel = 'Use the command to switch off/on the report admin notifys'},

    PlayerLoadedTime = 5000, -- in ms | 1000 = 1 sec (Only if the Core = STANDALONE)
    IdentifierType = 'core',  -- core / steam / license / discord | What you can copy in the admin menu!

    AdminGroups = {'superadmin', 'admin', 'mod'},  -- Only if the Core = ESX / QBCORE
    IdentifierPermission = false,  -- If Core = STANDALONE then this is in use

    Admins = {
        'discord:806082985861447691',
        'discord:692782027866636308',

        --[[ TYPES ]]--
        -- 'steam:123456789',
        -- 'license:123456789',
        -- 'fivem:123456789',
        -- 'ip:123456789',
        -- 'discord:123456789',
    },

    --[[ Add your Webhook in >> server-utils.lua ]]--
    Webhooks = {
        Locale = {
            ['New Report'] = 'New Report',
            ['Closed Report'] = 'Closed Report',

            ['Category'] = 'Category',
            ['Title'] = 'Title',
            ['Description'] = 'Description',
            ['Player details'] = 'Player details',
            ['Admin details'] = 'Admin details',
            ['ID'] = 'ID',
            ['Name'] = 'Name',
            ['Identifier'] = 'Identifier',
            ['Discord'] = 'Discord',

            ['Time'] = 'Time ⏲️'
        },
        -- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html
        Colors = {
            ['newReport'] = 16776960, 
            ['closeReport'] = 16711680
        }
    },

    -----------------------------------------------------------
    -----------------------| TRANSLATE |-----------------------
    -----------------------------------------------------------

    NoneAdmin = 'None',
    Report = 'Report #',

    Notify = {
        [1] =  {'Brutal Reports', "An admin send you a Message!", 5000, 'info'},
        [2] =  {'Brutal Reports', "You don't have permission to use the Command!", 5000, 'error'},
        [3] =  {'Brutal Reports', "Your report has been closed!", 5000, 'info'},
        [4] =  {'Brutal Reports', "You have got freeze!", 5000, 'info'},
        [5] =  {'Brutal Reports', "You have got unfreeze!", 5000, 'info'},
        [6] =  {'Brutal Reports', "You have got revive!", 5000, 'info'},
        [7] =  {'Brutal Reports', "A new report has arrived!", 5000, 'info'},
        [8] =  {'Brutal Reports', "Has been closed!", 5000, 'info'},
        [9] =  {'Brutal Reports', "Admin Notify: OFF", 5000, 'info'},
        [10] = {'Brutal Reports', "Admin Notify: ON", 5000, 'info'},
        [11] = {'Brutal Reports', "The title is too long,<br>Maximum 25 character!", 5000, 'error'},
        [12] = {'Brutal Reports', "Please fill all the spaces!", 5000, 'error'},
        [13] = {'Brutal Reports', "You can't open your own report!", 5000, 'error'},
    }
}