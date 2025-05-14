Shared = Shared or {}

Shared.Channels = {
	-- Example for Jobs, requires esx or qbcore
	[911] = {
		label = "Police Radio",
		jobs = { "police" },
	},
	-- Example for Gangs, requires qbcore
	[420] = {
		label = "Gang Radio",
		gangs = { "ballas" },
	},
	-- Example for identifiers, citizenid's etc
	[321] = {
		label = "Identifier Radio",
		-- List of whitelisted values
		whitelisted = { "license:66f114916edbe95a1fbb0928800533106de1ac2c" },
	},
	-- Example for Discord Roles, requires zdiscord or Badger_Discord_API
	[123] = {
		label = "Discord Radio",
		-- Role IDs, has to be strings not numbers
		discordRoles = {
			"931643836562804798",
		},
	},
	-- Example for Ace Permissions
	[1337] = {
		label = "Ace Permissions Radio",
		-- Ace permissions list
		acePermissions = {
			"example.permission",
		},
	},
	-- Example for custom check
	[1234] = {
		label = "Custom Radio",
		-- Custom functionality for radio access
		customCheck = function(src)
			print("source " .. tostring(src) .. " tried to join channel 1234")

			-- return true or false, depending on if the person should be let in or not
			return true
		end
	},
}
