-- Add your admins here
-- If you're still using ACE permissions, replace it with this config file or use wx.txAdminAuth, ACE permissions will be removed soon from this anticheat

Admins = {
    ["wx"] = { -- Admin Name (Doesn't matter, just so you know who is who)
        Identifiers = {
            -- Admin's identifiers, set to false to disable
            -- You can use both identifier:id or just id (discord:123 or just 123)
            discord = false, -- Discord identifier
            license = false, -- Rockstar license identifier
            steam = false, -- Steam identifier
        }
    },
    -- ["johndoe"] = {
    --     Identifiers = {
    --         discord = 'discord:12345678901234', -- Discord identifier
    --         license = '4b3a1e8c7f6d9b2e0a5f8c1e2d9a4c5e3f8d1e9b', -- Rockstar license identifier
    --         steam = 'steam:76561198012345678', -- Steam identifier
    --     }
    -- },
}