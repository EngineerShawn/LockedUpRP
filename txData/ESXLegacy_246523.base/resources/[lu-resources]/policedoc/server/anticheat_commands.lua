local offlineplayers = {}

local function reloadConfig(config)
  local resourceName = GetCurrentResourceName()
  local mod = LoadResourceFile(resourceName, config)

  if not mod then
    print("ERROR: THE CONFIG IS INVALID: " .. config)
    return
  end

  local modload, e = load(mod)
  if not modload then
    print("CONFIG RELOAD ERROR: " .. e)
    return
  end

  modload()
end

local help = [[
    ^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^7
    [WX ANTICHEAT HELP]

    (optional argument)
    <required argument>

    wx update - [Checks for updates]
    wx reload - [Reloads all the configuration files without needing to restart the script]
    wx banlist - [Check how many players have been banned so far]

    wx (help) - [Shows this help menu]
    wx ban <id> (reason) - [Bans specified player]
    wx baninfo <ban id> - [Shows info about ban id]
    wx offlineban <id> (reason) - [Bans player that is no longer on the server via ID]
    wx unban <ban id> - [Unbans specified player]


    wx clearvehicles - [Clears every vehicle on the server]
    wx clearpeds - [Clears every ped on the server]
    wx clearobjects - [Clears every object on the server]
    wx clearall - [Clears everything on the server]

    ^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^4~^6~^7

    ]]

AddEventHandler('playerDropped', function()
  local HWID5 = "Not Found"
  local HWID4 = "Not Found"
  local HWID3 = "Not Found"
  local HWID2 = "Not Found"
  local HWID = "Not Found"
  HWID = GetPlayerToken(source, 1)
  HWID2 = GetPlayerToken(source, 2)
  HWID3 = GetPlayerToken(source, 3)
  HWID4 = GetPlayerToken(source, 4)
  HWID5 = GetPlayerToken(source, 5)
  local steam = "Not Found"
  local ip = "Not Found"
  local discord = "Not Found"
  local license = "Not Found"
  local fivem = "Not Found"

  for k, v in pairs(GetPlayerIdentifiers(source)) do
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      steam = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      license = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = v
    elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
      fivem = v
    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
      ip = v
    end
  end
  local src = tostring(source)
  table.insert(offlineplayers, {
    [src] = {
      licence = license,
      steam = steam,
      discord = discord,
      fivem = fivem,
      ip = ip,
      HWID = HWID,
      HWID2 = HWID2,
      HWID3 = HWID3,
      HWID4 = HWID4,
      HWID5 = HWID5,
      playername = GetPlayerName(source)
    }
  })
end)

