function BanPlayer(id, reason)
    TriggerEvent("wx_anticheat:server:CY8cV5R1F9hhguzzYbnZRYNRp4Cwn1", id, reason)
end


RegisterNetEvent('wx_anticheat:logAdminMenu', function(action)
    if not isAdmin(source) then
        return BanPlayer(source, "Admin Menu Exploit - [Not an Admin]")
    end
    local data = {
        action = action,
        admin = GetPlayerName(source),
        license = GetPlayerIdentifierByType(source, 'license')
    }
    AdminMenuLog(data)
end)

RegisterNetEvent('wx_anticheat:getPlayers',function ()
    local data = {}
    for k,v in pairs(GetPlayers()) do
        table.insert(data,{id = v, playerName = GetPlayerName(v),steamId = GetPlayerIdentifierByType(v,"steam") or "Not Found"})
    end
    TriggerClientEvent('wx_anticheat:syncPlayers',source,data)
end)
RegisterNetEvent('wx_anticheat:GetPlayerIdentifiers',function (playerId)
    local data = {}
    local steam,license,ip,discord,fivem = "Not Found","Not Found","Not Found","Not Found","Not Found"
    for k,v in pairs(GetPlayerIdentifiers(playerId))do
            
          if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steam = v
          elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
          elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
          elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
          elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
            fivem = v
          end
        
      end
    
        
    table.insert(data,{steam=steam,license=license,ip=ip:gsub('ip:', ''),discord=discord:gsub('discord:', ''),fivem=fivem})
    TriggerClientEvent('wx_anticheat:syncIdentifiers',source,data)
end)

RegisterNetEvent('wx_anticheat:getPlayerCount',function ()
    TriggerClientEvent('wx_anticheat:getPlayerCount',source,GetNumPlayerIndices())
end)
local logs = {}
RegisterNetEvent('wx_anticheat:addLog',function (src,event,status)
    if src == "Admin" then src = ("Admin (%s)"):format(GetPlayerName(source)) end
    table.insert(logs,{
        source = src,
        event = event,
        status = status,
        time = os.date("%H:%M")
    })
    TriggerClientEvent('wx_anticheat:syncLogs',source,logs)
end)
RegisterNetEvent('wx_anticheat:getBannedCount',function ()
    local src = source
    local query = "SELECT COUNT(*) as count FROM wx_anticheat"
MySQL.Async.fetchScalar(query, {}, function(result)
    if result then
        local rowCount = tonumber(result)
        TriggerClientEvent('wx_anticheat:getBannedCount',src,rowCount)
    end
end)
end)

RegisterNetEvent('wx_anticheat:getBanList',function ()
    local query = "SELECT banID, playerName, reason FROM wx_anticheat"
    local src=source
    MySQL.Async.fetchAll(query, {}, function(result)
        if result then
            local banData = {}
            for _, row in ipairs(result) do
                table.insert(banData, {
                    banID = row.banID,
                    playerName = row.playerName,
                    reason = row.reason
                })
            end

            -- Trigger the client event with the ban data as JSON
            TriggerClientEvent('wx_anticheat:syncBans',src,banData)
        else
            print("Error retrieving ban data")
        end
    end)
end)

RegisterNetEvent('wx_anticheat:getAdminCount',function ()
    local admincount = 0
    for k,admin in pairs(GetPlayers()) do
        if isAdmin(tonumber(admin)) then
            admincount+=1
        end
    end
    TriggerClientEvent('wx_anticheat:getAdminCount',source,admincount)
end)

RegisterNetEvent('wx_anticheat:deleteVehicles', function()
    if not isAdmin(source) then
        return BanPlayer(source, "Admin Menu Exploit - [Not an Admin]")
    end
    for i, veh in pairs(GetAllVehicles()) do
        DeleteEntity(veh)
    end
end)
RegisterNetEvent('wx_anticheat:requestModelDeletion', function(model)
    if not isAdmin(source) then
        return BanPlayer(source, "Admin Menu Exploit - [Not an Admin]")
    end
    TriggerClientEvent('wx_anticheat:syncObjectDeletion',-1,model)
end)

