ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

cooldown = {
	["Tier1"] = 0,
	["Tier2"] = 0,
	["Tier3"] = 0,
	["Tier4"] = 0,
}

isActive = {
	["Tier1"] = 0,
	["Tier2"] = 0,
	["Tier3"] = 0,
	["Tier4"] = 0,
}

ESX.RegisterUsableItem('usbauto', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
	local laptop = xPlayer.getInventoryItem("laptop")
	if xPlayer.getJob().name ~= "police" and xPlayer.getJob().name ~= "ambulance" and xPlayer.getJob().name ~= "mechanic" then
		if laptop.count >= 1 then
			TriggerClientEvent('pk-autodiefstal:openAutoDiefstalMenu', playerId)
			print("done")
		else
			xPlayer.showNotification(_U("nolaptop"))
		end
	else
		xPlayer.showNotification(_U("cannotdoitaspolice"))
	end
end)

RegisterServerEvent('pk-autodiefstal:pay')
AddEventHandler('pk-autodiefstal:pay', function(tier)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local payment = Config.Payment[tier]
	xPlayer.addAccountMoney('black_money',tonumber(payment))
	
	cooldown[tier] = Config.CooldownMinutes * 60000
	if tier == "Tier1" then
		Citizen.CreateThread(function()
			while (cooldown[tier] > 0) do
				Citizen.Wait(100)
				cooldown[tier] = cooldown[tier] - 100
			end
		end)
	elseif tier == "Tier2" then
		Citizen.CreateThread(function()
			while (cooldown[tier] > 0) do
				Citizen.Wait(100)
				cooldown[tier] = cooldown[tier] - 100
			end
		end)
	elseif tier == "Tier3" then
		Citizen.CreateThread(function()
			while (cooldown[tier] > 0) do
				Citizen.Wait(100)
				cooldown[tier] = cooldown[tier] - 100
			end
		end)
	elseif tier == "Tier4" then
		Citizen.CreateThread(function()
			while (cooldown[tier] > 0) do
				Citizen.Wait(100)
				cooldown[tier] = cooldown[tier] - 100
			end
		end)
	end
end)

RegisterServerEvent('pk-autodiefstal:alertpolitie')
AddEventHandler('pk-autodiefstal:alertpolitie', function(cx,cy,cz)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('pk-autodiefstal:setpolitieblip', xPlayers[i], cx,cy,cz)
		end
	end
end)

RegisterServerEvent('pk-autodiefstal:setneedhackingfalse')
AddEventHandler('pk-autodiefstal:setneedhackingfalse', function()
	TriggerClientEvent("pk-autodiefstal:setneedhackingfalse", -1)
end)

RegisterServerEvent('pk-autodiefstal:stopalertpolitie')
AddEventHandler('pk-autodiefstal:stopalertpolitie', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('pk-autodiefstal:removepolitieblip', xPlayers[i])
		end
	end
end)

cops = 0

RegisterServerEvent('pk-autodiefstal:registeerActivity')
AddEventHandler('pk-autodiefstal:registeerActivity', function(value, tier, kenteken)
	isActive[tier] = value
	if value == 1 then
		activitySource = source
		--Send notification to cops
		local xPlayers = ESX.GetPlayers()
		TriggerClientEvent("pk-autodiefstal:SyncAutoDiefstalHack", -1, tier, kenteken)
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				cops = cops + 1
				TriggerClientEvent('pk-autodiefstal:GeefPolitieMelding', xPlayers[i], tier)
			end
		end
	else
		activitySource = 0
	end
end)

ESX.RegisterServerCallback('pk-autodiefstal:isErCooldown',function(source, cb, tier)
	if cops >= Config.Locations[tier].copsneeded then
		local policeon = true
		cb(isActive, cooldown, policeon)
	else
		local policeon = false
		cb(isActive, cooldown, policeon)
	end
end)