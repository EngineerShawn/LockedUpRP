wx = {}

-- PLEASE DO NOT LEAVE THIS CONFIG FILE AS IT IS!
-- EVERY SERVER IS NOT CONFIGURED THE SAME

-- ┌─┐┌┐┌┌┬┐┬┌─┐┬ ┬┌─┐┌─┐┌┬┐  ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐
-- ├─┤│││ │ ││  ├─┤├┤ ├─┤ │   └─┐├┤  │  │ │││││ ┬└─┐
-- ┴ ┴┘└┘ ┴ ┴└─┘┴ ┴└─┘┴ ┴ ┴   └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘

wx.Debug = false                                    -- Admins can be detected. Players are able to be detected more than once. Do NOT use in production
wx.txAdminAuth = true                              -- Enable support for admin checking via txAdmin
wx.screenshotModule = "screenshot-basic"           -- Change this if you renamed your sc-basic resource (Make sure it matches). Or keep disabled if you don't want to use screenshots
wx.banIDFormat = 1                                 -- 1 = ABCD-1234 (DEFAULT) | 2 = #1234 (NEW)

wx.HeartBeat = {                                   -- HeartBeat settings, leave as it is, unless something is not working!
    enabled = true,                                -- (RECOMMENDED TO TURN ON) Enable Heartbeat system, the anticheat will check if player is responding on the client, prevents stopping the anticheat
    maxTime = 15,                                  -- If the server doesn't receive any response from the client in X secs, disconnect him
}

wx.AdminMenu = {
    enable = true,                                  -- Enable NUI admin menu for your registered admins (/wx)
    backgroundBlur = true,                          -- Blur background when the admin menu is opened
    espSelf = true,                                 -- See yourself on ESP options
    espMaxDist = 1000.0,                            -- Maximum distance for ESP to draw
    rgb = {255,255,255}                                  -- RGB values for color rendering
}

wx.Prefix = 'WX AntiCheat'                          -- You can rename the anticheat, this prefix will be in chat messages or when being punished
wx.punishType = 'LOG'                               -- (LOG/KICK/BAN) | LOG (Will only send the log) | KICK (Will only kick the player and send the log) | BAN (Will ban the player and send the log)
wx.showReason = true                                -- Should banned players be able to see the reason for being banned?
wx.appealDiscord = 'https://discord.gg/yourdiscord' -- Your Discord link (MUST BE A URL)
wx.pingOnDetect = false                             -- Set this to true if you want to enable discord @everyone pings on new detections
wx.chatMessages = true                              -- Set this to true if you want to send chat message on new detection including cheater's name and reason. (Everyone will see this message). Great for debugging
wx.screenshots = true                               -- Enables sending screenshots of player's screen to your webhook.
wx.adminDetections = false                          -- Send webhook if an admin gets detected?
wx.OCR = true                                       -- On Screen Detection - Once in a while the script will take screenshot from every player and search it for any suspicious words (mod menus)
wx.OCRCheckInterval = 15000                         -- In ms, how often should the anticheat check player's screen? Lower values = Faster checks = Higher lag spikes. Recommended to keep at default value (15000)
wx.spoilerIP = true                                 -- Add IP addresses into spoiler tag in discord logs?
wx.maxUsernameLength = 16                           -- Maximum username length player can have. Set to -1 to disable
wx.antiAFK = false                                  -- Enables checking if player is AFK
wx.antiAFKtime = 1200                               -- In seconds, how long player needs to be afk before getting kicked
wx.needDiscord = true                               -- Player can(not) join with(out) discord identifier

wx.DetectionPunishments = {                         -- You can set different punish method for these detections.
-- ["donttouch"] = "BAN/KICK/LOG"
    ["noclip"] = "BAN",         -- No-Clip Detection (wx.antiNoClip)
    ["freecam"] = "LOG",        -- Freecam Detection (wx.antiFreeCam)
    ["godmode"] = "LOG",        -- GodMode Detection (wx.antiGodMode)
    ["fastrun"] = "KICK",       -- FastRun Detection (wx.antiFastRun)
    ["teleport"] = "LOG",       -- Teleport Detection (wx.antiTeleport)
    ["blips"] = "LOG",          -- Blips Detection (wx.antiBlips)
    ["invisibility"] = "LOG",   -- Invisibility Detection (wx.antiInvisible)
}

