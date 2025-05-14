AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source
    local onlineCount = #GetPlayers()
    deferrals.defer()
    Wait(500)

    -- Queue Logic
    deferrals.update("⏳ Checking queue position...")
    local queued = true -- Replace with real queue logic
    if not queued then
        deferrals.done("❌ You're not in the queue.")
        return
    end
    Wait(500)

    -- Anti-Cheat Logic
    deferrals.update("🛡️ Running security checks...")
    local passed = true -- Replace with real anti-cheat logic
    if not passed then
        deferrals.done("🚫 You failed the security check.")
        return
    end
    Wait(500)
     -- Anti-Cheat Logic
    deferrals.update("🛡️ Running security checks...")
    local passed = true -- Replace with real anti-cheat logic
    if not passed then
        deferrals.done("🚫 You failed the security check.")
        return
    end
    Wait(500)
     -- Anti-Cheat Logic
    deferrals.update("🛡️ Running security checks...")
    local passed = true -- Replace with real anti-cheat logic
    if not passed then
        deferrals.done("🚫 You failed the security check.")
        return
    end
    Wait(500)
     -- Anti-Cheat Logic
    deferrals.update("🛡️ Running security checks...")
    local passed = true -- Replace with real anti-cheat logic
    if not passed then
        deferrals.done("🚫 You failed the security check.")
        return
    end
    Wait(500)
     -- Anti-Cheat Logic
    deferrals.update("🛡️ Running security checks...")
    local passed = true -- Replace with real anti-cheat logic
    if not passed then
        deferrals.done("🚫 You failed the security check.")
        return
    end
    Wait(500)
     -- Anti-Cheat Logic
    deferrals.update("🛡️ Running security checks...")
    local passed = true -- Replace with real anti-cheat logic
    if not passed then
        deferrals.done("🚫 You failed the security check.")
        return
    end
    Wait(500)


    -- Adaptive Card Setup
    deferrals.update("📡 Setting up your connection to Nolimit...")

local loginCard = {
        ["type"] = "AdaptiveCard",
        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
        ["version"] = "1.4",
        ["backgroundImage"] = {
            url = "",
            fillMode = "Cover",
            horizontalAlignment = "Center",
            verticalAlignment = "Center"
        },
        ["body"] = {
            {
                ["type"] = "Container",
                ["items"] = {
                    {
                        ["type"] = "ColumnSet",
                        ["columns"] = {
                            {
                                ["type"] = "Column",
                                ["width"] = "stretch",
                                ["items"] = {
                                    {
            ["type"] = "TextBlock",
            ["text"] = "🔥 Welcome to Server Name",
            ["size"] = "ExtraLarge",
            ["weight"] = "Bolder",
            ["wrap"] = true,
            ["horizontalAlignment"] = "Center",
            ["color"] = "Light"
                                    },
                                    {
            ["type"] = "TextBlock",
            ["text"] = "👋 Hello **"..name.."**! Setting up your experience...",
            ["size"] = "Medium",
            ["wrap"] = true,
            ["horizontalAlignment"] = "Center",
            ["spacing"] = "Small",
            ["color"] = "Light"
                                    },
                                    {
                                        ["type"] = "ColumnSet",
                                        ["spacing"] = "Medium",
                                        ["columns"] = {
                                            {
                                                ["type"] = "Column",
                                                ["width"] = "auto",
                                                ["items"] = {
                                                    { ["type"] = "TextBlock", ["text"] = "Name", ["weight"] = "Bolder", ["wrap"] = true },
                                                    { ["type"] = "TextBlock", ["text"] = "Players", ["weight"] = "Bolder", ["wrap"] = true },
                                                    { ["type"] = "TextBlock", ["text"] = "Whitelist", ["weight"] = "Bolder", ["wrap"] = true },
                                                    { ["type"] = "TextBlock", ["text"] = "Status", ["weight"] = "Bolder", ["wrap"] = true }
                                                }
                                            },
                                            {
                                                ["type"] = "Column",
                                                ["width"] = "auto",
                                                ["items"] = {
                                                    { ["type"] = "TextBlock", ["text"] = name, ["wrap"] = true },
                                                    { ["type"] = "TextBlock", ["text"] = onlineCount.." / 128", ["wrap"] = true },
                                                    { ["type"] = "TextBlock", ["text"] = "Yes 🟢", ["wrap"] = true },
                                                    { ["type"] = "TextBlock", ["text"] = "Connected ✅", ["wrap"] = true }
                                                }
                                            }
                                        }
                                    }
                                }
                            },
                            {
                                ["type"] = "Column",
                                ["width"] = "auto",
                                ["items"] = {
                                    {
                                        ["type"] = "Image",
                                        ["url"] = "https://i.ibb.co/DP9NfQkX/black-white-sign-that-says-your-logo-it-1085346-60932-removebg-preview.png",
                                        ["size"] = "Medium",
                                        ["horizontalAlignment"] = "Center"
                                    }
                                }
                            }
                        }
                    }
                }
            },
            {
                ["type"] = "TextBlock",
                ["text"] = "💡 Tip: Respect others, have fun, follow the rules!",
                ["size"] = "Medium",
                ["weight"] = "Bolder",
                ["color"] = "Warning",
                ["wrap"] = true,
                ["horizontalAlignment"] = "Center"
            },
            {
                ["type"] = "Image",
                ["url"] = "",
                ["size"] = "Stretch",
                ["horizontalAlignment"] = "Center"
            },
            {
                ["type"] = "ColumnSet",
                ["columns"] = {
                    {
                        ["type"] = "Column",
                        ["width"] = "auto",
                        ["items"] = {
                            {
                                ["type"] = "ActionSet",
                                ["actions"] = {
                                    { ["type"] = "Action.Submit", ["title"] = "🛬 Fly In" }
                                }
                            }
                        }
                    },
                    {
                        ["type"] = "Column",
                        ["width"] = "auto",
                        ["items"] = {
                            {
                                ["type"] = "ActionSet",
                                ["actions"] = {
                                    { ["type"] = "Action.OpenUrl", ["title"] = "🛒 Shop", ["url"] = "https://no-limits.tebex.io/" }
                                }
                            }
                        }
                    },
                    {
                        ["type"] = "Column",
                        ["width"] = "auto",
                        ["items"] = {
                            {
                                ["type"] = "ActionSet",
                                ["actions"] = {
                                    { ["type"] = "Action.OpenUrl", ["title"] = "Discord", ["url"] = "https://discord.gg/Swj5A8ZhC9", ["iconUrl"] = "https://i.ibb.co/nsWHzgVc/discord-logo-icon-set-communication-platform-brand-symbols-vector-628407-1816-removebg-preview.png" }
                                }
                            }
                        }
                    },
                    {
                        ["type"] = "Column",
                        ["width"] = "auto",
                        ["items"] = {
                            {
                                ["type"] = "ActionSet",
                                ["actions"] = {
                                    { ["type"] = "Action.OpenUrl", ["title"] = "🌐 Website", ["url"] = "https://no-limits.tebex.io/" }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    local success, card = pcall(json.encode, loginCard)
    if not success then
        deferrals.done("❌ Failed to load connection card.")
        return
    end

    deferrals.presentCard(card, function(data, raw)
        print("✅ Player joined successfully:", name)
        deferrals.done()
    end)
end)