local banner =
    [[
                                                                                                                 
		^6?88   d8P  d8P    ?88,  88P^2             d888b8b       d8888b^7
		^6d88  d8P' d8P'     `?8bd8P'^2            d8P' ?88      d8P' `P^7
		^6?8b ,88b ,88'      d8P?8b, ^2            88b  ,88b     88b    ^7
		^6`?888P'888P'      d8P' `?8b^2            `?88P'`88b    `?888P'^7

				  ^4https://anticheat.0wx.space
				   ^5https://discord.0wx.space^7
																												   
]]
function CheckUpdates()
    Citizen.CreateThread(
            function()
                print("^7[^4 INFO ^7] Checking for updates...")
                local curVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
                PerformHttpRequest(
                    "https://raw.githubusercontent.com/nwvh/wx_anticheatUpdate/main/version.json",
                    function(code, res, headers)
                        if code == 200 then
                            local check = json.decode(res)
                            if check.version ~= curVersion then
                                print(
                                    ([[
^6
┬  ┌┐┌┌─┐┬ ┬  ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐  ┬
│  │││├┤ │││  │ │├─┘ ││├─┤ │ ├┤   │
o  ┘└┘└─┘└┴┘  └─┘┴  ─┴┘┴ ┴ ┴ └─┘  o        
^7
//
^6[[^7 New version of WX AntiCheat has been released!
^6[[^7 Your Version: ^1%s^7
^6[[^7 Latest Version: ^2%s^7
^6[[^7 What's new: ^2%s^7
^6[[^7 
^6[[^7 You should update as soon as possible to make sure your
^6[[^7 server is protected even more and to get the latest
^6[[^7 anticheat features! How do you update WX AntiCheat?
^6[[^7
^6[[^7 1. Go to https://keymaster.fivem.net/assets
^6[[^7 2. Locate WX AntiCheat and press DOWNLOAD
^6[[^7 3. Unzip the wx_anticheat.pack.zip archive
^6[[^7 4. Remove the old anticheat folder from your server
^6[[^7 5. Drag the new wx_anticheat folder to your resources folder
^6[[^7 6. Configure the anticheat to your liking and setup your webhooks
^6[[^7 7. (optional, but recommended) Rename the wx_anticheat folder to something less suspicious
^6[[^7 8. Restart your server!
\\
]]):format(
                                        curVersion,
                                        check.version,
                                        check.changelog
                                    )
                                )
                                if not check then
                                    print("^7[^1 ERROR ^7] Update check failed!")
                                end
                            else
                                print("^7[^4 INFO ^7] You are running the latest version of WX AntiCheat!")
                            end
                        else
                            print("^7[^1 ERROR ^7] Update check failed!")
                        end
                    end,
                    "GET"
                )
            end
        )
end


Citizen.Wait(1000)
print(banner)
CheckUpdates()
MySQL.query(
        "SELECT COUNT(*) FROM wx_anticheat",
        {},
        function(response)
            if response then
				BetterPrint(("Loaded ^4%s^7 bans from the database"):format(json.encode(response[1]["COUNT(*)"])),"info")
            end
        end
    )
function GetBannedPlayers()
    MySQL.query(
        "SELECT COUNT(*) FROM wx_anticheat",
        {},
        function(response)
            if response then
                print("^7[^4 INFO ^7] ^7Banned cheaters so far: ^3" .. json.encode(response[1]["COUNT(*)"]) .. "^7")
            end
        end
    )
end