wx.connectingCard = {                               -- If enabled, players will see "Connecting..." text while connecting. You can translate it in the locale file
    enabled = true,
    length = 3200 -- in ms, how long should the card be shown to connecting players
}

wx.whitelistedResources = { -- Starting/Stopping these resources will have no effect on resource start/stop detections.
    ['es_extended'] = true,
}


-- ┌─┐┬  ┬┌─┐┌┐┌┌┬┐  ┌┬┐┌─┐┌┬┐┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
-- │  │  │├┤ │││ │    ││├┤  │ ├┤ │   │ ││ ││││└─┐
-- └─┘┴─┘┴└─┘┘└┘ ┴   ─┴┘└─┘ ┴ └─┘└─┘ ┴ ┴└─┘┘└┘└─┘

wx.antiNUIDevTools = true               -- Detects nui_devtools ingame
wx.antiResourceStop = true              -- Anti resource stop - If true, do NOT ensure resources on live server - it will ban everyone
wx.antiResourceStart = true             -- Anti resource start - If true, do NOT ensure resources on live server - it will ban everyone
wx.antiClearTasks = true                -- Detects kicking other players from cars etc.
wx.antiGiveWeapons = true               -- Detects giving weapons
wx.antiRemoveWeapons = true             -- Detects removing weapons
wx.messageBlacklist = true              -- Kicks player for blacklisted words in chat
wx.antiHeadshot = true                  -- Disables headshot one taps
wx.antiBlacklistPlate = true            -- Detects blacklisted vehicle plates (Blacklist is below)
wx.antiPlateChange = true               -- Detects if player changes his vehicle plate (Can cause problems with vehicle shops)
wx.antiObjectAttach = true              -- Deletes all objects that are attached to players
wx.antiFastRun = true                   -- Detects fast run
wx.antiTeleport = true                  -- Detects if player is far away from his last position (teleporting)
wx.antiOverlay = true                   -- Detects Mouse UI overlays (like eulen)
wx.antiMagicBullet = true               -- Detects magic bullet cheats (Shooting through walls)
wx.antiBlacklistedWeapon = true         -- Detects if player has weapon on blacklist
wx.antiBlacklistedVehicles = true       -- Detects if player is in blacklisted vehicle
wx.antiGodMode = true                   -- Detects god mode
wx.antiNoClip = true                    -- Detects players noclipping
wx.antiRapidFire = true                 -- Detects abnormally fast shooting
wx.antiTaze = true                      -- Prevents cheaters from tazing other players
wx.antiInfiniteRoll = true              -- Detects infinite combat roll
wx.antiWeaponVehicles = true            -- Prevents cheaters from using vehicles with built-in weapons (oppressor, nightshark etc.)
wx.antiRadar = false                    -- Detects if player has radar without being in any vehicle
wx.antiAIs = true                       -- Anti citizen AIs like No Recoil, Give all weapons, Boost Damage etc.
wx.antiMenus = true                     -- Anti LUA Menus - This is significantly faster than OCR, because it only detects the most basic menus
wx.antiFreeCam = true                   -- Anti FreeCam Hack
wx.antiSmallPed = true                  -- Anti small/tiny ped
wx.antiInvisible = true                 -- Anti Invisible Player
wx.antiSilentAim = true                 -- Detects bigger hitboxes (x64a.rpf)
wx.antiVDM = true                       -- Vehicles will do ZERO damage to players
wx.antiDamageBoost = true               -- Detects Citizen AIs and mods for boosted damage
wx.antiDefenseBoost = true              -- Detects Citizen AIs and mods for boosted defense
wx.antiInfiniteStamina = true           -- Detects infinite stamina mods/cheats/ais
wx.antiSuperJump = true                 -- Detects Super Jump cheat
wx.antiBlips = true                     -- Detects player blips cheat (See other players on map) - Disable if you're using any police blips script
wx.antiSpectate = true                  -- Detects if player tries to spectate other players
wx.fakeTriggers = true                  -- Fake triggers that will pop-up in mod menus and executors
wx.antiExplosiveAmmo = true             -- Detects explosive ammo
wx.antiInfiniteAmmo = true              -- Anti infinite ammo in clip
wx.antiThermal = true                   -- Anti Thermal Vision (Has bypass for players in helicopters)
wx.antiNightVision = true               -- Anti Night Vision
wx.antiRainbow = true                   -- Anti rainbow vehicle (Can cause problem with vehicle tuning)

