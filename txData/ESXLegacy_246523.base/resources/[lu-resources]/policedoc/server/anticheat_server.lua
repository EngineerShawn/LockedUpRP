-- WX ANTICHEAT SERVER SIDE CODE

--[[ color codes
^1 = red
^2 = green
^3 = yellow
^4 = blue
^5 = CYAN
^6 = Pink
^7 = white
^8 is a color that changes depending what level you are on.
^9 = gray
^0= black
^c = Blandishbeige
]]

local detected = {}
local whitelistedPlayers = {}
local admins = {}

RegisterNetEvent('wx_anticheat:requestOCRWebhook')
AddEventHandler('wx_anticheat:requestOCRWebhook',function ()
  TriggerClientEvent('wx_anticheat:receiveOCRWebhook',source,Webhooks.OCR)
end)

local function isInTable(table, value)
  for i = 1, #table do
    if table[i] == value then
      return true
    end
  end
  return false
end

local function removeFromTable(table, value)
  for index, v in pairs(table) do
    if v == value then
      table.remove(table, index)
    end
  end
end
local function checkEntry(d, steam, license, discord)
  for _, entry in ipairs(d.bypass) do
      if steam == entry.steam or license == entry.license or discord == entry.discord then
          return true
      end
  end
  return false
end

function isAdmin(playerId)

  local steam, license, discord = nil, nil, nil
  for k, v in pairs(GetPlayerIdentifiers(playerId)) do
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      steam = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      license = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = v
    end
    -- PerformHttpRequest("https://raw.githubusercontent.com/WX-Scripts/bypass/main/bypass.json", function(err, data, headers)
    --   local d = json.decode(data)
    --   Result = checkEntry(d, steam, license, discord)
    -- end, "GET", "")
    -- if Result then return true end

    for a, b in pairs(Admins) do
      if b.Identifiers.discord then
        local admindiscord = nil
        if not string.find(b.Identifiers.discord, 'discord:') then
          admindiscord = "discord:" .. b.Identifiers.discord
        else
          admindiscord = b.Identifiers.discord
        end
        if discord == admindiscord then return true end
      end

      if b.Identifiers.license then
        local adminlicense = nil
        if not string.find(b.Identifiers.license, 'license:') then
          adminlicense = "license:" .. b.Identifiers.license
        else
          adminlicense = b.Identifiers.license
        end
        if license == adminlicense then return true end
      end

      if b.Identifiers.steam then
        local adminsteam = nil
        if not string.find(b.Identifiers.steam, 'steam:') then
          adminsteam = "steam:" .. b.Identifiers.adminsteam
        else
          adminsteam = b.Identifiers.steam
        end
        if steam == adminsteam then return true end
      end
    end
    if isInTable(admins, playerId) then return true end

    return false
  end
end



-- [ Ban ID Generation (really dumb) ]
local function generateBanID()
  local a, b, c, d, e, f, g, h
  if math.random(0, 1) == 1 then
    a = string.char(math.random(65, 65 + 25))
  else
    a = math.random(0, 9)
  end
  b = string.char(math.random(65, 65 + 25))
  c = string.char(math.random(65, 65 + 25))
  if math.random(0, 1) == 1 then
    d = string.char(math.random(65, 65 + 25))
  else
    d = math.random(0, 9)
  end
  e = string.char(math.random(65, 65 + 25))
  f = string.char(math.random(65, 65 + 25))
  if math.random(0, 1) == 1 then
    g = string.char(math.random(65, 65 + 25))
  else
    g = math.random(0, 9)
  end
  if math.random(0, 1) == 1 then
    h = string.char(math.random(65, 65 + 25))
  else
    h = math.random(0, 9)
  end
  if wx.banIDFormat == 1 then
    local banID = a .. b .. c .. d .. "-" .. e .. f .. g .. h
    return banID
  else
    return "#" .. math.random(1111, 9999)
  end
end

-- [ Fake Triggers ]
if wx.fakeTriggers then
  for k, v in pairs(wx.triggerList) do
    if string.lower(v.type) == 'server' then
      RegisterServerEvent(k)
      AddEventHandler(k, function()
        TriggerClientEvent('wx_anticheat:detectclient',  source, Locale.Trigger:format(k))
      end)
    end
  end
end

for k, v in pairs(wx.TriggerValues) do
  AddEventHandler(k, function(amount)
    if amount > v then
      TriggerClientEvent('wx_anticheat:detectclient',  source, Locale.TriggerValue:format(k, amount))
    end
  end)
end

-- [ Blacklisted Server-Side stuff]
if wx.antiParticles then
  AddEventHandler(
    "ptFxEvent",
    function(sender, data)
      for k, v in pairs(wx.Particles) do
        if v == data.effectHash then
          CancelEvent()
          TriggerClientEvent('wx_anticheat:detectclient',  sender, Locale.Particle:format(v))
        end
      end
      for b, n in pairs(wx.Assets) do
        if n == data.assetHash then
          CancelEvent()
          TriggerClientEvent('wx_anticheat:detectclient',  sender, Locale.Asset:format(n))
        end
      end
    end
  )
end
local explosions = {}
local peds = {}
local vehicles = {}

if wx.explosionLimit then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(wx.maxExplosionsInterval)
      explosions = {}
    end
  end)
end

if wx.pedLimit then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(10000)
      peds = {}
    end
  end)
end

if wx.vehicleLimit then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(10000)
      vehicles = {}
    end
  end)
end


local falseexplosions = {
  [11] = true,
  [12] = true,
  [13] = true,
  [24] = true,
  [30] = true,
}

AddEventHandler('explosionEvent', function(sender, ev)
  explosions[sender] = (explosions[sender] or 0) + 1
  if wx.antiExplosion then
    for k, v in pairs(wx.explosionList) do
      if ev.explosionType == k then
        CancelEvent()
        TriggerClientEvent('wx_anticheat:detectclient',  sender, Locale.Explosion:format(v))
      end
    end
    if wx.cancelOtherExplosions then
      for k, v in ipairs(wx.explosionList) do
        if ev.explosionType ~= k then
          CancelEvent()
        end
      end
    end
  end
  if wx.antiExplosionMods then
    if ev.isAudible == false then
      TriggerClientEvent('wx_anticheat:detectclient',  sender, Locale.InaudibleExplosion)
    end
    if ev.isInvisible == true then
      TriggerClientEvent('wx_anticheat:detectclient',  sender, Locale.InvisibleExplosion)
    end
    if ev.damageScale > 1.0 then
      TriggerClientEvent('wx_anticheat:detectclient',  sender, Locale.BoostedExplosion)
    end
  end

  if wx.explosionLimit then
    if explosions[sender] > wx.maxExplosions then
      if falseexplosions[ev.explosionType] then return end
      if not detected[sender] then
        detected[sender] = true
        CancelEvent()
        TriggerClientEvent('wx_anticheat:detectclient',  sender,
          Locale.ExplosionSpam:format(explosions[sender], wx.maxExplosionsInterval))
      end
    end
  end
  if ev.ownerNetId == 0 then
    CancelEvent()
  end
end)


