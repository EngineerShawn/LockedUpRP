if not wx.HeartBeat.enabled then return end

local playerHeartbeats = {}


local function onPlayerDisconnected()
    local playerId = source
    playerHeartbeats[playerId] = nil
end
AddEventHandler("playerDropped", onPlayerDisconnected)

RegisterServerEvent("mMkHcvct3uIg04STT16I:cbnF2cR9ZTt8NmNx2jQS")
AddEventHandler("mMkHcvct3uIg04STT16I:cbnF2cR9ZTt8NmNx2jQS", function()
    local playerId = source
    playerHeartbeats[playerId] = os.time()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        for playerId, lastHeartbeatTime in pairs(playerHeartbeats) do
            if lastHeartbeatTime == nil then return end
            local currentTime = os.time()
            local timeSinceLastHeartbeat = currentTime - lastHeartbeatTime
            if timeSinceLastHeartbeat > wx.HeartBeat.maxTime then
                DropPlayer(playerId, "[anticheat.0wx.space] You have lost connection to the anticheat")
                BetterPrint(("Player [%s] %s didn't sent any heartbeat to the server in required time. Disconnecting him..."):format(playerId, GetPlayerName(playerId)),"info")
                playerHeartbeats[playerId] = nil
            end
        end
    end
end)