-- ┌─┐┌─┐┬─┐┬  ┬┌─┐┬─┐  ┌┬┐┌─┐┌┬┐┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
-- └─┐├┤ ├┬┘└┐┌┘├┤ ├┬┘   ││├┤  │ ├┤ │   │ ││ ││││└─┐
-- └─┘└─┘┴└─ └┘ └─┘┴└─  ─┴┘└─┘ ┴ └─┘└─┘ ┴ ┴└─┘┘└┘└─┘

wx.antiBlacklistedVehiclesSpawn = true -- Detects if player spawns blacklisted vehicle (make sure to test the log mode to prevent false bans! it counts enviromental vehicles that spawned around him (like blimp))
wx.antiSpamPed = true                  -- Detects mass spawning of peds
wx.antiSpamVehicle = true              -- Detects mass spawning of vehicles
wx.antiSpamObject = true               -- Detects mass spawning of objects
wx.antiParticles = true                -- Detection of blacklisted particles
wx.antiExplosion = true                -- Blacklisted explosions
wx.cancelOtherExplosions = true        -- If an explosion type isn't on blacklist, it will get cancelled
wx.antiExplosionMods = true            -- Detects invisible, inaudible and damage boosted explosions
wx.antiObjects = true                  -- Detects creation of blacklisted objects and props
wx.antiPeds = true                     -- Detects creation of blacklisted peds
wx.explosionLimit = true               -- If true, player can only create a set amount of explosions in a specified time below before getting detected

wx.maxExplosionsInterval = 10000 -- In miliseconds. Player will get detected if he creates X explosions in X miliseconds
wx.maxExplosions = 15            -- Maximum explosions player can create in short time before getting detected
wx.maxVehicle = 8                -- Maximum vehicles player can create in short time before getting detected
wx.maxObject = 5                 -- Maximum vehicles player can create in short time before getting detected
wx.maxPed = 5                    -- Maximum vehicles player can create in short time before getting detected
wx.freecamDistance = 45          -- How far the camera has to be from player to trigger freecam detection.
wx.maxCreatingSpeed = 80         -- Stops spawning vehicles with large speeds (eg. Ram Player option in mod menus)
wx.teleportDistance = 300        -- How far player needs to be from his last location in short time to be detected?
wx.maximumModifier = 1.15        -- FLOAT VALUE! (0.0) - Minimum allowed damage/defense modifier before getting detected


-- ┬    ┌─┐  ┌─┐  ┌─┐  ┬  ┌┐┌  ┌─┐
-- │    │ │  │ ┬  │ ┬  │  │││  │ ┬
-- ┴─┘  └─┘  └─┘  └─┘  ┴  ┘└┘  └─┘
wx.connectPrints = true       -- Prints player connecting (Detects HARDCAP)
wx.connectLogs = true         -- Logs players connecting
wx.disconnectLogs = true      -- Logs player disconnecting
wx.ExplosionLogs = true       -- Logs explosions
wx.ObjectLogs = true          -- Logs created objects
wx.ChatLogs = true            -- Logs chat messages
wx.ResourceStartLogs = true   -- Logs resource start
wx.ResourceStopLogs = true    -- Logs resource stop

-- ┌┐ ┬  ┌─┐┌─┐┬┌─┬  ┬┌─┐┌┬┐┌─┐   ┌┬┐┌─┐┌┐ ┬  ┌─┐┌─┐  ┌─┐┌┐┌┌┬┐  ┌─┐┌┬┐┬ ┬┌─┐┬─┐  ┬  ┬┌─┐┌┬┐┌─┐
-- ├┴┐│  ├─┤│  ├┴┐│  │└─┐ │ └─┐    │ ├─┤├┴┐│  ├┤ └─┐  ├─┤│││ ││  │ │ │ ├─┤├┤ ├┬┘  │  │└─┐ │ └─┐
-- └─┘┴─┘┴ ┴└─┘┴ ┴┴─┘┴└─┘ ┴ └─┘┘   ┴ ┴ ┴└─┘┴─┘└─┘└─┘  ┴ ┴┘└┘─┴┘  └─┘ ┴ ┴ ┴└─┘┴└─  ┴─┘┴└─┘ ┴ └─┘