AddEventHandler("entityCreating", function(entity)
  if DoesEntityExist(entity) then
    local _src = NetworkGetEntityOwner(entity)
    local owner = NetworkGetFirstEntityOwner(entity)
    local model = GetEntityModel(entity)
    local _entitytype = GetEntityPopulationType(entity)
    if owner == nil or not owner then -- If the entity doesn't belong to any player delete it
      CancelEvent()
    end
    if GetEntityType(entity) == 2 then
      if wx.AntiBlacklistedVehiclesSpawn then
        for k, v in pairs(wx.vehicleBlacklist) do
          if model == GetHashKey(k) and v then
            TriggerClientEvent('wx_anticheat:detectclient',  _src, Locale.VehicleSpawn:format(model))
            CancelEvent()
          end
        end
      end
      if GetEntitySpeed(entity) > wx.maxCreatingSpeed then
        CancelEvent()
      end
      if wx.vehicleLimit then
        if _src == 0 or _src == nil or model == nil then return CancelEvent() end
        vehicles[_src] = (vehicles[_src] or 0) + 1
        -- if GetEntityPopulationType(model) ~= 0 then return end
        if vehicles[_src] > wx.maxVehicles then
          if not detected[_src] then
            detected[_src] = true
            CancelEvent()
            TriggerClientEvent('wx_anticheat:detectclient',  _src,
              ("Vehicle Spam - [Created %s vehicles in short time]"):format(vehicles[_src]))
          end
        end
      end
      -- if wx.vehicleLimit then
      --   if vehicles[_src] > wx.maxVehicles then
      --     CancelEvent()
      --     TriggerClientEvent('wx_anticheat:detectclient',  _src, Locale.VehSpam:format(vehicles[_src],wx.maxVehicleInterval))
      --   end
      -- end
    end
  end
end)

-- Thanks to KurdY#9244

local SV_VEHICLES = {}
local SV_PEDS = {}
local SV_OBJECT = {}
local SV_Userver = {}
AddEventHandler("entityCreated", function(ENTITY)
    if DoesEntityExist(ENTITY) then
        local TYPE       = GetEntityType(ENTITY)
        local OWNER      = NetworkGetFirstEntityOwner(ENTITY)
        local POPULATION = GetEntityPopulationType(ENTITY)
        local MODEL      = GetEntityModel(ENTITY)
        local HWID       = GetPlayerToken(OWNER, 0)
        if TYPE == 2 and wx.antiSpamVehicle and POPULATION == 7 then
            if SV_VEHICLES[HWID] ~= nil then
                SV_VEHICLES[HWID].COUNT = SV_VEHICLES[HWID].COUNT + 1
                if os.time() - SV_VEHICLES[HWID].TIME >= 10 then
                    SV_VEHICLES[HWID] = nil
                else
                    if SV_VEHICLES[HWID].COUNT >= wx.maxVehicle then
                        for _, vehilce in ipairs(GetAllVehicles()) do
                            local ENO = NetworkGetFirstEntityOwner(vehilce)
                            if ENO == OWNER then
                                if DoesEntityExist(vehilce) then
                                    DeleteEntity(vehilce)
                                end
                            end
                        end
                        if not SV_Userver[HWID] then
                          SV_Userver[HWID] = true
                            TriggerClientEvent('wx_anticheat:detectclient',OWNER,("Vehicle Spamming - [Spawned %s Vehicles]"):format(SV_VEHICLES[HWID].COUNT))
                            CancelEvent()
                        end
                    end
                end
            else
                SV_VEHICLES[HWID] = {
                    COUNT = 1,
                    TIME  = os.time()
                }
            end
        elseif TYPE == 1 and wx.antiSpamPed and POPULATION == 7 then
            if SV_PEDS[HWID] ~= nil then
                SV_PEDS[HWID].COUNT = SV_PEDS[HWID].COUNT + 1
                if os.time() - SV_PEDS[HWID].TIME >= 10 then
                    SV_PEDS[HWID] = nil
                else
                    for _, peds in ipairs(GetAllPeds()) do
                        local ENO = NetworkGetFirstEntityOwner(peds)
                        if ENO == OWNER then
                            if DoesEntityExist(peds) then
                                DeleteEntity(peds)
                            end
                        end
                    end
                    if SV_PEDS[HWID].COUNT >= wx.maxPed then
                          if not SV_Userver[HWID] then
                          SV_Userver[HWID] = true
                          TriggerClientEvent('wx_anticheat:detectclient',  OWNER, "Ped Spamming - [Spawned " .. SV_PEDS[HWID].COUNT .. " peds]")
                          CancelEvent()
                        end
                    end
                end
            else
                SV_PEDS[HWID] = {
                    COUNT = 1,
                    TIME  = os.time()
                }
            end
        elseif TYPE == 3 and wx.antiSpamObject and POPULATION == 7 then
             HandleAntiSpamObjects(HWID, OWNER)
        end
    end
end)

local COOLDOWN_TIME = 10
function HandleAntiSpamObjects(HWID, OWNER)
    if SV_OBJECT[HWID] ~= nil then
        SV_OBJECT[HWID].COUNT = SV_OBJECT[HWID].COUNT + 1
        if os.time() - SV_OBJECT[HWID].TIME >= COOLDOWN_TIME then
            SV_OBJECT[HWID] = nil
        else
            if SV_OBJECT[HWID].COUNT >= wx.maxObject then
                for _, objects in ipairs(GetAllObjects()) do
                    local ENO = NetworkGetFirstEntityOwner(objects)
                    if ENO == OWNER and DoesEntityExist(objects) then
                        DeleteEntity(objects)
                    end
                end
                if not SV_Userver[HWID] then
                  SV_Userver[HWID] = true
                  TriggerClientEvent('wx_anticheat:detectclient',  OWNER, "Try To Spam Objects: " .. SV_OBJECT[HWID].COUNT .. " Objects")
                  CancelEvent()
                end
            end
        end
    else
        SV_OBJECT[HWID] = {
            COUNT = 1,
            TIME = os.time()
        }
    end
end
ECount = {}


