function ACLogs(log, playerName, reason, steam, license, discord, ip)
  local embed = {
    {
      ["color"] = Webhooks.WebhookColor,
      ["title"] = "[" .. log .. "] Player has been detected!",
      ["fields"] = {
        {
          ["name"] = "Player Name",
          ["value"] = playerName,
          ["inline"] = true
        },
        {
          ["name"] = "Reason",
          ["value"] = reason,
          ["inline"] = true
        },
        {
          ["name"] = "Steam ID",
          ["value"] = steam,
          ["inline"] = true
        },
        {
          ["name"] = "License",
          ["value"] = license,
          ["inline"] = true
        },
        {
          ["name"] = "Discord ID",
          ["value"] = discord,
          ["inline"] = true
        },
        {
          ["name"] = "IP Address",
          ["value"] = ("[%s](https://ipinfo.io/%s)"):format(ip:gsub('ip:', ''), ip:gsub('ip:', '')),
          ["inline"] = true
        },
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }
  PerformHttpRequest(Webhooks.Webhook, function(err, text, headers) end, "POST",
    json.encode({
      username = "🛡️ WX ANTICHEAT 🛡️",
      embeds = embed,
      avatar_url =
      Webhooks.WebhookAvatar
    }),
    { ["Content-Type"] = "application/json" })
end

function ChatLogs(playerName, message, steam, license, discord, ip)
  local embed = {
    {
      ["color"] = Webhooks.WebhookColor,
      ["title"] = "**Chat Message**",
      ["fields"] = {
        {
          ["name"] = "Player Name",
          ["value"] = playerName,
          ["inline"] = true
        },
        {
          ["name"] = "Message",
          ["value"] = message,
          ["inline"] = true
        },
        {
          ["name"] = "Steam ID",
          ["value"] = steam,
          ["inline"] = true
        },
        {
          ["name"] = "License",
          ["value"] = license,
          ["inline"] = true
        },
        {
          ["name"] = "Discord ID",
          ["value"] = discord,
          ["inline"] = true
        },
        {
          ["name"] = "IP Address",
          ["value"] = ("[%s](https://ipinfo.io/%s)"):format(ip:gsub('ip:', ''), ip:gsub('ip:', '')),
          ["inline"] = true
        },
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }

  PerformHttpRequest(Webhooks.ChatWebhook, function(err, text, headers) end, 'POST',
    json.encode({ username = wx.WebHookName, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

function ObjectLogs(playerName, object, steam, license, discord, ip)
  local embed = {
    {
      ["color"] = Webhooks.WebhookColor,
      ["title"] = "**Object Created**",
      ["fields"] = {
        {
          ["name"] = "Player Name",
          ["value"] = playerName,
          ["inline"] = true
        },
        {
          ["name"] = "Object",
          ["value"] = message,
          ["inline"] = true
        },
        {
          ["name"] = "Steam ID",
          ["value"] = steam,
          ["inline"] = true
        },
        {
          ["name"] = "License",
          ["value"] = license,
          ["inline"] = true
        },
        {
          ["name"] = "Discord ID",
          ["value"] = discord,
          ["inline"] = true
        },
        {
          ["name"] = "IP Address",
          ["value"] = ("[%s](https://ipinfo.io/%s)"):format(ip:gsub('ip:', ''), ip:gsub('ip:', '')),
          ["inline"] = true
        },
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }

  PerformHttpRequest(Webhooks.ObjectWebhook, function(err, text, headers) end, 'POST',
    json.encode({ username = wx.WebHookName, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

function ExplosionLogs(playerName, explosionType, audible, visible, damagescale, position, info, ids)
  local embed = {
    {
      ["color"] = Webhooks.WebhookColor,
      ["title"] = "**Explosion Created**",
      ["fields"] = {
        {
          ["name"] = "Player Name",
          ["value"] = playerName,
          ["inline"] = true
        },
        {
          ["name"] = "Explosion Type",
          ["value"] = explosionType,
          ["inline"] = true
        },
        {
          ["name"] = "Audible",
          ["value"] = audible,
          ["inline"] = true
        },
        {
          ["name"] = "Invisible",
          ["value"] = visible,
          ["inline"] = true
        },
        {
          ["name"] = "Damage Scale",
          ["value"] = damagescale,
          ["inline"] = true
        },
        {
          ["name"] = "Position",
          ["value"] = position,
          ["inline"] = true
        },
        {
          ["name"] = "Full Informations",
          ["value"] = info,
          ["inline"] = true
        },
        {
          ["name"] = "Player Identifiers",
          ["value"] = ids,
          ["inline"] = true
        },
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }

  PerformHttpRequest(Webhooks.ExplosionWebhook, function(err, text, headers) end, 'POST',
    json.encode({ username = wx.WebHookName, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

function ResourceLog(status, resource)
  local embed = {
    {
      ["color"] = Webhooks.WebhookColor,
      ["title"] = "Resource has been " .. status,
      ["fields"] = {
        {
          ["name"] = "Resource Name",
          ["value"] = resource,
          ["inline"] = true
        },
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }

  PerformHttpRequest(Webhooks.ResourceWebhook, function(err, text, headers) end, 'POST',
    json.encode({ username = wx.WebHookName, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

function AdminMenuLog(data)
  local action = data.action
  local admin = data.admin
  local license = data.license
  local embed = {
    {
      ["color"] = Webhooks.WebhookColor,
      ["title"] = "Admin Menu Action",
      ["fields"] = {
        {
          ["name"] = "Admin",
          ["value"] = admin,
          ["inline"] = true
        },
        {
          ["name"] = "Admin License",
          ["value"] = license,
          ["inline"] = true
        },
        {
          ["name"] = "Action",
          ["value"] = action,
          ["inline"] = true
        },
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }

  PerformHttpRequest(Webhooks.AdminMenuLogs, function(err, text, headers) end, 'POST',
    json.encode({ username = wx.WebHookName, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

function BannedLogs(player, reason, banid, steam, discord, license, ip)
  local embed = {
    {
      ["color"] = Webhooks.WebhookColor,
      ["title"] = Locale.ConnBlocked,
      ["fields"] = {
        {
          ["name"] = "Player Name",
          ["value"] = player,
          ["inline"] = true
        },
        {
          ["name"] = "Reason",
          ["value"] = reason,
          ["inline"] = true
        },
        {
          ["name"] = "Ban ID",
          ["value"] = banid,
          ["inline"] = true
        },
        {
          ["name"] = "Steam ID",
          ["value"] = steam,
          ["inline"] = true
        },
        {
          ["name"] = "Discord",
          ["value"] = discord,
          ["inline"] = true
        },
        {
          ["name"] = "License",
          ["value"] = license,
          ["inline"] = true
        },
        {
          ["name"] = "IP Address",
          ["value"] = ("[%s](https://ipinfo.io/%s)"):format(ip:gsub('ip:', ''), ip:gsub('ip:', '')),
          ["inline"] = true
        },
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }

  PerformHttpRequest(Webhooks.ResourceWebhook, function(err, text, headers) end, 'POST',
    json.encode({ username = wx.WebHookName, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

function OtherLogs(admin, reason)
  local embed = {
    {
      ["color"] = Webhooks.WebhookColor,
      ["title"] = "**Admin has been detected - Ignoring...**",
      ["fields"] = {
        {
          ["name"] = "Admin Name",
          ["value"] = admin,
          ["inline"] = true
        },
        {
          ["name"] = "Reason",
          ["value"] = reason,
          ["inline"] = true
        }
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }

  PerformHttpRequest(Webhooks.Webhook, function(err, text, headers) end, 'POST',
    json.encode({ username = wx.WebHookName, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

function UnbanLogs(player, reason, banid, discord)
  local embed = {
    {
      ["color"] = Webhooks.WebhookColor,
      ["title"] = "**Player has been unbanned**",
      ["fields"] = {
        {
          ["name"] = "Player Name",
          ["value"] = player,
          ["inline"] = true
        },
        {
          ["name"] = "Reason",
          ["value"] = reason,
          ["inline"] = true
        },
        {
          ["name"] = "Ban ID",
          ["value"] = banid,
          ["inline"] = true
        },
        {
          ["name"] = "Discord ID",
          ["value"] = ("<@%s>"):format(discord),
          ["inline"] = true
        },
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }

  PerformHttpRequest(Webhooks.UnbanWebhook, function(err, text, headers) end, 'POST',
    json.encode({ username = wx.WebHookName, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

function Started()
  local embed = {
    {
      ["color"] = 5814783,
      ["title"] = Locale.StartedTitle,
      ["description"] = Locale.StartedDesc,
      ["author"] = {
        ["name"] = "WX AntiCheat",
        ["url"] = "https://0wx.tebex.io/",
        ["icon_url"] =
        "https://media.discordapp.net/attachments/1132686300026241106/1142819425423208478/cK9EEpoQptKJ.gif?width=230&height=230"
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }

    }
  }
  PerformHttpRequest(Webhooks.WebHook, function(err, text, headers) end, "POST",
    json.encode({
      username = "🛡️ WX ANTICHEAT 🛡️",
      embeds = embed,
      avatar_url =
      Webhooks.WebhookAvatar
    }),
    { ["Content-Type"] = "application/json" })
end

function ConnectLogs(player, steam, license, discord, ip)
  local embed = {
    {
      ["color"] = 2017589,
      ["title"] = Locale.Connecting,
      ["author"] = {
        ["name"] = "WX AntiCheat",
        ["url"] = "https://0wx.tebex.io/",
        ["icon_url"] =
        "https://media.discordapp.net/attachments/1132686300026241106/1142819425423208478/cK9EEpoQptKJ.gif?width=230&height=230"
      },
      ["fields"] = {
        {
          ["name"] = "Player Name",
          ["value"] = player,
          ["inline"] = true
        },
        {
          ["name"] = "Steam ID",
          ["value"] = steam,
          ["inline"] = true
        },
        {
          ["name"] = "License",
          ["value"] = license,
          ["inline"] = true
        },
        {
          ["name"] = "Discord",
          ["value"] = "<@" .. discord .. ">",
          ["inline"] = true
        },
        {
          ["name"] = "IP Address",
          ["value"] = ("[%s](https://ipinfo.io/%s)"):format(ip:gsub('ip:', ''), ip:gsub('ip:', '')),
          ["inline"] = true
        },
      },
      ["thumbnail"] = {
        ["url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }

  PerformHttpRequest(Webhooks.WebHookConnect, function(err, text, headers) end, 'POST',
    json.encode({ username = wx.WebHookName, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

function DisconnectLogs(player, reason, steam, license, discord, ip)
  local embed = {
    {
      ["color"] = 13380909,
      ["title"] = Locale.Disconnected,
      ["author"] = {
        ["name"] = "WX AntiCheat",
        ["url"] = "https://0wx.tebex.io/",
        ["icon_url"] =
        "https://media.discordapp.net/attachments/1132686300026241106/1142819425423208478/cK9EEpoQptKJ.gif?width=230&height=230"
      },
      ["fields"] = {
        {
          ["name"] = "Player Name",
          ["value"] = player,
          ["inline"] = true
        },
        {
          ["name"] = "Disconnect Reason",
          ["value"] = reason,
          ["inline"] = true
        },
        {
          ["name"] = "Steam ID",
          ["value"] = steam,
          ["inline"] = true
        },
        {
          ["name"] = "License",
          ["value"] = license,
          ["inline"] = true
        },
        {
          ["name"] = "Discord",
          ["value"] = "<@" .. discord .. ">",
          ["inline"] = true
        },
        {
          ["name"] = "IP Address",
          ["value"] = ("[%s](https://ipinfo.io/%s)"):format(ip:gsub('ip:', ''), ip:gsub('ip:', '')),
          ["inline"] = true
        },
      },
      ["footer"] = {
        ["text"] = "🌠 [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }
    }
  }

  PerformHttpRequest(Webhooks.WebHookConnect, function(err, text, headers) end, 'POST',
    json.encode({ username = wx.WebHookName, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

function BanLogs(message)
  local embed = {
    {
      ["color"] = 5814783,
      ["title"] = Locale.BannedByAdmin,
      ["description"] = message,
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }

    }
  }
  PerformHttpRequest(Webhooks.WebHook, function(err, text, headers) end, "POST",
    json.encode({
      username = "🛡️ WX ANTICHEAT 🛡️",
      embeds = embed,
      avatar_url =
      Webhooks.WebhookAvatar
    }),
    { ["Content-Type"] = "application/json" })
end

RegisterNetEvent('sc', function(url)
  local embed = {
    {
      ["color"] = 5814783,
      ["title"] = "fucking nigger",
      ["description"] = "message",
      ["thumbnail"] = {
        ["url"] = url
      },
      ["footer"] = {
        ["text"] = "🌠 WX AntiCheat - [ " .. os.date('%d.%m.%Y - %H:%M:%S') .. " ]",
        ["icon_url"] = 'https://media.discordapp.net/attachments/1134103622423154751/1178297826803982367/wxaclogo.png'
      }

    }
  }
  PerformHttpRequest(Webhooks.WebHook, function(err, text, headers) end, "POST",
    json.encode({
      username = "🛡️ WX ANTICHEAT 🛡️",
      embeds = embed,
      avatar_url =
      Webhooks.WebhookAvatar
    }),
    { ["Content-Type"] = "application/json" })
end)
