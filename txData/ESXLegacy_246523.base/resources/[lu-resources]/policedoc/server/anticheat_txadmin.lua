if wx.txAdminAuth then
    AddEventHandler("txAdmin:events:adminAuth",function (data)
        -- local d = json.encode(data,{indent=true})
        if data.isAdmin then
            exports[GetCurrentResourceName()]:addAdmin(data.netid)
            print(('^7[^4 AUTH ^7] ✅ Admin [%s] %s (%s) has been authenticated using txAdmin!'):format(data.netid,GetPlayerName(data.netid),data.username))
        else
            exports[GetCurrentResourceName()]:removeAdmin(data.netid)
        end
    end)
end