-- If any of these words are found on player's screen with OCR, he will get detected
-- OCR scans only native strings, like menus, pause menu or 3D/2D text, NUI elements (like chat) won't apply
wx.OCRWords = {
    "FlexSkazaMenu", "SidMenu", "Lynx8",
    "LynxEvo", "Maestro Menu", "redEngine",
    "HamMafia", "HamHaxia", "Dopameme",
    "redMENU", "Desudo", "explode",
    "gamesense", "Anticheat", "Tapatio",
    "Malossi", "RedStonia", "Chocohax",
    "skin changer", "torque multiple", "override player speed",
    "colision proof", "explosion proof", "copy outfit",
    "play single particle", "infinite ammo", "rip server",
    "remove ammo", "remove all weapons", "V1s_u4l",
    "injected", "Explode Players", "Ram Player",
    "fallout", "godmode", "god mode",
    "modmenu", "esx money", "give armor",
    "aimbot", "trigger", "triggerbot",
    "Rapid Fire","rage bot","ragebot",
    "rapidfire", "freecam", "execute",
    "noclip", "ckgangisontop", "lumia1",
    "ISMMENU", "TAJNEMENUMenu", "rootMenu",
    "Outcasts666", "WaveCheat", "NacroxMenu",
    "MarketMenu", "topMenu", "Flip Vehicle",
    "Rainbow Paintjob", "Combat Assiters", "Damage Multiplier",
    "Give All Weapons", "Teleport To Impact", "Explosive Impact",
    "Server Nuke Options", "No Ragdoll", "Super Powers",
    "invisible all vehicles", "Spam Message", "Destroy Map",
    "Delete Props", "Cobra Menu",
    "no-clip", "injected", "Money Options",
    "Nuke Options", "Aimbot", "TriggerBot",
    "RapidFire","Force Player Blips","Force Radar",
    "Force Gamertags","Steal Outfit","ESX Money Options",
    "press AV PAG","TP to Waypoint","Self Options",
    "Vehicle options","Weapon Options","spam Vehicles",
    "taze All","explosive ammo","super damage",
    "rapid fire","Super Jump","Infinite Roll",
    "Cage Player","Give all","No Criticals",
    "Move On Water","Disable Ragdoll","CutzuSD",
    "Vertisso","fuck server","lynx",
    "Teleport to Closest Vehicle","CKGang","CK Gang",
    "CKGang 2.0","ESP","Toggle ESP",
    "NoClip","No-Clip","Semi-GodMode",
    "Repair Vehicle","Fix Vehicle","absolute",
    "Lumia","Gamesense","Fivesense",
    "SkidMenu","Dopamine","Explode",
    "Teleport Options","infnite combat roll","Hydro Menu",
    "Enter Menu Open Key","Give Single Weapon","Airstrike Player",
    "Taze Player","Razer Menu","Swagamine",
    "Visual Options","d0pamine","Infinite Stamina",
    "Blackout","Delete Vehicles Within Radius","Engine Power Boost",
    "Teleport Into Player's Vehicle","menu keybind",
    "nospread","transparent props","bullet tracers",
    "Dumper","LUA Executor","Executor",
    "Lux Menu","NEVERWHERE","Event Blocker",
    "Spectate","Wallhack","triggers",
    "crosshair","Alokas66","Hacking System!",
    "Destroy Menu","Server IP","Teleport To"
}

