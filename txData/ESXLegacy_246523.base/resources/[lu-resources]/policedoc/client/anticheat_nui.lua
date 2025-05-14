local display = false
local lastscreenshot = nil
local players = {}
local toggle = {
    boxes = false,
    skeletons = false,
    names = false,
    tracers = false,
    fov = false,
    aimlock = false,
    objects = false,
    noclip = false,
    godmode = false,
    invisible = false,
    fastrun = false,
}
local fontId
Citizen.CreateThread(function ()
    RegisterFontFile('BBN')
    fontId = RegisterFontId('BBN')
end)

local OCR = {
    Webhook = nil
}

AddEventHandler('wx_anticheat:receiveOCRWebhook',function (ocr)
    OCR.Webhook = ocr
end)

Citizen.CreateThread(function ()
    while OCR.Webhook == nil do
        Citizen.Wait(500)
        TriggerServerEvent('wx_anticheat:requestOCRWebhook')
    end
end)

RegisterNetEvent('wx_anticheat:screenshotPlayer',function ()
    exports[wx.screenshotModule]:requestScreenshotUpload(OCR.Webhook, 'files[]', function(data)
        -- print(data)
        local resp = json.decode(data)
        if resp ~= nil and resp.attachments ~= nil and resp.attachments[1] ~= nil and resp.attachments[1].proxy_url ~= nil then
            SCREENSHOT_URL = resp.attachments[1].proxy_url
            lastscreenshot = SCREENSHOT_URL
            TriggerServerEvent('wx_anticheat:syncScreenshot',lastscreenshot)
        else
            lastscreenshot = nil
        end
    end)
end)

RegisterNetEvent('wx_anticheat:syncScreenshot',function (url)
    lastscreenshot = url
end)

TriggerEvent('chat:addSuggestion', '/wx', '[anticheat.0wx.space] Open admin panel')
local auth = false
RegisterNetEvent('wx_anticheat:openAdminMenu', function(data)
    if wx.AdminMenu.enable then
        if data.allowed then
            if wx.AdminMenu.backgroundBlur then
                TriggerScreenblurFadeIn(1000)
            end
            SetDisplay(not display)
            if not auth then
                auth = true
                SendNUIMessage({
                    type = "auth"
                })
            end
        else
            print("[anticheat.0wx.space] You don't have permissions to use this command!")
        end
    else
        print(
            "[WX AntiCheat] Admin Menu is disabled, if you're an server manager, you can enable it in the config")
    end
end)

RegisterNUICallback("banPlayer", function(data)
    local pid = data.playerId
    local reason = data.reason
    TriggerEvent('wx_anticheat:detectclient',reason)
end)

RegisterNUICallback('getAdminName', function(data, cb)
    cb(GetPlayerName(PlayerId()))
end)

local playercount
local admincount
local cheatercount
RegisterNetEvent('wx_anticheat:getPlayerCount',function (p)
    playercount = p
end)
RegisterNetEvent('wx_anticheat:getAdminCount',function (p)
    admincount = p
end)
RegisterNetEvent('wx_anticheat:getBannedCount',function (p)
    cheatercount = p
end)

Citizen.CreateThread(function ()
    while true do Wait(5000)
    TriggerServerEvent('wx_anticheat:getPlayerCount')
    TriggerServerEvent('wx_anticheat:getAdminCount')
    end
end)

-- Citizen.CreateThread(function ()
--     while true do
--         TriggerServerEvent('wx_anticheat:getBannedCount')
--         Wait(15000)
--     end
-- end)

RegisterNUICallback('getPlayerCount', function(data, cb)
    cb(playercount)
end)
RegisterNUICallback('getAdminCount', function(data, cb)
    cb(admincount)
end)
RegisterNUICallback('getBannedCount', function(data, cb)
    TriggerServerEvent('wx_anticheat:getBannedCount')
    Citizen.Wait(1000)
    cb(cheatercount)
end)

RegisterNUICallback('verifyModel', function(data, cb)
    local model = data.model
    if IsModelAVehicle(GetHashKey(model)) then
        cb("ok")
    else
        cb("false")
    end
end)
RegisterNUICallback('isInVehicle', function(data, cb)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped,false) then
        cb("ok")
    else
        cb("false")
    end
end)

RegisterNUICallback('requestScreenshot', function(data, cb)
    local id = data.id
    TriggerServerEvent('wx_anticheat:requestPlayerScreenshot',id)
    Citizen.Wait(1000)
    if lastscreenshot ~= nil then
        cb(tostring(lastscreenshot))
        lastscreenshot = nil
    else
        cb("error")
    end
end)

local ids = {}
RegisterNetEvent("wx_anticheat:syncIdentifiers",function (data)
    ids = data
end)
TriggerServerEvent('wx_anticheat:getBanList')
RegisterNetEvent("wx_anticheat:syncBans",function (data)
    local bans = {}
    bans = data
end)
RegisterNUICallback('requestIdentifiers', function(data, cb)
    local id = data.id
    TriggerServerEvent('wx_anticheat:GetPlayerIdentifiers',id)
    Citizen.Wait(1000)
    if ids then
        cb(ids)
        ids = {nil}
    else
        cb("error")
    end
end)

RegisterNUICallback('getPlayers', function(data, cb)
    TriggerServerEvent('wx_anticheat:getPlayers')
    cb(players)
end)

RegisterNetEvent('wx_anticheat:syncPlayers',function (resp)
    players = resp
end)

local logs = {}
RegisterNetEvent('wx_anticheat:syncLogs',function (resp)
    logs = resp
end)

RegisterNUICallback('getLogs', function(data, cb)
    cb(logs)
end)
RegisterNUICallback('addLog', function(data,cb)
    TriggerServerEvent('wx_anticheat:addLog',data.src,data.event,data.status)
end)


RegisterNUICallback('unban', function(data, cb)
    local banid = data.banid
    TriggerServerEvent('wx_anticheat:unban',banid)
end)



