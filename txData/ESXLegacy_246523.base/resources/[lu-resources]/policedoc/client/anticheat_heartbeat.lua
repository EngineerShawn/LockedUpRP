if not wx.HeartBeat.enabled then return end

local connected = false

function RandomKey(length)
    local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local randomString = ""

    for _ = 1, length do
        local randomIndex = math.random(1, #characters)
        randomString = randomString .. string.sub(characters, randomIndex, randomIndex)
    end

    return randomString
end


AddEventHandler('playerSpawned', function()
    if connected then return end
    connected = true
end)
math.randomseed(math.random(5937862,278365235))
TriggerServerEvent("mMkHcvct3uIg04STT16I:cbnF2cR9ZTt8NmNx2jQS",RandomKey(math.random(15,30)))

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        if connected then
            TriggerServerEvent("mMkHcvct3uIg04STT16I:cbnF2cR9ZTt8NmNx2jQS",RandomKey(math.random(5,15)))
        end
    end
end)