RegisterCommand("wx", function(source, args)
  if source == 0 then
    if args[1] == 'ban' then
      local target = args[2]
      if GetPlayerName(target) ~= nil then
        local reason = "[CONSOLE] " .. table.concat(args, " ", 3)
        exports[GetCurrentResourceName()]:ban(target, reason)
      else
        BetterPrint("Couldn't find the specified player ID", "error")
      end
    elseif args[1] == 'offlineban' then
      local target = args[2]
      -- print(json.encode(offlineplayers,{indent=true}))
      -- print(offlineplayers[1][target].ip)
      if offlineplayers[1][target] ~= nil then
        local reason = "[OFFLINE BAN] " .. table.concat(args, " ", 3)
        exports[GetCurrentResourceName()]:offlineban(offlineplayers[1][target], reason)
      else
        BetterPrint("Couldn't find the specified player ID", "error")
      end
    elseif args[1] == 'unban' then
      if wx.banIDFormat == 1 then
        local banID = tostring(args[2])
        MySQL.Async.fetchAll(
          "SELECT * FROM `wx_anticheat` WHERE `banID` = @banID",
          {
            ["@banID"] = banID,
          },
          function(data)
            if data then
              UnbanLogs(data[1].playerName, data[1].reason, data[1].banID, data[1].discordid)
              TriggerEvent("wx_anticheat:playerUnbanned", banID)
              BetterPrint(("Player ^3%s^7 - [^3%s^7] has been unbanned!"):format(data[1].playerName, data[1].banID),
                "success")
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
        local num = tostring(args[2])
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
    elseif args[1] == 'baninfo' then
      local banid = tostring(args[2])
      if not args[2] then
        return BetterPrint("Please specify the Ban ID", 'error')
      end
      MySQL.Async.fetchAll(
        "SELECT * FROM `wx_anticheat` WHERE `banID` = @banID",
        {
          ["@banID"] = banid,
        },
        function(data)
          if not data[1] then
            return BetterPrint("Couldn't find the specified Ban ID", 'error')
          end
          print(([[
Info about %s:

//
[[ Player Name: %s
[[ Ban Reason: %s
[[ Discord ID: %s
[[ License: %s
[[ Steam: %s
\\
]]):format(banid, data[1].playerName, data[1].reason, data[1].discordid, data[1].license, data[1].steamid))
        end)
    elseif args[1] == 'clearvehicles' then
      for i, veh in pairs(GetAllVehicles()) do
        DeleteEntity(veh)
      end
      BetterPrint("All vehicles have been deleted", 'success')
    elseif args[1] == 'clearpeds' then
      for i, ped in pairs(GetAllPeds()) do
        DeleteEntity(ped)
      end
      BetterPrint("All peds have been deleted", 'success')
    elseif args[1] == 'clearobjects' then
      for i, obj in pairs(GetAllObjects()) do
        DeleteEntity(obj)
      end
      BetterPrint("All objects have been deleted", 'success')
    elseif args[1] == 'clearall' then
      for i, obj in pairs(GetAllObjects()) do
        DeleteEntity(obj)
      end
      for i, ped in pairs(GetAllPeds()) do
        DeleteEntity(ped)
      end
      for i, veh in pairs(GetAllVehicles()) do
        DeleteEntity(veh)
      end
      BetterPrint("All vehicles, peds and objects have been deleted", 'success')
    elseif args[1] == 'update' then
      CheckUpdates()
    elseif args[1] == 'reload' then
      print('^7[^4 INFO ^7] 🔄 Reloading main config...')
      print('^7[^4 INFO ^7] 🔄 Reloading webhook config...')
      Citizen.SetTimeout(math.random(100, 300), function()
        reloadConfig("configs/anticheat_webhooks.lua")
        print('^7[^4 INFO ^7] ✅ Webhooks has been reloaded!')
      end)
      print('^7[^4 INFO ^7] 🔄 Reloading OCR config...')
      Citizen.SetTimeout(math.random(100, 300), function()
        reloadConfig("ocr/anticheat_ocr.lua")
        print('^7[^4 INFO ^7] ✅ OCR config has been reloaded!')
      end)
      Citizen.SetTimeout(500, function()
        print('^7[^4 INFO ^7] ✅ All configs has been reloaded!')
      end)
    elseif args[1] == 'banlist' then
      GetBannedPlayers()
    else
      print(help)
    end
  else
    if not isAdmin(source) then
      TriggerClientEvent('chat:addMessage', source, {
        template = [[
          <div style="padding: 0.3vw; height: auto; margin: 0.5vw; background-color: #222228ec; border-radius: 10px; padding-top: 0.35vw; border: 0.11vw solid #414146; box-shadow: 0px 0px 11px rgba(158, 158, 158, 0.35)">
          <font style="padding: 0.15vw; margin: 0.22vw; background-color: #922a2a; padding-left: 1%; border-radius: 8px; border: #c72f2f solid 0.11vw; font-size: 12px; box-shadow: 0px 0px 11px rgba(156, 21, 21, 0.55)">
             <font style="font-weight: 600;"><i class="fa-solid fa-shield"></i> WX ANTICHEAT</font>
          </font>
          <font style="font-size: 14px; padding-left: 5px; color: #c7c5c5; margin: auto; font-weight:400"></font>
          <font class="message" style="font-size: 14px; color: #a8a7a7; margin: auto; font-weight:400">You don't have permissions to use this command!</b></font>
      </div>
        ]],        args = {}
        })
      -- print("[anticheat.0wx.space] You don't have permissions to use this command!")
    else
      if isAdmin(source) then
        TriggerClientEvent('wx_anticheat:openAdminMenu', source, { allowed = isAdmin(source) })
      end
    end
  end
end, false)
