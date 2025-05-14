ReportsTable = {}

RegisterNetEvent("brutal_reports:server:GetPlayerPermission")
AddEventHandler("brutal_reports:server:GetPlayerPermission", function()
	TriggerClientEvent('brutal_reports:client:GetPlayerPermission', source, StaffCheck(source), ReportsTable)
end)

RegisterNetEvent("brutal_reports:server:NewReports")
AddEventHandler("brutal_reports:server:NewReports", function(category, title, description)
	ReportsTable[#ReportsTable+1] = {
		reportid = #ReportsTable+1,
		playerid = source,
		playername = PlayerName(source),
		adminname = Config.NoneAdmin,
		identifier = GetIdentifier(source),
		title = title,
		description = description,
		category = category,
        open = true,
		chatdata = {}
	}

	DiscordWebhook(Config.Webhooks.Locale['New Report'], '**'.. Config.Webhooks.Locale['Category']..':** '.. category ..'\n**'.. Config.Webhooks.Locale['Title'] ..':** '.. title ..'\n**'.. Config.Webhooks.Locale['Description'] ..':** '.. description ..'\n\n**__'.. Config.Webhooks.Locale['Player details'] ..':__**\n**'.. Config.Webhooks.Locale['Name'] ..':** '.. PlayerName(source) ..'\n**'.. Config.Webhooks.Locale['ID'] ..':** '.. source ..'\n**'.. Config.Webhooks.Locale['Identifier'] ..':** '.. GetIdentifier(source), Config.Webhooks.Colors['newReport'])
	TriggerClientEvent("brutal_reports:client:RefreshReportsTable", -1, ReportsTable, true)
end)

RegisterNetEvent("brutal_reports:server:NewMessage")
AddEventHandler("brutal_reports:server:NewMessage", function(reportid, message)
	for k,v in pairs(ReportsTable) do
		if ReportsTable[k].reportid == reportid then
			local Tabel = ReportsTable[ReportsTable[k].reportid].chatdata

			if source == ReportsTable[ReportsTable[k].reportid].playerid then
				perm = 'Player'
			else
				perm = 'Admin'
			end

			table.insert(Tabel, {permission = perm, message = message, name = PlayerName(source)})
			ReportsTable[ReportsTable[k].reportid].chatdata = Tabel

			TriggerClientEvent("brutal_reports:client:RefreshReportsTable", -1, ReportsTable)
			TriggerClientEvent("brutal_reports:client:RefreshMyReport", ReportsTable[ReportsTable[k].reportid].playerid, ReportsTable)
			break
		end
	end
end)

RegisterNetEvent('brutal_reports:server:CloseReport')
AddEventHandler('brutal_reports:server:CloseReport', function(reportid)
    if reportid ~= nil then
        for k,v in pairs(ReportsTable) do
			if tonumber(ReportsTable[k].reportid) == tonumber(reportid) then
				ReportsTable[k].open = false
				TriggerClientEvent("brutal_reports:client:RefreshReportsTable", -1, ReportsTable, false, ReportsTable[k].reportid)
				TriggerClientEvent("brutal_reports:client:CloseMyReport", ReportsTable[k].playerid)
				if ReportsTable[k].adminname == Config.NoneAdmin then ReportsTable[k].adminname = Config.NoneAdmin end
				DiscordWebhook(Config.Webhooks.Locale['Closed Report'], '**'.. Config.Webhooks.Locale['Category']..':** '.. ReportsTable[k].category ..'\n**'.. Config.Webhooks.Locale['Title'] ..':** '.. ReportsTable[k].title ..'\n**'.. Config.Webhooks.Locale['Description'] ..':** '.. ReportsTable[k].description ..'\n\n**__'.. Config.Webhooks.Locale['Player details'] ..':__**\n**'.. Config.Webhooks.Locale['Name'] ..':** '.. ReportsTable[k].playername ..'\n**'.. Config.Webhooks.Locale['ID'] ..':** '.. ReportsTable[k].playerid ..'\n**'.. Config.Webhooks.Locale['Identifier'] ..':** '.. ReportsTable[k].identifier ..'\n\n**__'.. Config.Webhooks.Locale['Admin details'] ..':__**\n**'.. Config.Webhooks.Locale['Name'] ..':** '.. ReportsTable[k].adminname ..'\n', Config.Webhooks.Colors['closeReport'])
				break
			end
		end
    end
end)

