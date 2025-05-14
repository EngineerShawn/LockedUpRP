return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			image = 'burger_chicken.png',
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['sprunk'] = {
		label = 'Sprunk',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk'
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
		client = {
			image = 'card_id.png'
		}
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
	},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},

	['money'] = {
		label = 'Money',
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		}
	},

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Fleeca Card',
		stack = false,
		weight = 10,
		client = {
			image = 'card_bank.png'
		}
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},

	["alive_chicken"] = {
		label = "Living chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["blowpipe"] = {
		label = "Blowtorch",
		weight = 2,
		stack = true,
		close = true,
	},

	["bread"] = {
		label = "Bread",
		weight = 1,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	["carokit"] = {
		label = "Body Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["clothe"] = {
		label = "Cloth",
		weight = 1,
		stack = true,
		close = true,
	},

	["copper"] = {
		label = "Copper",
		weight = 1,
		stack = true,
		close = true,
	},

	["cutted_wood"] = {
		label = "Cut wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["diamond"] = {
		label = "Diamond",
		weight = 1,
		stack = true,
		close = true,
	},

	["essence"] = {
		label = "Gas",
		weight = 1,
		stack = true,
		close = true,
	},

	["fabric"] = {
		label = "Fabric",
		weight = 1,
		stack = true,
		close = true,
	},

	["fish"] = {
		label = "Fish",
		weight = 1,
		stack = true,
		close = true,
	},

	["fixkit"] = {
		label = "Repair Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["fixtool"] = {
		label = "Repair Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["gazbottle"] = {
		label = "Gas Bottle",
		weight = 2,
		stack = true,
		close = true,
	},

	["gold"] = {
		label = "Gold",
		weight = 1,
		stack = true,
		close = true,
	},

	["iron"] = {
		label = "Iron",
		weight = 1,
		stack = true,
		close = true,
	},

	["marijuana"] = {
		label = "Marijuana",
		weight = 2,
		stack = true,
		close = true,
	},

	["medikit"] = {
		label = "Medikit",
		weight = 2,
		stack = true,
		close = true,
	},

	["packaged_chicken"] = {
		label = "Chicken fillet",
		weight = 1,
		stack = true,
		close = true,
	},

	["packaged_plank"] = {
		label = "Packaged wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol"] = {
		label = "Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol_raffin"] = {
		label = "Processed oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["slaughtered_chicken"] = {
		label = "Slaughtered chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["stone"] = {
		label = "Stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["washed_stone"] = {
		label = "Washed stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["wood"] = {
		label = "Wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["wool"] = {
		label = "Wool",
		weight = 1,
		stack = true,
		close = true,
	},

	-- [Smartphone Items]

	["classic_phone"] = {
		["name"] = "classic_phone",
		["label"] = "Classic Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "classic_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["black_phone"] = {
		["name"] = "black_phone",
		["label"] = "Black Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "black_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["blue_phone"] = {
		["name"] = "blue_phone",
		["label"] = "Blue Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "blue_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["gold_phone"] = {
		["name"] = "gold_phone",
		["label"] = "Gold Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "gold_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["purple_phone"] = {
		["name"] = "purple_phone",
		["label"] = "Purple Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "purple_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["red_phone"] = {
		["name"] = "red_phone",
		["label"] = "Red Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "red_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["green_phone"] = {
		["name"] = "green_phone",
		["label"] = "Green Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "green_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["greenlight_phone"] = {
		["name"] = "greenlight_phone",
		["label"] = "Green Light Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "greenlight_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["pink_phone"] = {
		["name"] = "pink_phone",
		["label"] = "Pink Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "pink_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["white_phone"] = {
		["name"] = "white_phone",
		["label"] = "White Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "white_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["wet_classic_phone"] = {
		["name"] = "wet_classic_phone",
		["label"] = "Wet Classic Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "wet_classic_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "Did you really think that swimming in the ocean with your phone was a good idea?"
	},
	
	["wet_black_phone"] = {
		["name"] = "wet_black_phone",
		["label"] = "Wet Black Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "wet_black_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "Did you really think that swimming in the ocean with your phone was a good idea?"
	},
	
	["wet_blue_phone"] = {
		["name"] = "wet_blue_phone",
		["label"] = "Wet Blue Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "wet_blue_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "Did you really think that swimming in the ocean with your phone was a good idea?"
	},
	
	["wet_gold_phone"] = {
		["name"] = "wet_gold_phone",
		["label"] = "Wet Gold Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "wet_gold_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "Did you really think that swimming in the ocean with your phone was a good idea?"
	},
	
	["wet_purple_phone"] = {
		["name"] = "wet_purple_phone",
		["label"] = "Wet Purple Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "wet_purple_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "Did you really think that swimming in the ocean with your phone was a good idea?"
	},
	
	["wet_red_phone"] = {
		["name"] = "wet_red_phone",
		["label"] = "Wet Red Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "wet_red_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "Did you really think that swimming in the ocean with your phone was a good idea?"
	},
	
	["wet_green_phone"] = {
		["name"] = "wet_green_phone",
		["label"] = "Wet Green Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "wet_green_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["wet_greenlight_phone"] = {
		["name"] = "wet_greenlight_phone",
		["label"] = "Wet Green Light Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "wet_greenlight_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["wet_pink_phone"] = {
		["name"] = "wet_pink_phone",
		["label"] = "Wet Pink Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "wet_pink_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["wet_white_phone"] = {
		["name"] = "wet_white_phone",
		["label"] = "Wet White Phone",
		["weight"] = 700,
		["type"] = "item",
		["image"] = "wet_white_phone.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "They say that Quasar Smartphone is the same as an iPhone, what do you think?"
	},
	
	["phone_hack"] = {
		["name"] = "phone_hack",
		["label"] = "Phone Hack",
		["weight"] = 300,
		["type"] = "item",
		["image"] = "phone_hack.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "With this chip, you can access hidden areas of Discord."
	},
	
	["phone_module"] = {
		["name"] = "phone_module",
		["label"] = "Phone Module",
		["weight"] = 300,
		["type"] = "item",
		["image"] = "phone_module.png",
		["unique"] = true,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "It seems that we can fix a wet phone with this module, interesting."
	},

	-- Prison SIM Items

	["metalbar"] = {
        label = "Metal Bar",
        weight = 100,
        stack = true,
        close = true,
        description = "A Metal Bar",
        client = {
            image = "metalbar.png"
        }
    },
    ["metalplate"] = {
        label = "Metal Plate",
        weight = 100,
        stack = true,
        close = true,
        description = "A Metal Plate",
        client = {
            image = "metalplate.png"
        }
    },
    ["licenseplate"] = {
        label = "License Plate",
        weight = 100,
        stack = true,
        close = true,
        description = "A License Plate",
        client = {
            image = "licenseplate.png"
        }
    },
    ["woodlog"] = {
        label = "Wood Log",
        weight = 100,
        stack = true,
        close = true,
        description = "A Wood Log",
        client = {
            image = "woodlog.png"
        }
    },
    ["woodplank"] = {
        label = "Wood Plank",
        weight = 100,
        stack = true,
        close = true,
        description = "A Wood Plank",
        client = {
            image = "woodplank.png"
        }
    },
    ["wooden_chair"] = {
        label = "Wooden Chair",
        weight = 100,
        stack = true,
        close = true,
        description = "A Wooden Chair",
        client = {
            image = "wooden_chair.png"
        }
    },
    ["wooden_table"] = {
        label = "Wooden Table",
        weight = 100,
        stack = true,
        close = true,
        description = "A Wooden Table",
        client = {
            image = "wooden_table.png"
        }
    },
    ["wooden_storage_box"] = {
        label = "Wooden Storage Box",
        weight = 100,
        stack = true,
        close = true,
        description = "A Wooden Storage Box",
        client = {
            image = "wooden_storage_box.png"
        }
    },
    ["prison_jump_suit_clean_folded"] = {
        label = "Clean Folded Prison Jumpsuit",
        weight = 100,
        stack = true,
        close = true,
        description = "A Clean Folded Prison Jumpsuit",
        client = {
            image = "prison_jump_suit_clean_folded.png"
        }
    },
    ["prison_jump_suit_clean"] = {
        label = "Clean Prison Jumpsuit",
        weight = 100,
        stack = true,
        close = true,
        description = "A Clean Prison Jumpsuit",
        client = {
            image = "prison_jump_suit_clean.png"
        }
    },
    ["prison_jump_suit_wet"] = {
        label = "Wet Prison Jumpsuit",
        weight = 100,
        stack = true,
        close = true,
        description = "A Wet Prison Jumpsuit",
        client = {
            image = "prison_jump_suit_wet.png"
        }
    },
    ["prison_jump_suit_dirty"] = {
        label = "Dirty Prison Jumpsuit",
        weight = 100,
        stack = true,
        close = true,
        description = "A Dirty Prison Jumpsuit",
        client = {
            image = "prison_jump_suit_dirty.png"
        }
    },
    ["guard_uniform_clean_folded"] = {
        label = "Clean Folded Guard Uniform",
        weight = 100,
        stack = true,
        close = true,
        description = "A Clean Folded Guard Uniform",
        client = {
            image = "guard_uniform_clean_folded.png"
        }
    },
    ["guard_uniform_clean"] = {
        label = "Clean Guard Uniform",
        weight = 100,
        stack = true,
        close = true,
        description = "A Clean Guard Uniform",
        client = {
            image = "guard_uniform_clean.png"
        }
    },
    ["guard_uniform_wet"] = {
        label = "Wet Guard Uniform",
        weight = 100,
        stack = true,
        close = true,
        description = "A Wet Guard Uniform",
        client = {
            image = "guard_uniform_wet.png"
        }
    },
    ["guard_uniform_dirty"] = {
        label = "Dirty Guard Uniform",
        weight = 100,
        stack = true,
        close = true,
        description = "A Dirty Guard Uniform",
        client = {
            image = "guard_uniform_dirty.png"
        }
    },
    ["laundry_detergent"] = {
        label = "Laundry Detergent",
        weight = 100,
        stack = true,
        close = true,
        description = "Laundry Detergent",
        client = {
            image = "laundry_detergent.png"
        }
    },
    ["pickaxe"] = {
        label = "Pickaxe",
        weight = 100,
        stack = true,
        close = true,
        description = "A Pickaxe",
        client = {
            image = "pickaxe.png"
        }
    },
    ["rock"] = {
        label = "Rock",
        weight = 100,
        stack = true,
        close = true,
        description = "A Rock",
        client = {
            image = "rock.png"
        }
    },
    ["recyclable_material"] = {
        label = "Recyclable Material",
        weight = 100,
        stack = true,
        close = true,
        description = "Recyclable Material",
        client = {
            image = "recyclable_material.png"
        }
    },
    ["recyclable_material_block"] = {
        label = "Recyclable Material Block",
        weight = 100,   
        stack = true,
        close = true,
        description = "Recyclable Material Block",
        client = {
            image = "recyclable_material_block.png"
        }
    },

    ["bagged_lunch"] = {
        label = "Bagged Lunch",
        weight = 1,
        stack = true,
        close = true,
        description = "A Simple Bagged Lunch",
        client = {
            image = "bagged_lunch.png"
        }
    },

	["sim_card"] = {
		label = "Sim Card",
		weight = 1,
		stack = true,
		close = true,
	},
}