-- [ Blacklisted Weapons ]
wx.Weapons = {
    --  TRANSLATION/LABEL    INGAME MODEL NAME
    ['Heavy Sniper'] = 'weapon_heavysniper',
    ['Sniper Rifle'] = "weapon_sniperrifle",
    ['Minigun'] = "weapon_minigun",
    ['Heavy Rifle'] = "weapon_heavyrifle",
    ['Heavy Sniper MK2'] = "weapon_heavysniper_mk2",
    ['Marksman Rifle'] = "weapon_marksmanrifle",
    ['Marksman Rifle MK2'] = "weapon_marksmanrifle_mk2",
    ['RPG'] = "weapon_rpg",
    ['Grenade Launcher'] = "weapon_granadelauncher",
    ['Navy Revolver'] = "weapon_navyrevolver",
    ['Double Action Revolver'] = "weapon_doubleaction",
    ['Flare Gun'] = "weapon_flaregun",
    ['Vintage Pistol'] = "weapon_vintagepistol",
    ['Taser'] = "weapon_stungun",
    ['Marksman Pistol'] = "weapon_marksmanpistol",
    ['Gadget Pistol'] = "weapon_gadgetpistol",
    ['Pistol MK2'] = "weapon_pistol_mk2",
    ['Bottle'] = "weapon_bottle",
    ['Stone Hatchet'] = "weapon_stone_hatchet",
    ['Flare'] = "weapon_flare",
    ['Snowball'] = "weapon_snowball",
    ['Gas Canister'] = "weapon_petrolcan",
    ['Parachute'] = "gadget_parachute",
    ['Hazard Canister'] = "weapon_hazardcan",
    ['Fertilizer Can'] = "weapon_fertilizercan",
    ['EMP Launcher'] = "weapon_emplauncher",
    ['Machine Gun'] = "weapon_mg",
    ['SNS Pistol'] = "weapon_snspistol",
    ['SNS Pistol MK2'] = "weapon_snspistol_mk2",
    ['Nightstick'] = "weapon_nightstick",
    ['Ray Pistol'] = "weapon_raypistol",
    ['Ray Carbine'] = "weapon_raycarbine",
    ['Combat MG'] = "weapon_combatmg",
    ['Combat MG MK2'] = "weapon_combatmg_mk2",
    ['SMG MK2'] = "weapon_smg_mk2",
    ['Revolver MK2'] = "weapon_revolver_mk2",
    ['RPG 2'] = "weapon_rpg_2",
    ['Smoke Launcher'] = "weapon_grenadelauncher_smoke",
    ['Firework Launcher'] = "weapon_firework",
    ['Railgun'] = "weapon_railgun",
    ['Homing Launcher'] = "weapon_hominglauncher",
    ['Compact Launcher'] = "weapon_compactlauncher",
    ['Ray Minigun'] = "weapon_rayminigun",
    ['Grenade'] = "weapon_grenade",
    ['BZ Gas'] = "weapon_bzgas",
    ['Molotov'] = "weapon_molotov",
    ['Sticky Bomb'] = "weapon_stickybomb",
    ['Pipe Bomb'] = "weapon_pipebomb",
    ['Proximity Mine'] = "weapon_proxmine"
}

-- [ Blacklists (I recommend you to read through it and edit it) ]
wx.Plates = { -- Blacklisted vehicle plates
    'nigger',
    'nigga',
    'faggot',
    'retard',
    'ownage',
    'owned',
    'ckgang',
    'skriptgg',
    'eulen',
    'fatality'
}

wx.TaskList = { -- Blacklisted tasks https://alloc8or.re/gta5/doc/enums/eTaskTypeIndex.txt
    100,
    101,
    151,
    221,
    222
}

wx.clipSize = { -- How many bullets should be allowed in certain weapons?
    { weapon = 'WEAPON_PISTOL',           clip = 14 },
    { weapon = 'WEAPON_APPISTOL',         clip = 18 },
    { weapon = 'WEAPON_COMBATPISTOL',     clip = 24 },
    { weapon = 'WEAPON_CARBINERIFLE',     clip = 60 },
    { weapon = 'WEAPON_CARBINERIFLE_MK2', clip = 60 },
}

-- [ Blacklisted Assets ]
wx.Assets = { GetHashKey("core"), GetHashKey("scr_ba_bomb"), GetHashKey("scr_rcbarry2"), GetHashKey("scr_rcpaparazzo1") }

-- [ Blacklisted Particles ]
wx.Particles = {
    GetHashKey("scr_firework_xmas_burst_rgw"),
    GetHashKey("exp_grd_petrol_pump"),
    GetHashKey("scr_clown_bul"),
    GetHashKey("scr_mich4_firework_trailburst_spawn"),
    GetHashKey("blood_shark_attack"),
    GetHashKey("td_blood_shotgun"),
    GetHashKey("td_blood_throat"),
    GetHashKey("blood_melee_punch"),
    GetHashKey("blood_exit"),
    GetHashKey("blood_chopper"),
    GetHashKey("trail_splash_blood"),
    GetHashKey("td_blood_stab"),
    GetHashKey("blood_armour_heavy"),
    GetHashKey("blood_mist"),
    GetHashKey("blood_nose"),
    GetHashKey("blood_entry_head_sniper"),
    GetHashKey("scr_ba_bomb_destroy"),
    GetHashKey("scr_clown_appears")
}

wx.TriggerValues = {            -- Player will be detected when he triggers one of these events with higher value than specified
    ['esx_truckerjob:payout'] = 5000,
    ['esx_garbagejob:payout'] = -1, -- Set to "-1" to detect every value
    ['esx_poolcleaner:payout'] = 5000,
    ['esx_godirtyjob:payout'] = 5000,
    ['esx_vehicleshop:resellVehicle'] = 500000,
}