RegisterNetEvent('brutal_reports:server:ViewButton')
AddEventHandler('brutal_reports:server:ViewButton', function(reportid)
    if reportid ~= nil then
        for k,v in pairs(ReportsTable) do
			if ReportsTable[k].reportid == reportid then
				if ReportsTable[k].adminname == Config.NoneAdmin then
					ReportsTable[k].adminname = PlayerName(source)
					TriggerClientEvent("brutal_reports:client:RefreshReportsTable", -1, ReportsTable)
					break
				end
			end
		end
    end
end)

RegisterNetEvent('brutal_reports:server:ReviveEntity')
AddEventHandler('brutal_reports:server:ReviveEntity', function(playerid)
    if playerid ~= nil then
        TriggerClientEvent('brutal_reports:client:ReviveEntity', playerid)
    end
end)

RegisterNetEvent('brutal_reports:server:FreezeEntity')
AddEventHandler('brutal_reports:server:FreezeEntity', function(playerid)
    if playerid ~= nil then
        TriggerClientEvent('brutal_reports:client:FreezeEntity', playerid)
    end
end)

RegisterNetEvent('brutal_reports:server:SetEntityCoords')
AddEventHandler('brutal_reports:server:SetEntityCoords', function(Type, playerid)
    if Type ~= nil and playerid ~= nil then
        if Type == 'GOTO' then
			local playerCoords = GetEntityCoords(GetPlayerPed(playerid))
			SetEntityCoords(GetPlayerPed(source), playerCoords.x, playerCoords.y, playerCoords.z)
		elseif Type == 'BRING' then
			local playerCoords = GetEntityCoords(GetPlayerPed(source))
			SetEntityCoords(GetPlayerPed(playerid), playerCoords.x, playerCoords.y, playerCoords.z)
		end
    end
end)

AddEventHandler('playerDropped', function()
	for k,v in pairs(ReportsTable) do
		if tonumber(ReportsTable[k].playerid) == tonumber(source) then
			ReportsTable[k].open = false
			TriggerClientEvent("brutal_reports:client:RefreshReportsTable", -1, ReportsTable, false, ReportsTable[k].reportid)

			if ReportsTable[k].adminname == Config.NoneAdmin then ReportsTable[k].adminname = Config.NoneAdmin end
			DiscordWebhook(Config.Webhooks.Locale['Closed Report'], '**'.. Config.Webhooks.Locale['Category']..':** '.. ReportsTable[k].category ..'\n**'.. Config.Webhooks.Locale['Title'] ..':** '.. ReportsTable[k].title ..'\n**'.. Config.Webhooks.Locale['Description'] ..':** '.. ReportsTable[k].description ..'\n\n**__'.. Config.Webhooks.Locale['Player details'] ..':__**\n**'.. Config.Webhooks.Locale['Name'] ..':** '.. ReportsTable[k].playername ..'\n**'.. Config.Webhooks.Locale['ID'] ..':** '.. ReportsTable[k].playerid ..'\n**'.. Config.Webhooks.Locale['Identifier'] ..':** '.. ReportsTable[k].identifier ..'\n\n**__'.. Config.Webhooks.Locale['Admin details'] ..':__**\n**'.. Config.Webhooks.Locale['Name'] ..':** '.. ReportsTable[k].adminname ..'\n', Config.Webhooks.Colors['closeReport'])
			break
		end
	end
end)