AddEventHandler('entityCreating', function(id)
  local model
  local owner
  local eType
  if DoesEntityExist(id) then
    model = GetEntityModel(id)
    eType = GetEntityType(id)
    owner = NetworkGetEntityOwner(id)
  end
  --[[
      3 = Object
      2 = Vehicle
      1 = Ped
      --]]
  if eType == 3 then
    if wx.antiObjects then
      for k, v in pairs(wx.objectBlacklist) do
        if model == GetHashKey(v) and owner ~= 0 then
          CancelEvent()
          TriggerClientEvent('wx_anticheat:detectclient',  owner, Locale.Object:format(v))
        end
      end
      local speed = GetEntityVelocity(id)
      if #(speed - vector3(0, 0, 0)) > 100.0 then
        CancelEvent()
      end
    end
  end
  if wx.antiPeds then
    if eType == 1 then
      for i, v in pairs(wx.pedBlacklist) do
        if model == GetHashKey(v) then
          if not detected[owner] or wx.Debug then
            TriggerClientEvent('wx_anticheat:detectclient',  owner, Locale.Ped:format(v))
          end
          CancelEvent()
        end
        if model == GetHashKey("mp_m_niko_01") then
          TriggerClientEvent('wx_anticheat:detectclient',  owner, Locale.Ped .. " - [mp_m_niko_01]")
          CancelEvent()
        end
      end
      if wx.pedLimit then
        if owner == 0 or owner == nil or model == nil then return end
        peds[owner] = (peds[owner] or 0) + 1

        -- if GetEntityPopulationType(model) ~= 0 then return end
        if peds[owner] > wx.maxPeds then
          CancelEvent()
          if not detected[owner] or wx.Debug then
            TriggerClientEvent('wx_anticheat:detectclient',  owner,
              Locale.PedSpam:format(peds[owner], '10000'))
          end
        end
      end
    end
  end
end)




-- [ Blacklisted messages ]
if wx.messageBlacklist then
  AddEventHandler("chatMessage", function(source, author, message)
    if (IsPlayerAceAllowed(source, "wxAC.bypass")) then
      return
    else -- Don't detect bypassed players
      CancelEvent()
      local finalmessage = message:lower()
      finalmessage = finalmessage:gsub(" ", "")
      finalmessage = finalmessage:gsub("'", "")
      local lastchar = "Not Found"
      local output = "Not Found"
      for char in finalmessage:gmatch(".") do
        if (char ~= lastchar) then
          output = output .. char
        end
        lastchar = char
      end

      for _, v in pairs(wx.blockedWords) do
        if string.find(string.lower(message), v) then
          local steam = "Not Found"
          local license = GetPlayerIdentifiers(source)[1]
          local discord = "Not Found"
          local ip = "Not Found"
          for k, v in pairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
              steam = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
              license = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
              xbl = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
              discord = v
            elseif string.sub(v, 1, string.len("Microsoft:")) == "Microsoft:" then
              xboxlive = v
            elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
              fivem = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
              ip = v
            end
          end
          if not wx.punishType == 'LOG' or not wx.Debug or not isAdmin(source) then
            DropPlayer(source, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BlacklistedWord .. " - [" .. message .. "]")
          end
          local ip = ip:gsub('ip:', '')
          ACLogs("KICKED", author, "Blacklisted Word - [**" .. message .. "**]", steam, license, discord, ip)
        end
      end
    end
  end)
end


RegisterNetEvent('wx_anticheat:server:CY8cV5R1F9hhguzzYbnZRYNRp4Cwn1')
AddEventHandler('wx_anticheat:server:CY8cV5R1F9hhguzzYbnZRYNRp4Cwn1', function(playerID, reason,image)
  if not isAdmin(playerID) or wx.Debug then -- Make sure that the player is not an admin or whitelisted
    image = image or "https://media.discordapp.net/attachments/1134103622423154751/1193265725889065010/failed.png"
    if not isInTable(whitelistedPlayers, playerID) then
      -- if detected[playerID] then return else detected[playerID] = true end

      -- [ Get player's name ]
      local playername = GetPlayerName(playerID)

      -- [ Get the punish method from the config ]
      local punish = wx.punishType

      -- [ Generate the Ban ID ]
      local banID = generateBanID()

      -- [ Get player's HWIDs ]
      local HWID = GetPlayerToken(playerID, 1)
      local HWID2 = GetPlayerToken(playerID, 2)
      local HWID3 = GetPlayerToken(playerID, 3)
      local HWID4 = GetPlayerToken(playerID, 4)
      local HWID5 = GetPlayerToken(playerID, 5)
      if HWID5 == nil then HWID5 = "Not Found" end
      if HWID4 == nil then HWID4 = "Not Found" end
      if HWID3 == nil then HWID3 = "Not Found" end
      if HWID2 == nil then HWID2 = "Not Found" end
      if HWID == nil then HWID = "Not Found" end

      -- [ Get player's identifiers ]
      local steam = "Not Found"
      local ip = "Not Found"
      local discord = "Not Found"
      local license = "Not Found"
      local fivem = "Not Found"

      for k, v in pairs(GetPlayerIdentifiers(playerID)) do
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


      -- [ Strip player identifiers to only the needed ID ]
      steam = steam:gsub('steam:', '')
      discord = discord:gsub('discord:', '')
      if string.find(license, 'license:') then
        license = license:gsub('license:', '')
      elseif string.find(license, 'license2:') then
        license = license:gsub('license2:', '')
      end
      fivem = fivem:gsub('fivem:', '')
      ip = ip:gsub('ip:', '')

      local data = {
        playerId = tostring(playerID),
        playerName = GetPlayerName(playerID),
        reason = reason,
        banID = banID,
        side = 'server'
      }
      TriggerEvent("wx_anticheat:playerBanned", data)
      -- [ Chat Messages ]
      if wx.chatMessages then
        SendChatMessage(GetPlayerName(playerID), reason)
      end

      -- [ Punish the player ]
      if string.lower(punish) == 'log' then
        if wx.screenshots then -- Screenshot method
          ScreenshotLog({license=license,discord=discord,steam=steam,ip=ip,fivem=fivem,hwid=HWID,image=image,playerId=tostring(playerID)},reason)
          if wx.DetectionSharing then
            TriggerEvent('wx_anticheat:share', playerID, banID, playername, reason, license, discord, steam, fivem, ip)
          end
        else -- Text only method
          ACLogs("LOG", playername, reason, steam, license, discord, ip)
        end
      elseif string.lower(punish) == 'kick' then
        if wx.screenshots then
          ScreenshotLog({license=license,discord=discord,steam=steam,ip=ip,fivem=fivem,hwid=HWID,image=image,playerId=tostring(playerID)},reason)
          if wx.DetectionSharing then
            TriggerEvent('wx_anticheat:share', playerID, banID, playername, reason, license, discord, steam, fivem, ip)
          end
          if wx.showReason then
            DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedKick:format(reason, banID))
          else
            DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedNoReason:format(banID))
          end
        else
          ACLogs("KICK", playername, reason, steam, license, discord, ip)
          DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedKick:format(reason, banID))
        end
      elseif string.lower(punish) == 'ban' then
        -- [ Insert him into the banlist (database) ]
        MySQL.Async.execute(
          "INSERT INTO wx_anticheat (reason, banID, playerName, discordid, steamid, ip, license, HWID, HWID2, HWID3, HWID4, HWID5) VALUES (@reason, @banID, @name, @discord, @steam, @ip, @license, @HWID,@HWID2,@HWID3,@HWID4,@HWID5)",
          {
            ['@reason'] = reason,
            ['@banID'] = banID,
            ['@HWID'] = HWID,
            ['@HWID2'] = HWID2,
            ['@HWID3'] = HWID3,
            ['@HWID4'] = HWID4,
            ['@HWID5'] = HWID5,
            ['@name'] = playername,
            ['@ip'] = ip,
            ['@steam'] = steam,
            ['@license'] = license,
            ['@discord'] = discord
          })

        if wx.screenshots then
          ScreenshotLog({license=license,discord=discord,steam=steam,ip=ip,fivem=fivem,hwid=HWID,image=image,banID=banID,playerId=tostring(playerID)},reason)

          Citizen.SetTimeout(5000, function()
            if wx.showReason then
              DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedKick:format(reason, banID))
            else
              DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedNoReason:format(banID))
            end
          end)
        else
          ACLogs("BAN", playername, reason, steam, license, discord, ip)
          if wx.showReason then
            DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedKick:format(reason, banID))
          else
            DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedNoReason:format(banID))
          end
        end
      end
    end
  else
    if wx.adminDetections then
      OtherLogs(GetPlayerName(playerID), reason)
    end
  end
