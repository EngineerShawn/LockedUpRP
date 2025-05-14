if Config.Core:upper() == 'ESX' then
    LoadedEvent = 'esx:playerLoaded'
    ReviveEvent = 'esx_ambulancejob:revive'
elseif Config.Core:upper() == 'QBCORE' then
    LoadedEvent = 'QBCore:Client:OnPlayerLoaded'
    ReviveEvent = 'hospital:client:Revive'
end

-- Buy here: (4€+VAT) https://store.brutalscripts.com
function notification(title, text, time, type)
    exports['brutal_notify']:SendAlert(title, text, time, type)

    --SetNotificationTextEntry("STRING")
    --AddTextComponentString(text)
    --DrawNotification(0,1)

    -- Default ESX Notify:
    --TriggerEvent('esx:showNotification', text)

    -- Default QB Notify:
    --TriggerEvent('QBCore:Notify', text, 'info', 5000)
end