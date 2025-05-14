RegisterNUICallback("UseButton", function(data)
	if data.action == "NewReport" then
		if HaveOpenReport == false then
			HaveOpenReport = true
			TriggerServerEvent('brutal_reports:server:NewReports', data.Report[1], data.Report[2], data.Report[3])
			Citizen.Wait(300)
			OpenReportMenu(true)
		end
	elseif data.action == "NewMessage" then
		TriggerServerEvent('brutal_reports:server:NewMessage', data.reportid, data.message)
		Citizen.Wait(300)
		OpenReportMenu(false)
	elseif data.action == "NewAdminMessage" then
		TriggerServerEvent('brutal_reports:server:NewMessage', data.reportid, data.message)
		Citizen.Wait(300)
		OpenAdminReportMenu(data.reportid)
	elseif data.action == "AdminButton" then
		if data.ButtonType == "goto" then
			TriggerServerEvent('brutal_reports:server:SetEntityCoords', 'GOTO', data.playerid)
		elseif data.ButtonType == "bring" then
			TriggerServerEvent('brutal_reports:server:SetEntityCoords', 'BRING', data.playerid)
		elseif data.ButtonType == "revive" then
			TriggerServerEvent('brutal_reports:server:ReviveEntity', data.playerid)
		elseif data.ButtonType == "freeze" then
			TriggerServerEvent('brutal_reports:server:FreezeEntity', data.playerid)
		end
	elseif data.action == "CloseReport" then
		Citizen.Wait(500)
		TriggerServerEvent('brutal_reports:server:CloseReport', data.reportid)
	elseif data.action == "ViewButton" then
		if data.reportid ~= nil and data.adminname == Config.NoneAdmin then
			TriggerServerEvent('brutal_reports:server:ViewButton', data.reportid)
		end
	elseif data.action == "Notify" then
		if data.notifyid ~= nil then
			SendNotify(data.notifyid)
		end
	elseif data.action == "close" then
		MenuOpen = false
		SetNuiFocus(false,false)
    end
end)