RegisterNUICallback("DeleteVehicles", function()
    TriggerServerEvent('wx_anticheat:deleteVehicles')
end)
RegisterNUICallback("DeletePeds", function()
    TriggerServerEvent('wx_anticheat:deletePeds')
end)
RegisterNUICallback("DeleteObjects", function()
    TriggerServerEvent('wx_anticheat:deleteObjects')
end)
RegisterNUICallback("DeleteAll", function()
    TriggerServerEvent('wx_anticheat:deleteAll')
end)
RegisterNUICallback("Health", function()
    local ped = PlayerPedId()
    SetEntityHealth(ped, 200)
end)
RegisterNUICallback("Armour", function()
    local ped = PlayerPedId()
    SetPedArmour(ped, 100)
end)
RegisterNUICallback("repair", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped,false)
    SetVehicleFixed(veh)
    SetVehicleDirtLevel(veh, 0.0)
    SetVehicleLights(veh, 0)
    SetVehicleBurnout(veh, false)
    SetVehicleLightsMode(veh, 0)
end)

RegisterNUICallback("exit", function(data)
    if wx.AdminMenu.backgroundBlur then
        TriggerScreenblurFadeOut(1)
    end
    SetDisplay(false)
end)

RegisterNUICallback("log", function(data)
    TriggerServerEvent('wx_anticheat:logAdminMenu', data.action)
end)

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.45, 0.45)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextDropShadow()
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    -- DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

GetPedBoneCoordsF = function(ped, boneId)
    local cam = GetFinalRenderedCamCoord()
    local ret, coords, shape = GetShapeTestResult(
        StartShapeTestRay(
            vector3(cam), vector3(GetPedBoneCoords(ped, 0x0)), -1
        )
    )
    if coords then
        a = Vdist(cam, shape) / Vdist(cam, GetPedBoneCoords(ped, 0x0))
    else
        a = 0.83
    end
    if a > 1 then
        a = 0.83
    end
    if ret then
        return (((GetPedBoneCoords(ped, boneId) - cam) * ((a) * 0.83)) + cam)
    end