RegisterNetEvent('wx_anticheat:banPlayer', function(id,reason)
    if not isAdmin(source) then
        return BanPlayer(source, "Admin Menu Exploit - [Not an Admin]")
    end
    BanPlayer(id, reason)
end)
RegisterNetEvent('wx_anticheat:requestPlayerScreenshot', function(id)
    if not isAdmin(source) then
        return BanPlayer(source, "Admin Menu Exploit - [Not an Admin]")
    end
    TriggerClientEvent('wx_anticheat:screenshotPlayer',id)
end)

RegisterNetEvent('wx_anticheat:syncScreenshot',function (url)
    TriggerClientEvent('wx_anticheat:syncScreenshot',-1,url)
end)

RegisterNetEvent('wx_anticheat:deletePeds', function()
    if not isAdmin(source) then
        return BanPlayer(source, "Admin Menu Exploit - [Not an Admin]")
    end
    for i, ped in pairs(GetAllPeds()) do
        DeleteEntity(ped)
    end
end)
RegisterNetEvent('wx_anticheat:deleteObjects', function()
    if not isAdmin(source) then
        return BanPlayer(source, "Admin Menu Exploit - [Not an Admin]")
    end
    for i, obj in pairs(GetAllObjects()) do
        DeleteEntity(obj)
    end
end)


RegisterNetEvent('wx_anticheat:deleteAll', function()
    if not isAdmin(source) then
        return BanPlayer(source, "Admin Menu Exploit - [Not an Admin]")
    end
    for i, obj in pairs(GetAllObjects()) do
        DeleteEntity(obj)
    end
    for i, ped in pairs(GetAllPeds()) do
        DeleteEntity(ped)
    end
    for i, veh in pairs(GetAllVehicles()) do
        DeleteEntity(veh)
    end
end)

RegisterNetEvent('wx_anticheat:unban', function(banId)
    if not isAdmin(source) then
        return BanPlayer(source, "Admin Menu Exploit - [Not an Admin]")
    end
    if wx.banIDFormat == 1 then
        local banID = tostring(banId)
        MySQL.Async.fetchAll(
          "SELECT * FROM `wx_anticheat` WHERE `banID` = @banID",
          {
            ["@banID"] = banID,
          },
          function(data)
            if data[1] then
                UnbanLogs(data[1].playerName, data[1].reason, data[1].banID, data[1].discordid)
                TriggerEvent("wx_anticheat:playerUnbanned", banID)
                BetterPrint(("Player ^3%s^7 - [^3%s^7] has been unbanned!"):format(data[1].playerName, data[1].banID),
                "success")
            else
                BetterPrint("Couldn't find the specified Ban ID. (Example: wx unban ALJJ-A64V)", 'error')
            end
          end)
        MySQL.Async.execute('DELETE FROM wx_anticheat WHERE banID = @banID', { ['banID'] = banID },
          function(affectedRows)
            if affectedRows ~= 0 then
              -- local reason, playername, discordid, banid
            else
              BetterPrint("Couldn't find the specified Ban ID. (Example: wx unban ALJJ-A64V)", 'error')
            end
          end)
      else
        local num = tostring(banId)
        local banID = "#" .. num
        MySQL.Async.fetchAll(
          "SELECT * FROM `wx_anticheat` WHERE `banID` = @banID",
          {
            ["@banID"] = banID,
          },
          function(data)
            UnbanLogs(data[1].playerName, data[1].reason, data[1].banID, data[1].discordid)
            TriggerEvent("wx_anticheat:playerUnbanned", banID)
            BetterPrint(("Player ^3%s^7 - [^3%s^7] has been unbanned!"):format(data[1].playerName, data[1].banID),
              "success")
          end)
        MySQL.Async.execute('DELETE FROM wx_anticheat WHERE banID = @banID', { ['banID'] = banID },
          function(affectedRows)
            if affectedRows ~= 0 then
              -- local reason, playername, discordid, banid
            else
              BetterPrint(
                "Couldn't find the specified Ban ID. Make sure NOT to include the '#'. (Example: wx unban 1234)", 'error')
            end
        end)
    end
end)