-- [ Blacklisted/Fake Triggers ]
wx.triggerList = {
    -- type = 'client' = TriggerEvent
    -- type = 'server' = TriggerServerEvent

    -- ["esx_ambulancejob:revive"] = { type = "client" },

    ["esx:spawnVehicle"] = { type = "client" },
    ["esx:setgroup"] = { type = "client" },

    ["esx_garbagejob:payout"] = { type = "server" },
    ["esx_pizzajob:payout"] = { type = "server" },
    ["esx_truckerjob:payout"] = { type = "server" },
    ["AdminMenu:giveCash"] = { type = "server" },
    ["bank:deposit"] = { type = "server" },
    ["bank:withdraw"] = { type = "server" },
    ["esx_carthief:pay"] = { type = "server" },
    ["esx_gopostaljob:pay"] = { type = "server" },
    ["esx-qalle-jail:jailPlayer"] = { type = "server" },
    ["NB:recruterplayer"] = { type = "server" },
    ["paramedic:revive"] = { type = "server" },
    ["esx_jobs:caution"] = { type = "server" },
}


-- [ Blacklisted Names ]
wx.badNames = {
    "nigga",
    "nigger",
    "n1gger",
    "n1gg3r",
    "admin",
    "moderator",
    "owner",
    "coowner",
    "faggot",
    "kys",
    "retard",
    --[[ PREVENTS XSS INJECTION ]] "<script",
    --[[ PREVENTS XSS INJECTION ]] "<script src",
    --[[ PREVENTS XSS INJECTION ]] "<script src=",
    --[[ PREVENTS XSS INJECTION ]] "<script src =",
    --[[ PREVENTS XSS INJECTION ]] "<src =",
    --[[ PREVENTS XSS INJECTION ]] "<script>",
    --[[ PREVENTS XSS INJECTION ]] "/>",
    "moderator",
    "eulencheats",
    "eulen",
    'redengine',
    'susano',
    "lynxmenu",
    "atgmenu",
    "hacker",
    "rustchance.com",
    "rustchance",
    "hellcase.com",
    "hellcase",
    "youtube.com",
    "youtu.be",
    "youtube",
    "twitch.tv",
    "twitch",
    "chocohax",
    "https",
    "http",
    "www.",
    "?",
    "§",
    "pornhub.com",
    "porn",
    "pornhub",
}

-- [ Blacklisted chat messages ]
wx.blockedWords = {
    'negre',
    'negr',
    'nigga',
    'nigger',
    'niggers',
    'i hate niggers',
    'nate higgers',
    'retard',
    'faggots',
    'faggot',
    'kys'
}

-- [ Blacklisted Vehicles ]
wx.vehicleBlacklist = {
    ["oppressor"] = true,
    ["oppressor2"] = true,
    ["hydra"] = true,
    ["lazer"] = true,
    ["rhino"] = true,
    ["valkyrie"] = true,
    ["apc"] = true,
    ["barracks"] = true,
    ["minitank"] = true,
    ["barrage"] = true,
    ["chernobog"] = true,
    ["halftrack"] = true,
    ["khanjali"] = true,
    ["scarab"] = true,
    ["scarab2"] = true,
    ["scarab3"] = true,
    ["deluxo"] = true,
    ["thruster"] = true,
    ["trailersmall2"] = true,
    ["deathbike2"] = true,
    ["deathbike3"] = true,
    ["shotaro"] = true,
    ["dominator4"] = true,
    ["dominator5"] = true,
    ["dominator6"] = true,
    ["slamtruck"] = true,
}

-- [ Blacklisted Peds Models to spawn/use ]
wx.pedBlacklist = {
    "a_c_dolphin",
    "a_c_killerwhale",
    "a_c_sharktiger",
    "a_c_humpback",
    "mp_m_niko_01",
    's_m_y_swat_01',
    'u_m_y_pogo_01',
    "player_one",
    "player_two",
    "u_m_m_jesus_01",
    "u_m_y_babyd",
    "u_m_y_zombie_01",
    "u_m_y_pogo_0",
    "s_m_y_clown_01",
    "mp_f_cocaine_01",
    "a_c_chimp",
    "u_m_y_juggernaut_01"
}