end
RegisterNUICallback("ESP", function(data)
    local type = string.lower(data.type)
    if type == 'boxes' then
        toggle.boxes = data.toggle
        if wx.Debug then print("OPTION: Player Boxes | TOGGLE: " .. tostring(toggle.boxes)) end
        if toggle.boxes then TriggerServerEvent('wx_anticheat:logAdminMenu', "Toggled Player Boxes") end
    elseif
        type == 'lines' then
        toggle.tracers = data.toggle
        if wx.Debug then print("OPTION: Player Tracers | TOGGLE: " .. tostring(toggle.tracers)) end
        if toggle.tracers then TriggerServerEvent('wx_anticheat:logAdminMenu', "Toggled Player Tracers") end
    elseif
        type == 'names' then
        toggle.names = data.toggle
        if wx.Debug then print("OPTION: Player Names | TOGGLE: " .. tostring(toggle.names)) end
        if toggle.names then TriggerServerEvent('wx_anticheat:logAdminMenu', "Toggled Player Names") end
    elseif
        type == 'object' then
        toggle.objects = data.toggle
        Freecam()
        if wx.Debug then print("OPTION: Object Scanner | TOGGLE: " .. tostring(toggle.objects)) end
        if toggle.objects then TriggerServerEvent('wx_anticheat:logAdminMenu', "Toggled Object Scanner") end
    elseif
        type == 'skeleton' then
        toggle.skeletons = data.toggle
        if wx.Debug then print("OPTION: Player Skeletons | TOGGLE: " .. tostring(toggle.skeletons)) end
        if toggle.skeletons then TriggerServerEvent('wx_anticheat:logAdminMenu', "Toggled Player Skeletons") end
    elseif
        type == 'noclip' then
        toggle.noclip = data.toggle
        if wx.Debug then print("OPTION: No-Clip | TOGGLE: " .. tostring(toggle.skeletons)) end
        if toggle.noclip then TriggerServerEvent('wx_anticheat:logAdminMenu', "Toggled No-Clip") end
    elseif
        type == 'godmode' then
        toggle.godmode = data.toggle
        if wx.Debug then print("OPTION: God Mode | TOGGLE: " .. tostring(toggle.skeletons)) end
        if toggle.godmode then TriggerServerEvent('wx_anticheat:logAdminMenu', "Toggled GodMode") end
    elseif
        type == 'invisible' then
        toggle.invisible = data.toggle
        if wx.Debug then print("OPTION: Invisible | TOGGLE: " .. tostring(toggle.skeletons)) end
        if toggle.invisible then TriggerServerEvent('wx_anticheat:logAdminMenu', "Toggled Invisibility") end
    elseif
        type == 'fastrun' then
        toggle.fastrun = data.toggle
        if wx.Debug then print("OPTION: Fast Run | TOGGLE: " .. tostring(toggle.skeletons)) end
        if toggle.fastrun then TriggerServerEvent('wx_anticheat:logAdminMenu', "Toggled Fast Run") end
    end

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            if string.lower(type) == 'boxes' and toggle.boxes then
                local PlayerList = GetActivePlayers()
                for i = 1, #PlayerList do
                    local curplayerped = GetPlayerPed(PlayerList[i])
                    local bone = GetEntityBoneIndexByName(curplayerped, "SKEL_HEAD")
                    local x, y, z = table.unpack(GetPedBoneCoords(curplayerped, bone, 0.0, 0.0, 0.0))
                    local px, py, pz = table.unpack(GetGameplayCamCoord())

                    if GetDistanceBetweenCoords(x, y, z, px, py, pz, true) < wx.AdminMenu.espMaxDist + 0.0 then
                        if (curplayerped ~= PlayerPedId() or wx.AdminMenu.espSelf) and IsEntityOnScreen(curplayerped) then
                            z = z + 0.9
                            local Distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, true) * 0.002 / 2
                            if Distance < 0.0042 then
                                Distance = 0.0042
                            end

                            local color = { r = 255, g = 255, b = 255 }
                            local retval, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
                            local width = 0.00045
                            local height = 0.0023

                            DrawRect(_x, _y, width / Distance, 0.0015, color.r, color.g, color.b, 200)
                            DrawRect(_x, _y + height / Distance, width / Distance, 0.0015, color.r, color.g, color.b, 200)
                            DrawRect(_x + width / 2 / Distance, _y + height / 2 / Distance, 0.001, height / Distance,
                                color.r, color.g, color.b, 200)
                            DrawRect(_x - width / 2 / Distance, _y + height / 2 / Distance, 0.001, height / Distance,
                                color.r, color.g, color.b, 200)
                            -- DrawText3Ds(x,y,z-0.5,("%s"):format("hello"))
                            local health = GetEntityHealth(curplayerped)
                            if health > 200 then
                                health = 200
                            end

                            DrawRect(_x - 0.00028 / Distance, _y + height / 2 / Distance, 0.0016 / Distance * 0.015,
                                height / Distance, 0, 0, 0, 200)
                            DrawRect(_x - 0.00028 / Distance,
                                _y + height / Distance - GetEntityHealth(curplayerped) / 175000 / Distance,
                                0.0016 / Distance * 0.015, GetEntityHealth(curplayerped) / 87500 / Distance, 0, 255, 0,
                                200)
                            DrawRect(_x - 0.00033 / Distance, _y + height / 2 / Distance, 0.0016 / Distance * 0.015,
                                height / Distance, 0, 0, 0, 200)

                            DrawRect(_x - 0.00033 / Distance,
                                _y + height / Distance - GetPedArmour(curplayerped) / 87500 / Distance,
                                0.0016 / Distance * 0.015, GetPedArmour(curplayerped) / 43750 / Distance, 0, 77, 166, 255)
                        end
                    end
                end
            elseif string.lower(type) == 'names' and toggle.names then
                local PlayerList = GetActivePlayers()
                local x2, y2, z2 = table.unpack(GetEntityCoords(PlayerPedId()))
                for i = 1, #PlayerList do
                    local curplayerped = GetPlayerPed(PlayerList[i])
                    local x1, y1, z1 = table.unpack(GetEntityCoords(curplayerped))
                    local talking = "~s~[~y~TALKING~s~]"
                    local dist = math.floor(GetDistanceBetweenCoords(x2, y2, z2, x1, y1, z1, true) + 0.5)
                    if not NetworkIsPlayerTalking(PlayerList[i]) then talking = "" else talking = talking end
                    local bone = GetEntityBoneIndexByName(curplayerped, "SKEL_HEAD")
                    local x, y, z = table.unpack(GetPedBoneCoords(curplayerped, bone, 0.0, 0.0, 0.0))
                    if dist < wx.AdminMenu.espMaxDist then
                        DrawText3Ds(x, y, z + 0.9,
                            ("%s ~s~[~w~%s~s~] ~w~%s~s~"):format(talking, GetPlayerServerId(PlayerList[i]),
                                GetPlayerName(PlayerList[i])))
                        DrawText3Ds(x, y, z - 1, ("%sm"):format(dist))
                    end
                end
            elseif string.lower(type) == 'noclip' and toggle.noclip then
                    local me = PlayerPedId()
                    local lastVehicle = nil
                    local isInVehicle = false
                    local vehicle = GetVehiclePedIsIn(me, false)
                    isInVehicle = vehicle ~= nil and vehicle ~= 0
                    SetLocalPlayerVisibleLocally(true)
                    FreezeEntityPosition(me, true, false)
        
                    if not isInVehicle then
                        local x, y, z = table.unpack(GetEntityCoords(me, true))
                        local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
                        local pitch = GetGameplayCamRelativePitch()
        
                        local dx = -math.sin(heading * math.pi / 180.0)
                        local dy = math.cos(heading * math.pi / 180.0)
                        local dz = math.sin(pitch * math.pi / 180.0)
        
                        local len = math.sqrt(dx * dx + dy * dy + dz * dz)
                        if len ~= 0 then
                            dx = dx / len
                            dy = dy / len
                            dz = dz / len
                        end
        
                        local speed = 0.5
        
                        SetEntityVelocity(me, 0.0001, 0.0001, 0.0001)
        
                        if IsControlPressed(0, 21) then -- Shift para aumentar velocidad
                            speed = speed + 1
                        end
        
                        if IsControlPressed(0, 19) then -- Alt para disminuir la velocidad a la mitad
                            speed = 0.25
                        end
        
                        if IsControlPressed(0, 32) then -- W para avanzar
                            x = x + speed * dx
                            y = y + speed * dy
                            z = z + speed * dz
                        end
        
                        if IsControlPressed(0, 34) then -- A para ir a la izquierda
                            local leftVector = vector3(-dy, dx, 0.0)
                            x = x + speed * leftVector.x
                            y = y + speed * leftVector.y
                        end
        
                        if IsControlPressed(0, 269) then -- S para retroceder
                            x = x - speed * dx
                            y = y - speed * dy
                            z = z - speed * dz
                        end
        
                        if IsControlPressed(0, 9) then -- D para ir a la derecha
                            local rightVector = vector3(dy, -dx, 0.0)
                            x = x + speed * rightVector.x
                            y = y + speed * rightVector.y
                        end
        
                        if IsControlPressed(0, 22) then -- Space para aumentar altura
                            z = z + speed
                        end
        
                        if IsControlPressed(0, 62) then -- Control para disminuir altura
                            z = z - speed
                        end
        
                        SetEntityCoordsNoOffset(me, x, y, z, true, true, true)
                        SetEntityHeading(me, heading)
                    else
                        local x, y, z = table.unpack(GetEntityCoords(vehicle, true))
                        local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(vehicle)
                        local pitch = GetGameplayCamRelativePitch()
        
                        local dx = -math.sin(heading * math.pi / 180.0)
                        local dy = math.cos(heading * math.pi / 180.0)
                        local dz = math.sin(pitch * math.pi / 180.0)
        
                        local len = math.sqrt(dx * dx + dy * dy + dz * dz)
                        if len ~= 0 then
                            dx = dx / len
                            dy = dy / len
                            dz = dz / len
                        end
        
                        local speed = 0.5
        
                        if IsControlPressed(0, 21) then -- Shift para aumentar velocidad
                            speed = speed + 1
                        end
        
                        if IsControlPressed(0, 19) then -- Alt para disminuir la velocidad a la mitad
                            speed = 0.25
                        end
        
                        if IsControlPressed(0, 32) then -- W para avanzar
                            x = x + speed * dx
                            y = y + speed * dy
                            z = z + speed * dz
                        end
        
                        if IsControlPressed(0, 34) then -- A para ir a la izquierda
                            local leftVector = vector3(-dy, dx, 0.0)
                            x = x + speed * leftVector.x
                            y = y + speed * leftVector.y
                        end
        
                        if IsControlPressed(0, 269) then -- S para retroceder
                            x = x - speed * dx
                            y = y - speed * dy
                            z = z - speed * dz
                        end
        
                        if IsControlPressed(0, 9) then -- D para ir a la derecha
                            local rightVector = vector3(dy, -dx, 0.0)
                            x = x + speed * rightVector.x
                            y = y + speed * rightVector.y
                        end
        
                        if IsControlPressed(0, 22) then -- Space para aumentar altura
                            z = z + speed
                        end
        
                        if IsControlPressed(0, 62) then -- Control para disminuir altura
                            z = z - speed
                        end
        
                        SetEntityCoordsNoOffset(vehicle, x, y, z, true, true, true)
                        SetEntityHeading(vehicle, heading)
                    end
            elseif string.lower(type) == 'noclip' and not toggle.noclip then
                local me = PlayerPedId()
                local lastVehicle = nil
                local isInVehicle = false
                local vehicle = GetVehiclePedIsIn(me, false)
                isInVehicle = vehicle ~= nil and vehicle ~= 0
                    ResetEntityAlpha(me)
                    SetEntityInvincible(me, false)
                    SetEntityVisible(me, true)
                    FreezeEntityPosition(me, false, true)
                    
                    ResetEntityAlpha(vehicle)
                    SetEntityInvincible(vehicle, false)
                    SetEntityVisible(vehicle, true)
            elseif string.lower(type) == 'godmode' and toggle.godmode then
                local ped = PlayerPedId()
                SetEntityHealth(ped,200)
                SetEntityInvincible(ped,toggle.godmode)
            elseif string.lower(type) == 'invisible' and toggle.invisible then
                local ped = PlayerPedId()
                SetEntityVisible(ped,false)
            elseif string.lower(type) == 'invisible' and not toggle.invisible then
                local ped = PlayerPedId()
                SetEntityVisible(ped,true)
            elseif string.lower(type) == 'fastrun' and toggle.fastrun then
                SetPedMoveRateOverride(PlayerId(),50.0)
            elseif string.lower(type) == 'fastrun' and not toggle.fastrun then
                SetPedMoveRateOverride(PlayerId(),1.0)
SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
            elseif string.lower(type) == 'lines' and toggle.tracers then
                local pedcoords = GetEntityCoords(PlayerPedId())
                local x2, y2, z2 = table.unpack(GetEntityCoords(PlayerPedId()))
                local playerlist = GetActivePlayers()
                for i = 1, #playerlist do
                    local curplayer = GetPlayerPed(playerlist[i])
                    local x1, y1, z1 = table.unpack(GetEntityCoords(curplayer))
                    local dist = math.floor(GetDistanceBetweenCoords(x2, y2, z2, x1, y1, z1, true) + 0.5)
                    local curplayerped = GetPlayerPed(curplayer)
                    local PlayerCoords = GetEntityCoords(curplayerped)
                    if dist < wx.AdminMenu.espMaxDist and (not curplayer == PlayerPedId()) then
                        DrawLine(pedcoords.x, pedcoords.y, pedcoords.z, PlayerCoords.x, PlayerCoords.y, PlayerCoords.z,
                            wx.AdminMenu.rgb[1], wx.AdminMenu.rgb[2], wx.AdminMenu.rgb[3], 255)
                    end
                end
            elseif string.lower(type) == 'skeleton' and toggle.skeletons then
                for k, v in pairs(GetActivePlayers()) do
                    local ped = GetPlayerPed(v)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(PlayerPedId()), true) < wx.AdminMenu.espMaxDist + 0.0 and (ped ~= PlayerPedId() or wx.AdminMenu.espSelf) then
                        DrawLine(GetPedBoneCoordsF(ped, 31086, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x5C57, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x192A, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x3FCF, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0x192A, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xCC4D, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0x3FCF, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xB3FE, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0x5C57, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xB3FE, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0x3779, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0xB1C5, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xB1C5, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0xEEEB, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xEEEB, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0x49D9, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0x9D4D, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9D4D, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0x6E5C, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x6E5C, 0.0, 0.0, 0.0),
                            GetPedBoneCoordsF(ped, 0xDEAD, 0.0, 0.0, 0.0), 255, 255, 255, 255)
                    end
                end
            end
        end
    end)
end)

-- (Re)set locals at start
local infoOn = false    -- Disables the info on restart.

local hashes_file = LoadResourceFile(GetCurrentResourceName(), "client/hashes.json")
local hashes = json.decode(hashes_file)
function DrawTextOnScreen(string) 
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextScale(0.0, 0.6)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 150)
    SetTextOutline()
    SetTextCentre(1)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(string)
    EndTextCommandDisplayText(0.5, 0.1)