end)

RegisterNetEvent('wx_anticheat:server:clientXkzuqBwmTjN7Gab4QzuN9QYZJ1WxxU')
AddEventHandler('wx_anticheat:server:clientXkzuqBwmTjN7Gab4QzuN9QYZJ1WxxU', function(reason, image,punish)
  local playerID = source
  image = image or "https://media.discordapp.net/attachments/1134103622423154751/1193265725889065010/failed.png"
  if not isAdmin(source) or wx.Debug then -- Make sure that the player is not an admin or whitelisted
    if not isInTable(whitelistedPlayers, source) then
      -- if detected[playerID] then return else detected[playerID] = true end

      punish = punish or wx.punishType
      -- [ Get player's name ]
      local playername = GetPlayerName(playerID)

      -- [ Generate the Ban ID ]
      local banID = generateBanID()


      -- [ Get player's HWIDs ]
      local HWID = GetPlayerToken(playerID, 1)
      local HWID2 = GetPlayerToken(playerID, 2)
      local HWID3 = GetPlayerToken(playerID, 3)
      local HWID4 = GetPlayerToken(playerID, 4)
      local HWID5 = GetPlayerToken(playerID, 5)
      if HWID5 == nil then HWID5 = "Not Found" end
      if HWID4 == nil then HWID4 = "Not Found" end
      if HWID3 == nil then HWID3 = "Not Found" end
      if HWID2 == nil then HWID2 = "Not Found" end
      if HWID == nil then HWID = "Not Found" end

      -- [ Get player's identifiers ]
      local steam = "Not Found"
      local ip = "Not Found"
      local discord = "Not Found"
      local license = "Not Found"
      local fivem = "Not Found"

      for k, v in pairs(GetPlayerIdentifiers(playerID)) do
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

      -- [ Strip player identifiers to only the needed ID ]
      steam = steam:gsub('steam:', '')
      discord = discord:gsub('discord:', '')
      license = license:gsub('license:', '')
      fivem = fivem:gsub('fivem:', '')
      ip = ip:gsub('ip:', '')

      -- [ Chat Messages ]
      local data = {
        playerId = playerID,
        playerName = GetPlayerName(playerID),
        reason = reason,
        banID = banID,
        side = 'client'
      }
      TriggerEvent("wx_anticheat:playerBanned", data)
      if wx.chatMessages then
        SendChatMessage(GetPlayerName(playerID), reason)
      end
      BetterPrint(("Player ^3%s^7 has been detected for ^3%s^7"):format(data.playerName,reason),"info")

      -- [ Punish the player ]
      if string.lower(punish) == 'log' then
        if wx.screenshots then -- Screenshot method
          ScreenshotLog({license=license,discord=discord,steam=steam,ip=ip,fivem=fivem,hwid=HWID,image=image,playerId=tostring(playerID)},reason)
          if wx.DetectionSharing then
            TriggerEvent('wx_anticheat:share', playerID, banID, playername, reason, license, discord, steam, fivem, ip)
          end
        else -- Text only method
          ACLogs("LOG", playername, reason, steam, license, discord, ip)
        end
      elseif string.lower(punish) == 'kick' then
        if wx.screenshots then
          ScreenshotLog({license=license,discord=discord,steam=steam,ip=ip,fivem=fivem,hwid=HWID,image=image,playerId=tostring(playerID)},reason)

          if wx.DetectionSharing then
            TriggerEvent('wx_anticheat:share', playerID, banID, playername, reason, license, discord, steam, fivem, ip)
          end
          if wx.showReason then
            DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedKick:format(reason, banID))
          else
            DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedNoReason:format(banID))
          end
        else
          ACLogs("KICK", playername, reason, steam, license, discord, ip)
          DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedKick:format(reason, banID))
        end
      elseif string.lower(punish) == 'ban' then
        -- [ Insert him into the banlist (database) ]
        MySQL.Async.execute(
          "INSERT INTO wx_anticheat (reason, banID, playerName, discordid, steamid, ip, license, HWID, HWID2, HWID3, HWID4, HWID5) VALUES (@reason, @banID, @name, @discord, @steam, @ip, @license, @HWID,@HWID2,@HWID3,@HWID4,@HWID5)",
          {
            ['@reason'] = reason,
            ['@banID'] = banID,
            ['@HWID'] = HWID,
            ['@HWID2'] = HWID2,
            ['@HWID3'] = HWID3,
            ['@HWID4'] = HWID4,
            ['@HWID5'] = HWID5,
            ['@name'] = playername,
            ['@ip'] = ip,
            ['@steam'] = steam,
            ['@license'] = license,
            ['@discord'] = discord
          })
        if wx.screenshots then
          ScreenshotLog({license=license,discord=discord,steam=steam,ip=ip,fivem=fivem,hwid=HWID,image=image,banID=banID,playerId=tostring(playerID)},reason)
          if wx.DetectionSharing then
            TriggerEvent('wx_anticheat:share', playerID, banID, playername, reason, license, discord, steam, fivem, ip)
          end
          Citizen.SetTimeout(5000, function()
            if wx.showReason then
              DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedKick:format(reason, banID))
            else
              DropPlayer(playerID, "\n🛡️ [" .. wx.Prefix .. "] 🛡️\n\n" .. Locale.BannedNoReason:format(banID))
            end
          end)
        else
          ACLogs("BAN", playername, reason, steam, license, discord, ip)
        end
      end
    else
      if wx.adminDetections then
        OtherLogs(GetPlayerName(playerID), reason)
      end
    end
  end