-- [ Blacklisted objects ]
wx.objectBlacklist = {
    "prop_doghouse_01", -- Trap player from susano.re
    "ap1_lod_slod4",
    "cs4_lod_01_slod3",
    "p_spinning_anus_s",
    "sr_prop_stunt_tube_crn_15d_05a",
    "as_prop_as_dwslope30",
    "prop_carjack",
    "p_amb_brolly_01",
    "stt_prop_stunt_track_uturn",
    "stt_prop_stunt_track_turnice",
    "stt_prop_stunt_track_hill",
    "prop_gold_cont_01",
    "p_cablecar_s",
    "stt_prop_stunt_tube_l",
    "stt_prop_stunt_track_dwuturn",
    "prop_fnclink_05crnr1",
    "xs_prop_hamburgher_wl",
    "xs_prop_plastic_bottle_wl",
    "prop_windmill_01",
    "p_spinning_anus_s",
    "stt_prop_ramp_adj_flip_m",
    "stt_prop_ramp_adj_flip_mb",
    "stt_prop_ramp_adj_flip_s",
    "stt_prop_ramp_adj_flip_sb",
    "stt_prop_ramp_adj_hloop",
    "stt_prop_ramp_adj_loop",
    "stt_prop_ramp_jump_l",
    "stt_prop_ramp_jump_m",
    "stt_prop_ramp_jump_s",
    "stt_prop_ramp_jump_xl",
    "stt_prop_ramp_jump_xs",
    "stt_prop_ramp_jump_xxl",
    "stt_prop_ramp_multi_loop_rb",
    "stt_prop_ramp_spiral_l",
    "stt_prop_ramp_spiral_l_l",
    "stt_prop_ramp_spiral_l_m",
    "stt_prop_ramp_spiral_l_s",
    "stt_prop_ramp_spiral_l_xxl",
    "stt_prop_ramp_spiral_m",
    "stt_prop_ramp_spiral_s",
    "stt_prop_ramp_spiral_xxl",
    "stt_prop_stunt_track_dwslope30",
    "stt_prop_stunt_track_start",
    "stt_prop_stunt_track_slope45",
    "stt_prop_stunt_track_slope30",
    "stt_prop_stunt_track_slope15",
    "stt_prop_stunt_track_short",
    "stt_prop_stunt_track_sh45_a",
    "stt_prop_stunt_track_sh45",
    "stt_prop_stunt_track_sh30",
    "stt_prop_stunt_track_sh15",
    "stt_prop_stunt_track_otake",
    "stt_prop_stunt_track_link",
    "stt_prop_stunt_track_jump",
    "stt_prop_stunt_track_hill2",
    "stt_prop_stunt_track_hill",
    "stt_prop_stunt_track_funnel",
    "stt_prop_stunt_track_funlng",
    "stt_prop_stunt_track_fork",
    "stt_prop_stunt_track_exshort",
    "stt_prop_stunt_track_dwuturn",
    "stt_prop_stunt_track_dwturn",
    "stt_prop_stunt_track_dwslope45",
    "stt_prop_stunt_track_dwslope30",
    "stt_prop_stunt_track_dwslope15",
    "stt_prop_stunt_track_dwshort",
    "stt_prop_stunt_track_dwsh15",
    "stt_prop_stunt_track_dwlink_02",
    "stt_prop_stunt_track_dwlink",
    "stt_prop_stunt_track_cutout",
    "stt_prop_stunt_track_bumps",
    "stt_prop_stunt_target_small",
    "stt_prop_stunt_target",
    "stt_prop_stunt_soccer_sball",
    "stt_prop_stunt_soccer_lball",
    "stt_prop_stunt_soccer_goal",
    "stt_prop_stunt_soccer_ball",
    "stt_prop_stunt_ramp",
    "stt_prop_stunt_landing_zone_01",
    "stt_prop_stunt_jump_sb",
    "stt_prop_stunt_jump_s",
    "stt_prop_stunt_jump_mb",
    "stt_prop_stunt_jump_m",
    "stt_prop_stunt_jump_loop",
    "stt_prop_stunt_jump_lb",
    "stt_prop_stunt_jump_l",
    "stt_prop_stunt_jump45",
    "stt_prop_stunt_jump30",
    "stt_prop_stunt_jump15",
    "stt_prop_stunt_track_start",
    "prop_container_01a",
    "prop_contnr_pile_01a",
    "ce_xr_ctr2",
    "stt_prop_ramp_jump_xxl",
    "hei_prop_carrier_jet",
    "prop_parking_hut_2",
    "csx_seabed_rock3_",
    "db_apart_03_",
    "db_apart_09_",
    "stt_prop_stunt_tube_l",
    "stt_prop_stunt_track_dwuturn",
    "xs_prop_hamburgher_wl",
    "sr_prop_spec_tube_xxs_01a",
    "prop_air_bigradar",
    "p_tram_crash_s",
    "prop_windmill_01",
    "prop_start_gate_01",
    "prop_trailer_01_new",
    "sr_prop_sr_track_block_01",
    "sr_prop_spec_tube_xxs_04a",
    "stt_prop_stunt_soccer_sball",
    "stt_prop_stunt_track_cutout",
    "stt_prop_stunt_target_small",
    "prop_cj_big_boat",
    "stt_prop_stunt_domino"
}