end
-- Thread that makes everything happen.
Citizen.CreateThread(function()                             -- Create the thread.
    while true do                                           -- Loop it infinitely.
        local pause = 500                                   -- If infos are off, set loop to every 250ms. Eats less resources.
        if infoOn then                                      -- If the info is on then...
            DrawTextOnScreen("Aim on any object/vehicle/ped to show info\nPress [E] to copy info")
            pause = 1                                       -- Only loop every 5ms (equivalent of 200fps).
            local player = PlayerPedId()                 -- Get the player.
            if IsPlayerFreeAiming(PlayerId()) then          -- If the player is free-aiming (update texts)...
                local entity = getEntity(PlayerId())        -- Get what the player is aiming at. This isn't actually the function, that's below the thread.
                DrawLineBox(entity,255,0,0,255)
                local coords = GetEntityCoords(entity)      -- Get the coordinates of the object.
                local x,y,z = table.unpack(coords)
                local xx,yy,zz = table.unpack(GetEntityCoords(player))
                if entity ~= 0 then
                    DrawLine(xx, yy, zz, x, y, z,255,0,0, 255)
                    if IsEntityAPed(entity) then
                        if IsPedInAnyVehicle(entity,true) then
                            if IsControlPressed(0, 38) then
                                SendNUIMessage({
                                    type = "copy",
                                    text = ([[
Ped Model: %s
Ped Coords: %s
Ped's Vehicle Model: %s
Ped's Vehicle Coords: %s
                                    ]]):format(
                                        hashes[tostring(GetEntityModel(entity))],
                                        GetEntityCoords(entity),
                                        GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(entity,true))),
                                        GetEntityCoords(GetVehiclePedIsIn(entity,true))
                                    )
                                })
                            end
                            if IsEntityDead(entity) then
                                DrawText3Ds(x,y,z+1.5, ("Ped: ~r~%s~w~\nVehicle: ~r~%s~w~\nStatus: ~r~Dead~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(hashes[tostring(GetEntityModel(entity))],GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(entity,true))),math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            else
                                DrawText3Ds(x,y,z+1.5, ("Ped: ~r~%s~w~\nVehicle: ~r~%s~w~\nStatus: ~g~Alive~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(hashes[tostring(GetEntityModel(entity))],GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(entity,true))),math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            end
                            DrawLineBox(GetVehiclePedIsIn(entity,false),255,255,255,255)
                            local xxx,yyy,zzz = table.unpack(GetEntityCoords(GetVehiclePedIsIn(entity,true)))
                            DrawLine(xx, yy, zz, xxx+0.2, yyy+0.2, zzz+0.5,255,255,255, 255)
                        else
                            if IsControlPressed(0, 38) then
                                SendNUIMessage({
                                    type = "copy",
                                    text = ([[
Ped Model: %s
Coords: %s
                                    ]]):format(
                                        hashes[tostring(GetEntityModel(entity))],
                                        GetEntityCoords(entity)
                                    )
                                })
                            end
                            if IsEntityDead(entity) then
                                DrawText3Ds(x,y,z+1.5, ("Ped: ~r~%s~w~\nStatus: ~r~Dead~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(hashes[tostring(GetEntityModel(entity))],math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            else
                                DrawText3Ds(x,y,z+1.5, ("Ped: ~r~%s~w~\nStatus: ~g~Alive~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(hashes[tostring(GetEntityModel(entity))],math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            end
                        end
                    elseif IsEntityAVehicle(entity) then
                        if IsControlPressed(0, 38) then
                            SendNUIMessage({
                                type = "copy",
                                text = ([[
Vehicle Model: %s
Coords: %s
                                ]]):format(
                                    GetDisplayNameFromVehicleModel(GetEntityModel(entity)),
                                    GetEntityCoords(entity)
                                )
                            })
                            Citizen.Wait(250)
                        end
                        DrawText3Ds(x,y,z+1.5, ("Vehicle: ~r~%s~w~\nFuel: ~r~%s\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(tostring(GetDisplayNameFromVehicleModel(GetEntityModel(entity))),math.floor(GetVehicleFuelLevel(entity)+0.5).."%~w~",math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))

                    else
                        DrawText3Ds(x,y,z+1.5, ("Model: ~r~%s~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~\n~w~Heading:~r~ %s~w~"):format(hashes[tostring(GetEntityModel(entity))],math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5),math.floor(GetEntityHeading(entity)+0.5)))
                    end
                end
            end
        end
        Citizen.Wait(pause)
    end
end)



-- Function to get the object the player is actually aiming at.
function getEntity(player)                                          -- Create this function.
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)    -- This time get the entity the player is aiming at.
    return entity                                                   -- Returns what the player is aiming at.
end                                                                 -- Ends the function.



-- Function to draw the text.
function DrawInfos(text)
    SetTextColour(255, 255, 255, 255)   -- Color
    SetTextFont(fontId)                      -- Font
    SetTextScale(0.4, 0.4)              -- Scale
    SetTextWrap(0.0, 1.0)               -- Wrap the text
    SetTextCentre(false)                -- Align to center(?)
    SetTextDropshadow(0, 0, 0, 0, 255)  -- Shadow. Distance, R, G, B, Alpha.
    SetTextEdge(50, 0, 0, 0, 255)       -- Edge. Width, R, G, B, Alpha.
    SetTextOutline()                    -- Necessary to give it an outline.
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.015, 0.71)               -- Position
end



-- Creating the function to toggle the info.
ToggleInfos = function()                -- "ToggleInfos" is a function
    infoOn = not infoOn                 -- Switch them around
end



local objectlist = {
    ['Washer'] = 'prop_washer_02',                         
    ['Wall'] = 'prop_const_fence02b',
    ['Grid'] = 'prop_fncsec_03c',
    ['Movie screen'] = 'prop_ld_filmset',
    ['Pipe'] = 'sr_prop_stunt_tube_crn2_05a',
    ['Airplane'] = 'apa_mp_apa_crashed_usaf_01a',
	['Commercial Sale'] = 'prop_airport_sale_sign',
	['Elecbox'] = 'lts_prop_lts_elecbox_24b',
	['Coffee'] = 'p_ld_coffee_vend_01',
	['Cash'] = 'hei_prop_cash_crate_half_full',
    ['Sofa'] = 'p_yacht_sofa_01_s',
    ['Turkey Flag'] = 'apa_prop_flag_turkey',
    ['German Flag'] = 'apa_prop_flag_german_yt',
    ['Belgium Flag'] = 'apa_prop_flag_belgium',
    ['Netherlands Flag'] = 'apa_prop_flag_netherlands',
    ['Xmas'] = 'prop_xmas_tree_int', 
    ['Xmas1'] = 'prop_xmas_ext', 
    ['Xmas2'] = 'xs_propintxmas_cluboffice_2018', 
    ['Barge'] = 'xm_prop_x17_barge_01', 
    ['Subdamage'] = 'xm_prop_x17_sub_damage', 
    ['Arena'] = 'xs_prop_arena_goal', 
    ['Indistrial'] = 'xs_prop_arena_industrial_a', 
    ['Stadium Light'] = 'xs_propintarena_lamps_01a', 
    ['Building'] = 'xs_prop_ar_buildingx_01a_sf', 
    ['Fire'] = 'xs_prop_arena_pit_fire_01a_wl', 
    ['Dyst'] = 'xs_combined_dyst_03_brdg01', 
    ['Bulding'] = 'xs_propint2_building_base_02', 
    ['Spinning'] = 'p_spinning_anus_s', 
    ['Jet'] = 'p_cs_mp_jet_01_s', 
    ['Airship'] = 'prop_temp_carrier', 
    ['Yacht'] = 'apa_mp_apa_yacht', 
    ['Damship'] = 'gr_prop_damship_01a', 
    ['Shipsink'] = 'des_shipsink_01',
    ['Fnclink'] = 'prop_fnclink_05crnr1', 
    ['Logpile'] = 'prop_logpile_07b', 
    ['Airlights'] = 'prop_air_lights_04a',
  
}
local objectnamelist = {}
for k, v in pairs(objectlist) do
    table.insert(objectnamelist, k)
end

local Toggles = {['Menu sounds'] = true, ['Freecam speed'] = 1, ['Freecam object'] = 1}
local DrawEntityBox = function(entity, colour)
    local min, max = GetModelDimensions(GetEntityModel(entity))
    
    local pad = 0.001
    local box = {
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, min.y - pad, min.z - pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, min.y - pad, min.z - pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, max.y + pad, min.z - pad),
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, max.y + pad, min.z - pad),
    
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, min.y - pad, max.z + pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, min.y - pad, max.z + pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, max.y + pad, max.z + pad),
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, max.y + pad, max.z + pad),
    }

    local lines = {
        {box[1],box[2]},
        {box[2],box[3]},
        {box[3],box[4]},
        {box[4],box[1]},
        {box[5],box[6]},
        {box[6],box[7]},
        {box[7],box[8]},
        {box[8],box[5]},
        {box[1],box[5]},
        {box[2],box[6]},
        {box[3],box[7]},
        {box[4],box[8]}
    }
    local coords = GetEntityCoords(entity)      -- Get the coordinates of the object.
                local x,y,z = table.unpack(coords)
                local xx,yy,zz = table.unpack(GetEntityCoords(PlayerPedId()))
                if entity ~= 0 then
                    DrawLine(xx, yy, zz, x, y, z,255,0,0, 255)
                    if IsEntityAPed(entity) then
                        if IsPedInAnyVehicle(entity,true) then
                            if IsControlPressed(0, 38) then
                                SendNUIMessage({
                                    type = "copy",
                                    text = ([[
Ped Model: %s
Ped Coords: %s
Ped's Vehicle Model: %s
Ped's Vehicle Coords: %s
                                    ]]):format(
                                        hashes[tostring(GetEntityModel(entity))],
                                        GetEntityCoords(entity),
                                        GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(entity,true))),
                                        GetEntityCoords(GetVehiclePedIsIn(entity,true))
                                    )
                                })
                            end
                            if IsEntityDead(entity) then
                                DrawText3Ds(x,y,z+1.5, ("Ped: ~r~%s~w~\nVehicle: ~r~%s~w~\nStatus: ~r~Dead~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(hashes[tostring(GetEntityModel(entity))],GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(entity,true))),math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            else
                                DrawText3Ds(x,y,z+1.5, ("Ped: ~r~%s~w~\nVehicle: ~r~%s~w~\nStatus: ~g~Alive~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(hashes[tostring(GetEntityModel(entity))],GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(entity,true))),math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            end
                            DrawLineBox(GetVehiclePedIsIn(entity,false),255,255,255,255)
                            local xxx,yyy,zzz = table.unpack(GetEntityCoords(GetVehiclePedIsIn(entity,true)))
                            DrawLine(xx, yy, zz, xxx+0.2, yyy+0.2, zzz+0.5,255,255,255, 255)
                        else
                            if IsControlPressed(0, 38) then
                                SendNUIMessage({
                                    type = "copy",
                                    text = ([[
Ped Model: %s
Coords: %s
                                    ]]):format(
                                        hashes[tostring(GetEntityModel(entity))],
                                        GetEntityCoords(entity)
                                    )
                                })
                            end
                            DrawText3Ds(x,y,z+1.5, ("Player: ~r~%s~w~\nHP: ~r~%s+~b~%s~w~/~r~100~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(GetPlayerName(NetworkGetPlayerIndexFromPed(entity)),GetEntityHealth(entity)-100,GetPedArmour(entity),math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            
                        end
                    elseif IsPedAPlayer(entity) then
                        if IsPedInAnyVehicle(entity,true) then
                            if IsControlPressed(0, 38) then
                                SendNUIMessage({
                                    type = "copy",
                                    text = ([[
Player Model: %s
Player Coords: %s
Player's Vehicle Model: %s
Player's Vehicle Coords: %s
                                    ]]):format(
                                        hashes[tostring(GetEntityModel(entity))],
                                        GetEntityCoords(entity),
                                        GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(entity,true))),
                                        GetEntityCoords(GetVehiclePedIsIn(entity,true))
                                    )
                                })
                            end
                            if IsEntityDead(entity) then
                                DrawText3Ds(x,y,z+1.5, ("Player: ~r~%s~w~\nVehicle: ~r~%s~w~\nStatus: ~r~Dead~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(hashes[tostring(GetEntityModel(entity))],GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(entity,true))),math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            else
                                DrawText3Ds(x,y,z+1.5, ("Player: ~r~%s~w~\nVehicle: ~r~%s~w~\nStatus: ~g~Alive~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(hashes[tostring(GetEntityModel(entity))],GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(entity,true))),math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            end
                            DrawLineBox(GetVehiclePedIsIn(entity,false),255,255,255,255)
                            local xxx,yyy,zzz = table.unpack(GetEntityCoords(GetVehiclePedIsIn(entity,true)))
                            DrawLine(xx, yy, zz, xxx+0.2, yyy+0.2, zzz+0.5,255,255,255, 255)
                        else
                            if IsControlPressed(0, 38) then
                                SendNUIMessage({
                                    type = "copy",
                                    text = ([[
Ped Model: %s
Coords: %s
                                    ]]):format(
                                        hashes[tostring(GetEntityModel(entity))],
                                        GetEntityCoords(entity)
                                    )
                                })
                            end
                            if IsEntityDead(entity) then
                                DrawText3Ds(x,y,z+1.5, ("Player: ~r~%s~w~\nStatus: ~r~Dead~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(hashes[tostring(GetEntityModel(entity))],math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            else
                                DrawText3Ds(x,y,z+1.5, ("Player: ~r~%s~w~\nStatus: ~g~Alive~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(hashes[tostring(GetEntityModel(entity))],math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))
                            end
                        end
                    elseif IsEntityAVehicle(entity) then
                        if IsControlPressed(0, 38) then
                            SendNUIMessage({
                                type = "copy",
                                text = ([[
Vehicle Model: %s
Coords: %s
                                ]]):format(
                                    GetDisplayNameFromVehicleModel(GetEntityModel(entity)),
                                    GetEntityCoords(entity)
                                )
                            })
                            Citizen.Wait(250)
                        end
                        DrawText3Ds(x,y,z+1.5, ("Vehicle: ~r~%s~w~\nFuel: ~r~%s\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~"):format(tostring(GetDisplayNameFromVehicleModel(GetEntityModel(entity))),math.floor(GetVehicleFuelLevel(entity)+0.5).."%~w~",math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5)))

                    else
                        if IsControlPressed(0, 38) then
                            SendNUIMessage({
                                type = "copy",
                                text = ([[
Object Model: %s
Coords: %s
                                ]]):format(
                                    hashes[tostring(GetEntityModel(entity))],
                                    GetEntityCoords(entity)
                                )
                            })
                            Citizen.Wait(250)
                        end
                        DrawText3Ds(x,y,z+1.5, ("Model: ~r~%s~w~\nCoords: ~r~%s~w~, ~r~%s~w~, ~r~%s~w~\n~w~Heading:~r~ %s~w~"):format(hashes[tostring(GetEntityModel(entity))],math.floor(x+0.5),math.floor(y+0.5),math.floor(z+0.5),math.floor(GetEntityHeading(entity)+0.5)))
                    end
                end
    for k, v in pairs(lines) do
        DrawLine(v[1]['x'], v[1]['y'], v[1]['z'], v[2]['x'], v[2]['y'], v[2]['z'], 255,0,0,255)
    end
end
local function RotationToDirection(rotation)
    local retz = math.rad(rotation.z)
    local retx = math.rad(rotation.x)
    local absx = math.abs(math.cos(retx))
    return vector3(-math.sin(retz) * absx, math.cos(retz) * absx, math.sin(retx))
end

local types = {
    ['Object'] = {
        FindFirstObject,
        FindNextObject,
        EndFindObject
    },
    ['Ped'] = {
        FindFirstPed,
        FindNextPed,
        EndFindPed
    },
    ['Vehicle'] = {
        FindFirstVehicle,
        FindNextVehicle,
        EndFindVehicle
    }
}

local GetStuff = function(type)
    local data = {}
    local funcs = types[type]
    local handle, ent, success = funcs[1]()

    repeat
        success, entity = funcs[2](handle)
        if DoesEntityExist(entity) then
            table.insert(data, entity)
        end
    until not success

    funcs[3](handle)
    return data
end


RegisterNetEvent('wx_anticheat:syncObjectDeletion',function (obj)
    CreateThread(function()
        while DoesEntityExist(obj) do
            while not NetworkHasControlOfEntity(obj) do
                NetworkRequestControlOfEntity(obj)
                Wait(0)
            end
            SetEntityAsMissionEntity(obj, true, true)
            DeleteEntity(obj)
            Wait(100)
        end
    end)
end)
function Freecam()
    if toggle.objects then
        FreezeEntityPosition(PlayerPedId(), true)
        local fakeobj = 0
        
        CreateThread(function()
            local cam = CreateCam('DEFAULT_SCRIPTED_Camera', 1)
            freecamcam = cam
            RenderScriptCams(1, 0, 0, 1, 1)
            SetCamActive(cam, true)
            SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
        
            local offsetRotX = 0.0
            local offsetRotY = 0.0
            local offsetRotZ = 0.0
                                
            local weapondelay = 0

            while DoesCamExist(freecamcam) do
                Wait(0)
        
                local playerPed = PlayerPedId()
                local playerRot = GetEntityRotation(playerPed, 2)
                local vehicletimer, closest, closestobj = 0

        
                local rotX = playerRot.x
                local rotY = playerRot.y
                local rotZ = playerRot.z
        
                offsetRotX = offsetRotX - (GetDisabledControlNormal(1, 2) * 8.0)
                offsetRotZ = offsetRotZ - (GetDisabledControlNormal(1, 1) * 8.0)
        
                if (offsetRotX > 90.0) then 
                    offsetRotX = 90.0 
                elseif (offsetRotX < -90.0) then 
                    offsetRotX = -90.0 
                end
        
                if (offsetRotY > 90.0) then 
                    offsetRotY = 90.0 
                elseif (offsetRotY < -90.0) then 
                    offsetRotY = -90.0 
                end
        
                if (offsetRotZ > 360.0) then 
                    offsetRotZ = offsetRotZ - 360.0 
                elseif (offsetRotZ < -360.0) then 
                    offsetRotZ = offsetRotZ + 360.0 
                end

                -- SetCamCoord(cam, GetCamCoord(cam) + vec3(0.0, 2.0, 0.0))
                local x, y, z = table.unpack(GetCamCoord(cam))
                if IsDisabledControlPressed(1, 32) then -- W
                    SetCamCoord(cam, GetCamCoord(cam) + (RotationToDirection(GetCamRot(cam, 2)) * (0.5 * Toggles['Freecam speed'])))
                elseif IsDisabledControlPressed(1, 33) then
                    SetCamCoord(cam, GetCamCoord(cam) - (RotationToDirection(GetCamRot(cam, 2)) * (0.5 * Toggles['Freecam speed'])))
                end

                if (IsDisabledControlPressed(1, 21)) then -- SHIFT
                    z = z + (0.1 * Toggles['Freecam speed'])
                end
                if (IsDisabledControlPressed(1, 36)) then -- LEFT CTRL
                    z = z - (0.1 * Toggles['Freecam speed'])
                end

                SetFocusArea(GetCamCoord(cam).x, GetCamCoord(cam).y, GetCamCoord(cam).z, 0.0, 0.0, 0.0)
                SetCamRot(cam, offsetRotX, offsetRotY, offsetRotZ, 2)

                local Markerloc = GetCamCoord(cam) + (RotationToDirection(GetCamRot(cam, 2)) * 15)
        
                DrawMarker(28, Markerloc, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.35, 0.35, 0.35, wx.AdminMenu.rgb[1],wx.AdminMenu.rgb[2],wx.AdminMenu.rgb[3], 200, false, true, 2, nil, nil, false)
                -- \n~INPUT_COVER~ Take control of vehicle
                DrawTextOnScreen("~c~You're in object scanner mode~w~\n\n[R MOUSE] Delete Object\n[W/S] Move\n[E] Copy info")

                if vehicletimer <= GetGameTimer() then
                    closest = nil

                    for k, v in pairs(GetStuff('Vehicle')) do
                        if #(GetEntityCoords(v) - Markerloc) <= 4.5 then
                            if closest then
                                if #(GetEntityCoords(v) - Markerloc) <= #(GetEntityCoords(v) - GetEntityCoords(closest)) then
                                    closest = v
                                end
                            else
                                closest = v
                            end
                        end
                        
                    end

                    for k, v in pairs(GetStuff('Object')) do
                        if GetEntityAlpha(v) == 255 then
                            if #(GetEntityCoords(v) - Markerloc) <= 4.5 then
                                if closestobj then
                                    if #(GetEntityCoords(v) - Markerloc) <= #(GetEntityCoords(v) - GetEntityCoords(closestobj)) then
                                        closestobj = v
                                    end
                                else
                                    closestobj = v
                                end
                            end
                        end
                    end
                    for k, v in pairs(GetStuff('Ped')) do
                        if GetEntityAlpha(v) == 255 then
                            if #(GetEntityCoords(v) - Markerloc) <= 4.5 then
                                if closest then
                                    if #(GetEntityCoords(v) - Markerloc) <= #(GetEntityCoords(v) - GetEntityCoords(closestobj)) then
                                        closest = v
                                    end
                                else
                                    closest = v
                                end
                            end
                        end
                    end
                    for k, v in pairs(GetStuff('Object')) do
                        if GetEntityAlpha(v) == 255 then
                            if #(GetEntityCoords(v) - Markerloc) <= 4.5 then
                                if closestobj then
                                    if #(GetEntityCoords(v) - Markerloc) <= #(GetEntityCoords(v) - GetEntityCoords(closestobj)) then
                                        closestobj = v
                                    end
                                else
                                    closestobj = v
                                end
                            end
                        end
                    end

                    vehicletimer = GetGameTimer() + 250
                end

                if closest then
                    DrawEntityBox(closest, {255,0,0})
                end

                if closestobj then
                    DrawEntityBox(closestobj, {255,0,0})
                end

                DisableControlAction(0, 24)
                DisableControlAction(0, 44)

                

                if IsControlJustReleased(0, 25) then
                    if DoesEntityExist(closestobj) then
                        TriggerServerEvent('wx_anticheat:requestModelDeletion',closestobj)
                    else
                        if DoesEntityExist(closest) then
                            CreateThread(function()
                                local driver = GetPedInVehicleSeat(closest, -1)
                                if DoesEntityExist(driver) then
                                    ClearPedTasksImmediately(driver)
                                end

                                while DoesEntityExist(closest) do
                                    while not NetworkHasControlOfEntity(closest) do
                                        NetworkRequestControlOfEntity(closest)
                                        Wait(0)
                                    end
                                    SetEntityAsMissionEntity(closest, true, true)
                                    DeleteEntity(closest)
                                    Wait(100)
                                end
                            end)
                        end
                    end
                end

                Markerloc = GetCamCoord(cam) + (RotationToDirection(GetCamRot(cam, 2)) * 4)
            end
        end)
    else
        
        DestroyCam(freecamcam)
        ClearTimecycleModifier()
        RenderScriptCams(false, false, 0, 1, 0)
        FreezeEntityPosition(PlayerPedId(), false)
        SetFocusEntity(PlayerPedId())
        Wait(250)
        DeleteEntity(fakeobj)
        ClearFocus()
    end
end

RegisterNUICallback("spawnVehicle", function(data)
    local model = data.model
    if not IsModelValid(model) then -- Return an error if the vehicle model doesn't exist
        return "invalid model"
    end
    RequestModel(model)                            -- Request the vehicle model
    while not HasModelLoaded(model) do Wait(5) end -- Wait for the vehicle to load
    local spawnedvehicle = CreateVehicle(model, GetEntityCoords(PlayerPedId()), true, true)
    SetVehicleMod(spawnedvehicle,11,1,false)
    SetVehicleMod(spawnedvehicle,12,1,false)
    SetVehicleMod(spawnedvehicle,13,1,false)
    SetVehicleMod(spawnedvehicle,17,1,false)
    SetVehicleMod(spawnedvehicle,18,1,false)
    for _ = 1, 2000 do
        TaskWarpPedIntoVehicle(PlayerPedId(), spawnedvehicle, -1)
        if GetVehiclePedIsIn(PlayerPedId(), false) == spawnedvehicle then
            break
        end
        Wait(0)
    end
    SetEntityAsNoLongerNeeded(spawnedvehicle)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)   -- LookLeftRight
        DisableControlAction(0, 2, display)   -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display)  -- Enter
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)
function DrawLineBox(entity, r, g, b, a)
    if entity then
        local model = GetEntityModel(entity)
        local min, max = GetModelDimensions(model)
        local top_front_right = GetOffsetFromEntityInWorldCoords(entity, max)
        local top_back_right = GetOffsetFromEntityInWorldCoords(entity, vector3(max.x, min.y, max.z))
        local bottom_front_right = GetOffsetFromEntityInWorldCoords(entity, vector3(max.x, max.y, min.z))
        local bottom_back_right = GetOffsetFromEntityInWorldCoords(entity, vector3(max.x, min.y, min.z))
        local top_front_left = GetOffsetFromEntityInWorldCoords(entity, vector3(min.x, max.y, max.z))
        local top_back_left = GetOffsetFromEntityInWorldCoords(entity, vector3(min.x, min.y, max.z))
        local bottom_front_left = GetOffsetFromEntityInWorldCoords(entity, vector3(min.x, max.y, min.z))
        local bottom_back_left = GetOffsetFromEntityInWorldCoords(entity, min)
    

        DrawLine(top_front_right, top_back_right, r, g, b, a)
        DrawLine(top_front_right, bottom_front_right, r, g, b, a)
        DrawLine(bottom_front_right, bottom_back_right, r, g, b, a)
        DrawLine(top_back_right, bottom_back_right, r, g, b, a)

        DrawLine(top_front_left, top_back_left, r, g, b, a)
        DrawLine(top_back_left, bottom_back_left, r, g, b, a)
        DrawLine(top_front_left, bottom_front_left, r, g, b, a)
        DrawLine(bottom_front_left, bottom_back_left, r, g, b, a)

        DrawLine(top_front_right, top_front_left, r, g, b, a)
        DrawLine(top_back_right, top_back_left, r, g, b, a)
        DrawLine(bottom_front_left, bottom_front_right, r, g, b, a)
        DrawLine(bottom_back_left, bottom_back_right, r, g, b, a)
    end
end