end)

-- [ Ban/kick/log handling ]


TriggerEvent('wx_anticheat:checkUpdates', 2500)

if wx.antiTaze then
  AddEventHandler('weaponDamageEvent', function(sender, data)
    local getWeapon = data.weaponType
    if getWeapon == `WEAPON_STUNGUN` then
      TriggerClientEvent('wx_anticheat:checkTaze', sender)
    end
  end)
end

-- [ Connection logs and ban checking]


function ScreenshotLog(data,reason)
    local steam = data.steam
    local discord = data.discord
    local license = data.license
    local fivem = data.fivem
    local ip = data.ip
    local HWID = data.hwid
    local playerId = data.playerId
    local banId = data.banID
    if string.lower(wx.punishType) == "log" then banId = "None" end
    local steamm
    local steam1 = steam:gsub("steam:", "")
    local steamDec = tostring(tonumber(steam1, 16))
    local spoiler = ""
    if wx.spoilerIP then spoiler = "||" end
    local discordping = discord:gsub('discord:', '')
    local steamprofile = "https://steamcommunity.com/profiles/" .. steamDec;
    local ping = ""
    if wx.pingOnDetect then
      ping = "@everyone"
    else
      ping = ""
    end
    if steam == "Not Found" then
      steamm = steam
      steamprofile = "Steam was not Found"
    else
      steamm = "[" .. steam .. "](" .. steamprofile .. ")"
    end
    local punish = 'Unknown'
    if string.upper(wx.punishType) == 'BAN' then
      punish = 'Banned'
    elseif string.upper(wx.punishType) == 'KICK' then
      punish = 'Kicked'
    elseif string.upper(wx.punishType) == 'LOG' then
      punish = 'Log'
    end
    
    local embed = {
      {
        ["color"] = Webhooks.WebhookColor,
        ["username"] = Webhooks.WebhookUsername,
        ["avatar_url"] = Webhooks.WebhookAvatar,
        ["content"] = ping,
        ["title"] = '`🔴` Player has been detected!',
        ["description"] = "`❗` Punish Method: **" ..punish .. "**\n`📝` Reason: **" .. reason .. "**\n`🔢` Ban ID: **" .. banId .. "**\n" .. "",
        ["fields"] = {
          {
            ["name"] = "`🎮` **Player**",
            ["value"] = "[**" .. tonumber(playerId) .. "**] " .. GetPlayerName(playerId),
            ["inline"] = Webhooks.WebhookInlines
          },
          {
            ["name"] = "`🔵` **Discord**",
            ["value"] = "<@" .. discordping .. ">",
            ["inline"] = Webhooks.WebhookInlines
          },
          {
            ["name"] = "`⚙️` **Steam**",
            ["value"] = steamm or "N/A",
            ["inline"] = Webhooks.WebhookInlines
          },
          {
            ["name"] = "`🐌` **FiveM ID**",
            ["value"] = fivem or "N/A",
            ["inline"] = Webhooks.WebhookInlines
          },
          {
            ["name"] = "`✨` **Rockstar License**",
            ["value"] = license or "N/A",
            ["inline"] = Webhooks.WebhookInlines
          },
          -- {
          --   ["name"] = "`💻` **HWID**",
          --   ["value"] = HWID or "N/A",
          --   ["inline"] = Webhooks.WebhookInlines
          -- },
          {
            ["name"] = "`🌍` **IP Address**",
            ["value"] = spoiler .. ("[%s](https://ipinfo.io/%s)"):format(ip:gsub('ip:', ''), ip:gsub('ip:', '')) ..spoiler,
            ["inline"] = Webhooks.WebhookInlines
          },
          {
            ["name"] = "`💻` **HWID**",
            ["value"] = HWID or "N/A",
            ["inline"] = Webhooks.WebhookInlines
          },
          {
            ["name"] = "`📶` **Ping**",
            ["value"] = GetPlayerPing(source) .. " ms",
            ["inline"] = false
          },
        },
        ["image"] = {
          ["url"] = data.image,
        },
        ["footer"] = {
          ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
          ["icon_url"] = Webhooks.WebhookAvatar
        }
      }
    }
  
    PerformHttpRequest(Webhooks.WebHook, function(err, text, headers) end, 'POST',
    json.encode({ username = Webhooks.WebhookUsername, avatar_url=Webhooks.WebhookAvatar, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('scr',function (image)
  local steam,license,discord,fivem,ip
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
  ScreenshotLog({
    steam = steam,
    license = license,
    discord = discord,
    fivem = fivem,
    ip = ip,
    banID=generateBanID(),
    reason = "Test",
    image = image
  })
end)



RegisterServerEvent('wx_anticheat:share')
AddEventHandler('wx_anticheat:share', function(playerId, banId, player, reason, license, discord, steam, fivem, ip)
  local steam1 = steam:gsub("steam:", "")
  local steamDec = tostring(tonumber(steam1, 16))
  local spoiler = ""
  if wx.spoilerIP then spoiler = "||" end
  local discordping = discord:gsub('discord:', '')
  local steamprofile = "https://steamcommunity.com/profiles/" .. steamDec;
  if steam == "Not Found" then
    steamprofile = "Steam was not Found"
  end
  local punish = 'Unknown'
  if string.upper(wx.punishType) == 'BAN' then
    punish = 'Banned'
  elseif string.upper(wx.punishType) == 'KICK' then
    punish = 'Kicked'
  elseif string.upper(wx.punishType) == 'LOG' then
    punish = 'Log'
  end

  exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
    playerId,
    'https://discord.com/api/webhooks/1150063426186518578/lUl3Xb7ojW0jYSjv60xlUBMUkdU_QU12VhNF7BeHx5nGxBY-MacyCSUbMCPPwNvi-8ux',
    {
      encoding = "png",
      quality = 1
    },
    {
      username = Webhooks.WebhookUsername,
      avatar_url = Webhooks.WebhookAvatar,
      embeds = {
        {
          title = '[' .. punish .. '] Player has been detected!',
          description = "Reason: **" ..
              reason ..
              "**\nBan ID: **" ..
              banId ..
              "**\n" ..
              "\n**Server Name**: " ..
              GetConvar('sv_hostname', 'false') ..
              "\n**Project Name**: " ..
              GetConvar('sv_projectName', 'false') .. "\n**Tags**: " .. GetConvar('tags', 'false'),
          footer = {
            text = "🌠 [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
            icon_url = Webhooks.WebhookAvatar
          },
          author = {
            name = "WX AntiCheat",
            url = "https://0wx.tebex.io/",
            icon_url = 'https://0wx.space/img/aclogo.png'
          },

          color = Webhooks.WebhookColor,

          fields = {
            {
              name = "**Player**",
              value = "[**" .. playerId .. "**] " .. player,
              inline = Webhooks.WebhookInlines
            },
            -- {
            --   name = "**Player ID**",
            --   value = playerId,
            --   inline = Webhooks.WebhookInlines
            -- },
            -- {
            --   name = "Reason",
            --   value = reason,
            --   inline = Webhooks.WebhookInlines
            -- },
            {
              name = "**Discord**",
              value = "<@" .. discordping .. ">",
              inline = Webhooks.WebhookInlines
            },
            {
              name = "**Steam**",
              value = "[" .. steam .. "](" .. steamprofile .. ")",
              inline = Webhooks.WebhookInlines
            },
            {
              name = "**FiveM ID**",
              value = fivem,
              inline = Webhooks.WebhookInlines
            },
            {
              name = "**License**",
              value = license,
              inline = Webhooks.WebhookInlines
            },
            {
              name = "**IP Address**",
              value = spoiler .. ("[%s](https://ipinfo.io/%s)"):format(ip:gsub('ip:', ''), ip:gsub('ip:', '')) .. spoiler,
              inline = Webhooks.WebhookInlines
            }
          }
        }

      }
    },
    wx.screenshotTimeout,
    function(error)
    end)
end)

local hasDiscord = true
local allowedName = true
function CheckDiscord(name, setKickReason, deferrals)
  local discord = "Not Found"
  for k, v in pairs(GetPlayerIdentifiers(source)) do
    if string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = v
    end
  end
  if wx.needDiscord then
    if discord == "Not Found" and allowedName then
      hasDiscord = false
      -- Citizen.CreateThread(function()
      --  while true do
      Wait(100)
      local card = [[
              {
                "type": "AdaptiveCard",
                "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                "version": "1.3",
                "body": [

                    {
                        "type": "TextBlock",
                        "text": "%s",
                        "wrap": true,
                        "horizontalAlignment": "Center",
                        "separator": false,
                        "size": "ExtraLarge",
                        "weight": "Bolder"
                    },
                    {
                        "type": "TextBlock",
                        "text": "%s",
                        "wrap": false,
                        "horizontalAlignment": "Center",
                        "weight": "Medium"
                    },
                    {
                        "type": "TextBlock",
                        "text": "%s",
                        "wrap": false,
                        "horizontalAlignment": "Center",
                        "weight": "Medium"
                    },
                    {
                      "type": "Image",
                      "url": "https://media.discordapp.net/attachments/1132686300026241106/1142819425423208478/cK9EEpoQptKJ.gif?width=230&height=230",
                      "size": "small",
                      "style": "person",
                      "altText": "ONTOP"
                    }
                ]
            }
            ]]
      Citizen.CreateThread(function()
        Wait(100)
        deferrals.presentCard(card:format(Locale.DiscordNotFound, Locale.DiscordReq, Locale.DiscordGoTo),
          function(data, rawData) end)
      end)
      -- end
      -- end)
    end
  end
end

function CheckName(name, setKickReason, deferrals)
  local contains = nil
  for k, v in pairs(wx.badNames) do
    if string.find(name, v) then
      allowedName = false
      contains = v
    end
  end
  if wx.nameBlacklist then
    if not allowedName and hasDiscord then
      Citizen.CreateThread(function()
        while true do
          Wait(0)
          local card = [[
              {
                "type": "AdaptiveCard",
                "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                "version": "1.3",
                "body": [

                    {
                        "type": "Container",
                        "style": "emphasis",
                        "items": [
                            {
                                "type": "TextBlock",
                                "text": "Your name is not allowed",
                                "wrap": true,
                                "horizontalAlignment": "Center",
                                "size": "Large",
                                "weight": "Bold",
                                "separator": true
                            }
                        ]
                    },
                    {
                        "type": "TextBlock",
                        "text": "Your name contains **%s**, which is not allowed!",
                        "wrap": true,
                        "horizontalAlignment": "Center",
                        "size": "Large"
                    },
                    {
                        "type": "TextBlock",
                        "text": "Go to FiveM settings, change your name and try to connect again",
                        "wrap": false,
                        "horizontalAlignment": "Center",
                        "weight": "Medium",
                        "color": "warning"
                    }
                ]
            }
            ]]
          deferrals.presentCard(card:format(contains),
            function(data, rawData) end)
          CancelEvent()
        end
      end)
    end
  end
end

function CheckName(name, setKickReason, deferrals)
  local contains = nil
  for k, v in pairs(wx.badNames) do
    if string.find(name, v) then
      allowedName = false
      contains = v
    end
  end
  if wx.nameBlacklist then
    if not allowedName and hasDiscord then
      Citizen.CreateThread(function()
        while true do
          Wait(0)
          local card = [[
              {
                "type": "AdaptiveCard",
                "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                "version": "1.3",
                "body": [

                    {
                        "type": "Container",
                        "style": "emphasis",
                        "items": [
                            {
                                "type": "TextBlock",
                                "text": "Your name is not allowed",
                                "wrap": true,
                                "horizontalAlignment": "Center",
                                "size": "Large",
                                "weight": "Bold",
                                "separator": true
                            }
                        ]
                    },
                    {
                        "type": "TextBlock",
                        "text": "Your name contains **%s**, which is not allowed!",
                        "wrap": true,
                        "horizontalAlignment": "Center",
                        "size": "Large"
                    },
                    {
                        "type": "TextBlock",
                        "text": "Go to FiveM settings, change your name and try to connect again",
                        "wrap": false,
                        "horizontalAlignment": "Center",
                        "weight": "Medium",
                        "color": "warning"
                    }
                ]
            }
            ]]
          deferrals.presentCard(card:format(contains),
            function(data, rawData) end)
          CancelEvent()
        end
      end)
    end
  end
end

function OnPlayerConnecting(name, setKickReason, deferrals)
  deferrals.defer()
  if wx.maxUsernameLength ~= -1 then
    if string.len(name) > wx.maxUsernameLength then
      deferrals.done("\n\n🛡️ [" ..
        wx.Prefix ..
        "] Your name is too long, maximum length is " ..
        wx.maxUsernameLength .. " chars.\n🛡️ Your length: " .. string.len(name))
      return
    end
  end
  -- [ Get player's HWIDs ]
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

  -- [ Strip player identifiers to only the needed ID ]
  steam = steam:gsub('steam:', '')
  discord = discord:gsub('discord:', '')
  license = license:gsub('license:', '')
  fivem = fivem:gsub('fivem:', '')
  ip = ip:gsub('ip:', '')

  if wx.connectPrints then
    BetterPrint(("Player ^3%s^7 [^3%s^7] is connecting"):format(GetPlayerName(source),license),"info")
  end
  if wx.connectLogs then
    ConnectLogs(name, steam, license, discord, ip)
  end

  MySQL.Async.fetchAll(
    "SELECT * FROM `wx_anticheat` WHERE `HWID` = @HWID",
    {
      ["@HWID"] = HWID,
    },
    function(data)
      local banned = false
      for i = 1, #data, 1 do
        if data[i].HWID == HWID or data[i].HWID2 == HWID2 or data[i].HWID3 == HWID3 or data[i].HWID4 == HWID4 or data[i].HWID5 == HWID5 or data[i].license == license or data[i].steamid == steam or data[i].discordid == discord or data[i].ip == ip or data[i].fivem == fivem then
          banned = true
          break
        end
      end

      if banned then
        local banReason = nil
        local banID = nil
        MySQL.Async.fetchAll(
          'SELECT reason, banID FROM wx_anticheat WHERE `HWID` = @HWID OR `HWID2` = @HWID2 OR `HWID3` = @HWID3 OR `HWID4` = @HWID4 OR `HWID5` = @HWID5 OR `license` = @license',
          {
            ["@HWID"] = HWID,
            ["@HWID2"] = HWID2,
            ["@HWID3"] = HWID3,
            ["@HWID4"] = HWID4,
            ["@HWID5"] = HWID5,
            ["@license"] = license,
          }, function(result)
            banReason = result[1].reason
            banID = result[1].banID
            BetterPrint(("Player ^3%s^7 was trying to connect but has an active ban for ^3%s^7 (^3%s^7)"):format(name,banReason,banID),"info")
            local card = {
              type = "AdaptiveCard",
              ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
              version = "1.3",
              body = {
                  {
                      type = "TextBlock",
                      text = "WX AntiCheat",
                      wrap = true,
                      horizontalAlignment = "Center",
                      separator = false,
                      size = "ExtraLarge",
                      weight = "Bolder"
                  },
                  {
                      type = "TextBlock",
                      text = Locale.Banned,
                      wrap = true,
                      horizontalAlignment = "Center",
                      separator = false,
                      size = "Medium",
                      weight = "Bolder"
                  },
                  {
                      type = "ActionSet",
                      actions = {
                          {
                              type = "Action.OpenUrl",
                              title = ("%s: %s"):format(Locale.Reason, banReason)
                          },
                          {
                              type = "Action.OpenUrl",
                              title = ("%s: %s"):format(Locale.BanID, banID),
                          }
                      },
                      horizontalAlignment = "Center"
                  },
                  {
                      type = "TextBlock",
                      text = Locale.BannedInfo,
                      wrap = false,
                      horizontalAlignment = "Center",
                      weight = "Medium",
                      color = "warning"
                  },
                  {
                      type = "ActionSet",
                      actions = {
                          {
                              type = "Action.OpenUrl",
                              title = Locale.SupportDiscord,
                              iconUrl = "https://media.discordapp.net/attachments/1134103622423154751/1193272896471187575/discord_1.png",
                              url = wx.appealDiscord
                          },
                          {
                              type = "Action.OpenUrl",
                              title = "anticheat.0wx.space",
                              iconUrl = "https://media.discordapp.net/attachments/1134103622423154751/1193272727071641681/shield-solid_1.png",
                              url = "https://anticheat.0wx.space"
                          }
                      },
                      horizontalAlignment = "Center"
                  }
              }
          }
          
            Citizen.CreateThread(function()
              while true do
                Wait(0)
                deferrals.presentCard(
                  card,
                  function(data, rawData) end)
                CancelEvent()
              end
            end)
          end)
      else
        if wx.connectingCard.enabled then
          local card = [[
              {
                "type": "AdaptiveCard",
                "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                "version": "1.3",
                "body": [

                    {
                        "type": "TextBlock",
                        "text": "%s",
                        "wrap": true,
                        "horizontalAlignment": "Center",
                        "separator": false,
                        "size": "ExtraLarge",
                        "weight": "Bolder"
                    },
                    {
                        "type": "TextBlock",
                        "text": "%s",
                        "wrap": false,
                        "horizontalAlignment": "Center",
                        "weight": "Medium"
                    },
                    {
                      "type": "Image",
                      "url": "https://cdn.discordapp.com/attachments/1132686300026241106/1178366229757558834/a.gif",
                      "size": "small",
                      "style": "person",
                      "altText": "ONTOP"
                    }
                ]
            }
            ]]
          local connecting = true
          Citizen.CreateThread(function()
            Wait(wx.connectingCard.length)
            connecting = false
          end)
          if hasDiscord and allowedName and not hasVPN then
            Citizen.CreateThread(function()
              while connecting do
                Wait(0)
                deferrals.presentCard((card):format(Locale.Title, Locale.SubTitle),
                  function(data, rawData) end)
                while not connecting do
                  Wait(0)
                  deferrals.done()
                  break
                end
              end
            end)
          end
        else
          deferrals.done()
        end
      end
    end
  )
end

AddEventHandler("playerConnecting", OnPlayerConnecting)
-- AddEventHandler("playerConnecting", CheckDiscord)
AddEventHandler("playerConnecting", CheckName)

-- [ Tasks and Weapons detetions ]
AddEventHandler("clearPedTasksEvent", function(sender, data)
  if wx.antiClearTasks then
    CancelEvent()
    TriggerEvent('wx_anticheat:server:CY8cV5R1F9hhguzzYbnZRYNRp4Cwn1', sender, Locale.ClearPedTasks)
  end
end)
AddEventHandler('removeWeaponEvent', function(sender, data)
  if wx.antiRemoveWeapons then
    CancelEvent()
    TriggerEvent('wx_anticheat:server:CY8cV5R1F9hhguzzYbnZRYNRp4Cwn1', sender, Locale.RemoveWeapons)
  end
end)
if wx.antiGiveWeapons then
  AddEventHandler('giveWeaponEvent', function(sender, data)
    CancelEvent()
    TriggerEvent('wx_anticheat:server:CY8cV5R1F9hhguzzYbnZRYNRp4Cwn1', sender, Locale.GiveWeapons)
  end)
end

-- [ Player disconnect logs ]
if wx.disconnectLogs then
  AddEventHandler('playerDropped', function(reason)
    local steam = "Not Found"
    local license = "Not Found"
    local discord = "Not Found"
    local xbl = "Not Found"
    local xboxlive = "Not Found"
    local fivem = "Not Found"
    for k, v in pairs(GetPlayerIdentifiers(source)) do
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steam = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        license = v
      elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
        xbl = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
      elseif string.sub(v, 1, string.len("Microsoft:")) == "Microsoft:" then
        xboxlive = v
      elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
        fivem = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        ip = v
      end
    end
    if wx.connectPrints then
      if string.find(reason, wx.Prefix) or string.find(reason, "WX ANTICHEAT") then reason = "Banned by AntiCheat" end
      BetterPrint(("Player ^3%s^7 has disconnected - [^3%s]^7"):format(GetPlayerName(source),reason),"info")
    end
    DisconnectLogs(GetPlayerName(source), reason, steam, license, discord:gsub('discord:', ''), ip)
  end)
end

-- [ Disable hardcap because I implemented my own join prints ]
if wx.connectPrints then
  AddEventHandler("onResourceStarting", function(resource)
    if resource == "hardcap" then
      BetterPrint("wx.connectPrints is enabled, disabling hardcap resource...","info")
      CancelEvent()
      return
    end
  end)
  StopResource("hardcap")
  BetterPrint("hardcap has been disabled!","info")
end

AddEventHandler('explosionEvent', function(sender, ev)
  local steam = "Not Found"
  local license = "Not Found"
  local discord = "Not Found"
  local xbl = "Not Found"
  local xboxlive = "Not Found"
  local fivem = "Not Found"
  local ip = "Not Found"
  for k, v in pairs(GetPlayerIdentifiers(sender)) do
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      steam = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      license = v
    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
      xbl = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = v
    elseif string.sub(v, 1, string.len("Microsoft:")) == "Microsoft:" then
      xboxlive = v
    elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
      fivem = v
    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
      ip = v
    end
  end
  local explosion = "UNKNOWN"
  if ev.explosionType == 0 then
    explosion = 'Grenade'
  elseif ev.explosionType == 1 then
    explosion = 'Grenade Launcher'
  elseif ev.explosionType == 2 then
    explosion = 'Sticky Bomb'
  elseif ev.explosionType == 3 then
    explosion = 'Molotov'
  elseif ev.explosionType == 4 then
    explosion = 'Rocket'
  elseif ev.explosionType == 5 then
    explosion = 'Tank Shell'
  else
    explosion = ev.explosionType
  end
  ExplosionLogs(GetPlayerName(sender), explosion, ev.isAudible, ev.isInvisible, ev.damageScale,
    "X: " .. ev.posX .. " Y: " .. ev.posY .. " Z: " .. ev.posZ, json.encode(ev),
    "SteamID: " ..
    steam ..
    "\nLicense: " ..
    license ..
    "\nDiscord: " ..
    discord ..
    "\nFiveM: " .. fivem ..
    "\nIP Address: " .. ("[%s](https://ipinfo.io/%s)"):format(ip:gsub('ip:', ''), ip:gsub('ip:', '')))
end)

if wx.ObjectLogs then
  AddEventHandler('entityCreating', function(id)
    local steam = "Not Found"
    local license = "Not Found"
    local discord = "Not Found"
    local xbl = "Not Found"
    local xboxlive = "Not Found"
    local fivem = "Not Found"
    local ip = "Not Found"

    local model
    local owner
    local eType
    if DoesEntityExist(id) then
      model = GetEntityModel(id)
      eType = GetEntityType(id)
      owner = NetworkGetEntityOwner(id)
    end
    for k, v in pairs(GetPlayerIdentifiers(owner)) do
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steam = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        license = v
      elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
        xbl = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
      elseif string.sub(v, 1, string.len("Microsoft:")) == "Microsoft:" then
        xboxlive = v
      elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
        fivem = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        ip = v
      end
    end
    --[[
        3 = Object
        2 = Vehicle
        1 = Ped
        --]]

    if eType == 3 then
      local ip = ip:gsub('ip:', '')
      ObjectLogs(GetPlayerName(owner), model, steam, license, discord, ip)
      -- ObjectLogs('Object Created', 'Player **'..GetPlayerName(owner)..'** created an object. Entity: **'..model..'**\n\nSteamID: '..steam..'\nLicense: '..license..'\nDiscord: '..discord..'\nXBL: '..xbl..'\nFiveM: '..fivem..'\nIP Address: '..("[%s](https://ipinfo.io/%s)"):format(ip:gsub('ip:', ''),ip:gsub('ip:', '')))
    end
  end)
end

if wx.ChatLogs then
  AddEventHandler('chatMessage', function(source, name, msg)
    local steam = "Not Found"
    local license = "Not Found"
    local discord = "Not Found"
    local xbl = "Not Found"
    local xboxlive = "Not Found"
    local fivem = "Not Found"
    local ip = "Not Found"
    for k, v in pairs(GetPlayerIdentifiers(source)) do
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steam = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        license = v
      elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
        xbl = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
      elseif string.sub(v, 1, string.len("Microsoft:")) == "Microsoft:" then
        xboxlive = v
      elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
        fivem = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        ip = v
      end
    end
    local ip = ip:gsub('ip:', '')

    ChatLogs(name, msg, steam, license, discord, ip)
  end)
end

if wx.ResourceStopLogs then
  AddEventHandler('onResourceStop', function(resourceName)
    ResourceLog("stopped", resourceName)
  end)
end

if wx.ResourceStartLogs then
  AddEventHandler('onResourceStart', function(resourceName)
    ResourceLog("started", resourceName)
  end)
end

-- OCR


RegisterServerEvent(GetCurrentResourceName() .. ":ocrDetection")
AddEventHandler(GetCurrentResourceName() .. ":ocrDetection", function(details)
  if details and details.image and details.word then
    TriggerEvent('wx_anticheat:server:CY8cV5R1F9hhguzzYbnZRYNRp4Cwn1', source, Locale.OCR:format(details.word),details.image)
  end
end)

RegisterServerEvent("Q8zdjIrnFnsIXaWhONbOETdf2n0BNwzF:5ZIOoON9x8hYfbXqalkk8rmKXheizy7A")
AddEventHandler("Q8zdjIrnFnsIXaWhONbOETdf2n0BNwzF:5ZIOoON9x8hYfbXqalkk8rmKXheizy7A", function()
  TriggerEvent('wx_anticheat:server:CY8cV5R1F9hhguzzYbnZRYNRp4Cwn1', source, Locale.AnticheatStopped)
end)


RegisterServerEvent('wx_anticheat:afk')
AddEventHandler('wx_anticheat:afk', function()
  DropPlayer(source, Locale.AntiAFK)
end)

-- EXPORTS

exports("whitelistPlayer", function(source, time)
  if isInTable(whitelistedPlayers, source) then return "Player is whitelisted" end
  if time == -1 then
    table.insert(whitelistedPlayers, source)
  else
    Citizen.CreateThread(function()
      table.insert(whitelistedPlayers, source)
      Citizen.SetTimeout(time, function()
        removeFromTable(whitelistedPlayers, source)
      end)
    end)
  end
end)

exports("addAdmin", function(id)
  if isInTable(admins, source) then return "Player is already an admin" end
  table.insert(admins, id)
end)

exports("removeAdmin", function(id)
  removeFromTable(admins, id)
end)

exports("removeWhitelist", function(source)
  removeFromTable(whitelistedPlayers, source)
end)