-- [ Explosion Blacklist ] (https://wiki.rage.mp/index.php?title=Explosions)
wx.explosionList = {
    [0]  = "GRENADE",
    [1]  = "GRENADELAUNCHER",
    [2]  = "STICKYBOMB",
    [3]  = "MOLOTOV",
    [4]  = "ROCKET",
    [5]  = "TANKSHELL",
    [6]  = "HI_OCTANE",
    -- [7]  = "CAR",
    -- [8]  = "PLANE",
    -- [9]  = "PETROL_PUMP",
    -- [10] = "BIKE",
    -- [11] = "DIR_STEAM",
    -- [12] = "DIR_FLAME",
    -- [13] = "DIR_WATER_HYDRANT",
    -- [14] = "DIR_GAS_CANISTER",
    -- [15] = "BOAT",
    -- [16] = "SHIP_DESTROY",
    -- [17] = "TRUCK",
    -- [18] = "BULLET",
    [19] = "SMOKEGRENADELAUNCHER",
    [20] = "SMOKEGRENADE",
    [21] = "BZGAS",
    [22] = "FLARE",
    -- [23] = "GAS_CANISTER",
    -- [24] = "EXTINGUISHER",
    [25] = "PROGRAMMABLEAR",
    -- [26] = "TRAIN",
    -- [27] = "BARREL",
    -- [28] = "PROPANE",
    -- [29] = "BLIMP",
    -- [30] = "DIR_FLAME_EXPLODE",
    -- [31] = "TANKER",
    -- [32] = "PLANE_ROCKET",
    -- [33] = "VEHICLE_BULLET",
    -- [34] = "GAS_TANK",
    -- [35] = "BIRD_CRAP",
    [36] = "RAILGUN",
    -- [37] = "BLIMP2",
    [38] = "FIREWORK",
    -- [39] = "SNOWBALL",
    [40] = "PROXMINE",
    [41] = "VALKYRIE_CANNON",
    [42] = "AIR_DEFENSE",
    [43] = "PIPEBOMB",
    [44] = "VEHICLEMINE",
    [45] = "EXPLOSIVEAMMO",
    [46] = "APCSHELL",
    [47] = "BOMB_CLUSTER",
    [48] = "BOMB_GAS",
    [49] = "BOMB_INCENDIARY",
    [50] = "BOMB_STANDARD",
    [51] = "TORPEDO",
    [52] = "TORPEDO_UNDERWATER",
    [53] = "BOMBUSHKA_CANNON",
    [54] = "BOMB_CLUSTER_SECONDARY",
    [55] = "HUNTER_BARRAGE",
    [56] = "HUNTER_CANNON",
    [57] = "ROGUE_CANNON",
    [58] = "MINE_UNDERWATER",
    [59] = "ORBITAL_CANNON",
    [60] = "BOMB_STANDARD_WIDE",
    [61] = "EXPLOSIVEAMMO_SHOTGUN",
    [62] = "OPPRESSOR2_CANNON",
    [63] = "MORTAR_KINETIC",
    [64] = "VEHICLEMINE_KINETIC",
    [65] = "VEHICLEMINE_EMP",
    [66] = "VEHICLEMINE_SPIKE",
    [67] = "VEHICLEMINE_SLICK",
    [68] = "VEHICLEMINE_TAR",
    [69] = "SCRIPT_DRONE",
    [70] = "RAYGUN",
    [71] = "BURIEDMINE",
    [72] = "SCRIPT_MISSILE",
    [73] = "SCRIPT_MISSILE",
    [82] = "EXP_TAG_SUBMARINE_BIG"
    
}
