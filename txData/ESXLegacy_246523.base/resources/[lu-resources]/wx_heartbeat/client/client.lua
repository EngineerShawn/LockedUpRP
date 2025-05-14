AddEventHandler('onClientResourceStop', function(resourceName)
    if resourceName == heartbeat.AntiCheatResource then
        CancelEvent()
        TriggerServerEvent('Q8zdjIrnFnsIXaWhONbOETdf2n0BNwzF:5ZIOoON9x8hYfbXqalkk8rmKXheizy7A') -- Event for detecting anticheat stopping on client's side
    end
end)