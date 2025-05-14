
freeze = false
MenuOpen = false
AdminNotify = true

function SendNotify(Number, Value)
    local Send = true
    if Value then
        if AdminNotify then
            Send = true
        else
            Send = false
        end
    end

    if Send then
        notification(Config.Notify[Number][1], Config.Notify[Number][2], Config.Notify[Number][3], Config.Notify[Number][4])
    end
end

-- Player Command
TriggerEvent('chat:addSuggestion', '/'.. Config.ReportMenu.Command ..'', Config.ReportMenu.CommandLabel)
RegisterCommand(Config.ReportMenu.Command, function(source, args, rawCommand)
    MenuOpen = true
    OpenReportMenu(true)
end)

-- Admin Command
TriggerEvent('chat:addSuggestion', '/'.. Config.AdminMenu.Command ..'', Config.AdminMenu.CommandLabel)
RegisterCommand(Config.AdminMenu.Command, function(source, args, rawCommand)
    if staff then
        SetNuiFocus(true,true)
        SendNUIMessage({action = "OpenAdminReports", ReportsTable = ReportsTable, MyID = GetPlayerServerId(PlayerId())})
    else SendNotify(2) end
end)

-- Turn off the notifys
TriggerEvent('chat:addSuggestion', '/'.. Config.AdminNotify.Command ..'', Config.AdminNotify.CommandLabel)
RegisterCommand(Config.AdminNotify.Command, function(source, args, rawCommand)
    if staff then
        if AdminNotify == false then
            AdminNotify = true
            SendNotify(10)
        else
            SendNotify(9)
            AdminNotify = false
        end
    else SendNotify(2) end
end)

-------------------------------------
Citizen.CreateThread(function()
    if LoadedEvent ~= nil then
        RegisterNetEvent(LoadedEvent)
        AddEventHandler(LoadedEvent, function()
            GetData()
        end)
    else
        Citizen.CreateThread(function()
            Citizen.Wait(PlayerLoadedTime)
            GetData()
        end)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        GetData()
    end
end)

function GetData()
    TriggerServerEvent('brutal_reports:server:GetPlayerPermission')
end

RegisterNetEvent('brutal_reports:client:GetPlayerPermission')
AddEventHandler('brutal_reports:client:GetPlayerPermission', function(PlayerPerm, NewReportsTable)
    if PlayerPerm ~= nil then
        staff = PlayerPerm
        ReportsTable = NewReportsTable
    else
        staff = false
    end
end)

-------------------------------------

ReportsTable = {}
HaveOpenReport = false

RegisterNetEvent('brutal_reports:client:RefreshReportsTable')
AddEventHandler('brutal_reports:client:RefreshReportsTable', function(NewReportsTable, NewReport, reportid)
	if staff then
        if NewReport then
            SendNotify(7, true)
        elseif NewReport == false and reportid ~= nil then -- Close report
            if AdminNotify then
                notification(Config.Notify[8][1], Config.Report..''.. reportid ..' '..Config.Notify[8][2], Config.Notify[8][3], Config.Notify[8][4])
            end
        end

		ReportsTable = NewReportsTable
		SendNUIMessage({
			action = "ReportsTableUpdate",
			ReportsTable = ReportsTable
		})
	end
end)

function OpenReportMenu(value)
    if HaveOpenReport == false then
        SetNuiFocus(true,true)
        SendNUIMessage({action = "OpenReportMenu"})
    else
        local MyReport = nil
        for k, v in pairs(ReportsTable) do
            if v.playerid == GetPlayerServerId(PlayerId()) then
                MyReport = v
            end
        end
        if MyReport ~= nil then

            if value then
            SetNuiFocus(true,true)
            end

            SendNUIMessage({action = "OpenMyReport", MyReport = MyReport, NeedOpen = value})
        end
    end
end

function OpenAdminReportMenu(reportid)
    SetNuiFocus(true,true)
    SendNUIMessage({action = "OpenAdminReport", reportid = reportid, ReportsTable = ReportsTable})
end

RegisterNetEvent('brutal_reports:client:CloseMyReport')
AddEventHandler('brutal_reports:client:CloseMyReport', function()
    SendNUIMessage({action = "ClearMyReport"})
    SendNotify(3)
	HaveOpenReport = false
end)

RegisterNetEvent('brutal_reports:client:RefreshMyReport')
AddEventHandler('brutal_reports:client:RefreshMyReport', function(NewReportsTable)
    ReportsTable = NewReportsTable
    if MenuOpen == false then SendNotify(1) end
    OpenReportMenu(false)
end)

RegisterNetEvent('brutal_reports:client:ReviveEntity')
AddEventHandler('brutal_reports:client:ReviveEntity', function(playerid)
    SendNotify(6)
    if ReviveEvent ~= nil then
        TriggerEvent(ReviveEvent) -- Revive event
    else
        SetEntityHealth(GetPlayerPed(-1), 200)
    end
end)

RegisterNetEvent('brutal_reports:client:FreezeEntity')
AddEventHandler('brutal_reports:client:FreezeEntity', function(playerid)
    local player = PlayerId()
	local ped = PlayerPedId()
    
    if freeze == false then
        freeze = true
        SendNotify(4)
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
    elseif freeze then
        freeze = false
        SendNotify(5)
        SetEntityCollision(ped, true)
        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    end
end)

---------------------------------------------------
-------------- NOT RENAME THE SCRIPT --------------
---------------------------------------------------

Citizen.CreateThread(function()
	Citizen.Wait(1000*30)
	if GetCurrentResourceName() ~= 'brutal_reports' then
		while true do
			Citizen.Wait(1)
			print("Please don't rename the script! Please rename it back to 'brutal_reports'")
		end
	end
end)