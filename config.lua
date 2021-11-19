Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = {}

Config.Locale = "nl"

Config.CooldownMinutes = 10

Config.Payment = {
	["Tier1"] = 5000,
	["Tier2"] = 10000,
	["Tier3"] = 15000,
	["Tier4"] = 20000,
}

Config.HackTimes = {
	["Tier2"] = 2,
	["Tier3"] = 3,
	["Tier4"] = 4,
}

Config.NotificationType = { --[ 'esx' / 'qbus' / 'mythic_old' / 'mythic_new' / 'chat' / 'other' ] Choose your notification script.
    client = 'mythic_new' 
}

Config.updateblipforcops = 1000 * 3

Config.Locations = {
	["Tier1"] = {
		updateblipforcops = 1000 * 3,
		copsneeded = 2,
		[1] = {
			blip = {
				location = {x = 1238.5826, y = -1615.1046, z = 52.1279},
				radius = 100.0
			},
			autos = {
				{model = "burrito2", x = 1227.5374, y = -1604.4216, z = 51.7978, h = 219.2632},
				{model = "burrito", x = 1252.1689, y = -1618.3297, z = 53.4485, h = 37.0379},
				{model = "blista", x = 1274.1641, y = -1612.1688, z = 54.2254, h = 33.1544}
			}
		},
		[2] = {
			blip = {
				location = {x = 128.1992, y = 566.2100, z = 183.9645},
				radius = 100.0
			},
			autos = {
				{model = "burrito2", x = 130.3524, y = 569.0234, z = 183.3028, h = 270.6900},
				{model = "burrito", x = 97.7693, y = 567.9034, z = 182.3089, h = 91.7082},
				{model = "blista",x = 173.9292, y = 484.6657, z = 142.4493, h =343.7515}
			}
		},
	},
	["Tier2"] = {
		updateblipforcops = 1000 * 3,
		copsneeded = 3,
		[1] = {
			blip = {
				location = {x = -3069.5032, y = 319.7040, z = 10.6600},
				radius = 100.0
			},
			autos = {
				{model = "Asea", x = -3097.4419, y = 307.1659, z = 8.3555, h = 254.9140},
				{model = "Asterope", x = -3090.8816, y = 323.8807, z = 7.4983, h = 254.3747},
			}
		},
		[2] = {
			blip = {
				location = {x = -3136.6208, y = 1125.9500, z = 20.6955},
				radius = 100.0
			},
			autos = {
				{model = "Asea", x = -3153.8162, y = 1089.2190, z = 20.7061, h = 102.3114},
				{model = "Asterope", x = -3218.4055, y = 1107.7627, z = 10.4179, h = 125.2306},
			}
		},
	},
	["Tier3"] = {
		copsneeded = 4,
		updateblipforcops = 1000 * 3,
		[1] = {
			blip = {
				location = {x = -366.3397, y = 6242.6597, z = 31.4622},
				radius = 50.0
			},
			autos = {
				{model = "banshee", x = -356.8008, y = 6270.3008, z = 31.1905, h = 39.9000},
				{model = "buffalo", x = -355.5764, y = 6223.2070, z = 31.4890, h = 222.5044},
			}
		},
		[2] = {
			blip = {
				location = {x = -14.5495, y = 6576.3203, z = 31.4601},
				radius = 50.0
			},
			autos = {
				{model = "banshee", x = -8.5873, y = 6598.0688, z = 31.4706, h = 36.0098},
				{model = "buffalo", x = 12.5923, y = 6586.3794, z = 32.4708, h = 221.7267},
			}
		},
	},
	["Tier4"] = {
		copsneeded = 5,
		updateblipforcops = 1000 * 3,
		[1] = {
			blip = {
				location = {x = -14.5495, y = 6576.3203, z = 31.4601},
				radius = 50.0
			},
			autos = {
				{model = "bullet", 	x = -8.5873, y = 6598.0688, z = 31.4706, h = 36.0098 },
				{model = "cheetah",	x = 12.5923, y = 6586.3794, z = 32.4708, h = 221.7267},
			}
		},
		[2] = {
			blip = {
				location = {x = -366.3397, y = 6242.6597, z = 31.4622},
				radius = 50.0
			},
			autos = {
				{model = "bullet", 	x = -356.8008, y = 6270.3008, z = 31.1905, h = 39.9000 },
				{model = "cheetah",	x = -355.5764, y = 6223.2070, z = 31.4890, h = 222.5044},
			}
		},
	},
}

Config.Brengpunt = {
	{x = 335.9891, y = 2619.8049, z = 44.4937},
	{x = 1530.6219, y = 1734.7299, z = 110.1513},
}

-- Locale

function _(str, ...)  -- Translate string

	if Locales[Config.Locale] ~= nil then

		if Locales[Config.Locale][str] ~= nil then
			return string.format(Locales[Config.Locale][str], ...)
		else
			return 'Translation [' .. Config.Locale .. '][' .. str .. '] does not exist'
		end

	else
		return 'Locale [' .. Config.Locale .. '] does not exist'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end