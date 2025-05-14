
exports('ban',function (playerId,reason)
    TriggerEvent('wx_anticheat:server:CY8cV5R1F9hhguzzYbnZRYNRp4Cwn1', playerId, reason)
end)

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
exports('offlineban',function (data,reason)
    local banID = generateBanID()
    local HWID = data.HWID or "Not Found"
    local HWID2 = data.HWID2 or "Not Found"
    local HWID3 = data.HWID3 or "Not Found"
    local HWID4 = data.HWID4 or "Not Found"
    local HWID5 = data.HWID5 or "Not Found"
    local playername = data.playername
    local steam = data.steam or "Not Found"
    local license = data.license or "Not Found"
    local discord = data.discord or "Not Found"
    local ip = data.ip or "Not Found"
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
      BetterPrint(("Player ^3%s^7 has been offline banned for ^3%s^7"):format(playername,reason),"info")
end)