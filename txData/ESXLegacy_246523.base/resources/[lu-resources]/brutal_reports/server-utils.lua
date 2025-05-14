local YourWebhook = 'WEBHOOK-HERE'  -- help: https://docs.brutalscripts.com/site/others/discord-webhook

function GetWebhook()
    return YourWebhook
end

---------------------------------------------------

if Config.Core:upper() == 'ESX' then
    Core = exports['es_extended']:getSharedObject()
elseif Config.Core:upper() == 'QBCORE' then
    Core = exports['qb-core']:GetCoreObject()
end

function PlayerName(source)
    return GetPlayerName(source)
end

function StaffCheck(source)
    local staff = false

    if Config.Core:upper() == 'ESX' and Config.IdentifierPermission ~= true then
        local player = Core.GetPlayerFromId(source)
        local playerGroup = player.getGroup()

        for i, Group in ipairs(Config.AdminGroups) do
            if playerGroup == Group then
                staff = true
                break
            end
        end
    elseif Config.Core:upper() == 'QBCORE' and Config.IdentifierPermission ~= true then
            local player = Core.Functions.GetPlayer(source)
    
            for i, Group in ipairs(Config.AdminGroups) do
                if Core.Functions.HasPermission(source, Group) then
                    staff = true
                    break
                end
            end
    elseif Config.IdentifierPermission or Config.Core:upper() == 'STANDALONE' then
        for i, a in ipairs(Config.Admins) do
            for x, b in ipairs(GetPlayerIdentifiers(source)) do
                if string.lower(b) == string.lower(a) then
                    staff = true
                    break
                end
            end
        end
    end

    return staff
end

function GetIdentifier(source)
    local identifiers = {}
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        end
    end

    if Config.IdentifierType:lower() == 'steam' then
        identifier = identifiers.steam
    elseif Config.IdentifierType:lower() == 'license' then
        identifier = identifiers.license
    elseif Config.IdentifierType:lower() == 'discord' then
        identifier = identifiers.discord
    elseif Config.IdentifierType:lower() == 'core' then
        if Config.Core:upper() == 'ESX' then
            identifier = Core.GetPlayerFromId(source).identifier
        elseif Config.Core:upper() == 'QBCORE' then
            identifier = Core.Functions.GetPlayer(source).PlayerData.citizenid
        else
            identifier = identifiers.steam
        end
    else
        identifier = identifiers.steam
    end

    return identifier
end