ESX = nil
stealing = false
copblip = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    isLoggedIn = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    isLoggedIn = true
end)

function hack(success, remainingtime)
	exports['br-menu']:SetTitle(_U("startmenu"))
	exports['br-menu']:AddButton(_U("tier1title") , _U("tier1description") ,'pk-autodiefstal:startAutoDiefstal', '1')
	exports['br-menu']:AddButton(_U("tier2title") , _U("tier2description") ,'pk-autodiefstal:startAutoDiefstal', '2')
	exports['br-menu']:AddButton(_U("tier3title") , _U("tier3description") ,'pk-autodiefstal:startAutoDiefstal', '3')
	exports['br-menu']:AddButton(_U("tier4title") , _U("tier4description") ,'pk-autodiefstal:startAutoDiefstal', '4')	
end

RegisterNetEvent('pk-autodiefstal:openAutoDiefstalMenu')
AddEventHandler('pk-autodiefstal:openAutoDiefstalMenu', function()
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:seqstart",{6,5,4,3},90,hack)
end)

AutoKenteken = nil
needhacking = false

RegisterNetEvent('pk-autodiefstal:startAutoDiefstal')
AddEventHandler('pk-autodiefstal:startAutoDiefstal', function(value)
	ESX.TriggerServerCallback('pk-autodiefstal:isErCooldown', function(isActive, cooldown, copson)
		if copson then
			if tonumber(cooldown["Tier"..value]) <= 0 then
				if tonumber(isActive["Tier"..value]) == 0 then
					local sleep = 10
					local TierLocation = Config.Locations["Tier"..value]
					local randomlocation = math.random(1, #TierLocation)
					local BlipLocations = TierLocation[randomlocation].blip
					DiefstalBlip = AddBlipForRadius(BlipLocations.location.x, BlipLocations.location.y, BlipLocations.location.z, BlipLocations.radius)
					SetBlipHighDetail(DiefstalBlip, true)
					SetBlipColour(DiefstalBlip, 3)
					SetBlipAlpha(DiefstalBlip, 100)
					SetBlipAsShortRange(DiefstalBlip, true)
					local randomspawnlocation = math.random(1, #TierLocation[randomlocation].autos)
					local autoloc = TierLocation[randomlocation].autos[randomspawnlocation]
					ClearAreaOfVehicles(autoloc.x,autoloc.y,autoloc.z, 10.0, false, false, false, false, false)
					SpawnVehicle(autoloc.model, vector3(autoloc.x,autoloc.y,autoloc.z), autoloc.h)
					print(AutoKenteken)
					TriggerServerEvent('pk-autodiefstal:registeerActivity', 1, "Tier"..value, AutoKenteken)
					stealing = true
					stopblipsending = true
					Citizen.CreateThread(function() 
						while stealing do
							local ped = PlayerPedId()
							local pos = GetEntityCoords(ped)
							local veh = GetVehiclePedIsIn(ped, false)
							if IsPedInAnyVehicle(ped, false) and IsVehicleModel(GetVehiclePedIsIn(ped, false), GetHashKey(autoloc.model)) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped and GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, false)) == "DIEF 007" then
								if DiefstalBlip then
									RemoveBlip(DiefstalBlip)
								end
								if not setted then
									sellpos = math.random(1, #Config.Brengpunt)
									SetNewWaypoint(Config.Brengpunt[sellpos].x,Config.Brengpunt[sellpos].y,Config.Brengpunt[sellpos].z)
									setted = true
								end
								local InteractDistance = #(pos - vector3(Config.Brengpunt[sellpos].x,Config.Brengpunt[sellpos].y,Config.Brengpunt[sellpos].z))
								if InteractDistance < 500 then
									TriggerServerEvent('pk-autodiefstal:stopalertpolitie')
									sleep = 10
								elseif InteractDistance > 500 and needhacking then
									print(needhacking)
									sendPoliceAlert()
									sleep = TierLocation.updateblipforcops
								end
								if InteractDistance < 3 and not needhacking then
									DrawText3Ds(Config.Brengpunt[sellpos].x,Config.Brengpunt[sellpos].y,Config.Brengpunt[sellpos].z, _U("3dtextsellvehicle"))
									if IsControlJustPressed(0, Keys["E"]) then
										ESX.Game.DeleteVehicle(veh)
										TriggerServerEvent('pk-autodiefstal:pay', "Tier"..value)
										TriggerServerEvent('pk-autodiefstal:registeerActivity', 0, "Tier"..value)
										stealing = false
									end
								end
							end
							Citizen.Wait(sleep)
						end
					end)
				else
					ESX.ShowNotification(_U("alreadydoing"))
				end
			else
				ESX.ShowNotification(_U("thereisacouldown", math.ceil(tonumber(cooldown["Tier"..value])/1000)))
			end
		else
			ESX.ShowNotification(_U("notenoughpolice"))
		end
	end, "Tier"..value)
end)

function sendPoliceAlert()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) and GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, false)) == "DIEF 007" then
		local coords = GetEntityCoords(ped)
		TriggerServerEvent('pk-autodiefstal:alertpolitie', coords.x, coords.y, coords.z)
	end
end

showingmhacking = false

RegisterNetEvent('pk-autodiefstal:SyncAutoDiefstalHack')
AddEventHandler('pk-autodiefstal:SyncAutoDiefstalHack', function(tier, kenteken)
	if tier ~= "Tier1" and tier ~= nil then
		needhacking = true
		showingmhacking = false
		Citizen.CreateThread(function() 
			while needhacking do
				local ped = PlayerPedId()
				if IsPedInAnyVehicle(ped, false) and GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, false)) == "DIEF 007" and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), 0) == ped and not showingmhacking then
					showingmhacking = true
					if tier == "Tier2" then
						TriggerEvent("mhacking:show")
						TriggerEvent("mhacking:seqstart",{6,5,4,3},90,hack1done)
					elseif tier == "Tier3" then
						TriggerEvent("mhacking:show")
						TriggerEvent("mhacking:seqstart",{6,5,4,3,2},90,hack1done)
					elseif tier == "Tier4" then
						TriggerEvent("mhacking:show")
						TriggerEvent("mhacking:seqstart",{6,5,4,3,2,1},90,hack1done)
					end
				end
				Citizen.Wait(1000)
			end
		end)
	end
end)


RegisterNetEvent('pk-autodiefstal:GeefPolitieMelding')
AddEventHandler('pk-autodiefstal:GeefPolitieMelding', function(tier)
	ESX.ShowNotification("Auto diefstal is aan de gang Tier: "..tier)
end)

RegisterNetEvent('pk-autodiefstal:setpolitieblip')
AddEventHandler('pk-autodiefstal:setpolitieblip', function(cx,cy,cz)
	RemoveBlip(copblip)
    copblip = AddBlipForCoord(cx,cy,cz)
    SetBlipSprite(copblip , 161)
    SetBlipScale(copblipy , 2.0)
	SetBlipColour(copblip, 8)
	PulseBlip(copblip)
end)

RegisterNetEvent('pk-autodiefstal:removepolitieblip')
AddEventHandler('pk-autodiefstal:removepolitieblip', function()
		RemoveBlip(copblip)
end)

RegisterNetEvent('pk-autodiefstal:setneedhackingfalse')
AddEventHandler('pk-autodiefstal:setneedhackingfalse', function()
	needhacking = false
end)

function SpawnVehicle(model,coords,heading)
	Wait(1500)
	ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
		SetVehicleNumberPlateText(vehicle, "DIEF 007")
		print(GetVehicleNumberPlateText(vehicle))
		AutoKenteken = GetVehicleNumberPlateText(vehicle)
		SetEntityAsMissionEntity(vehicle, 0, 0)
	end)
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function hack1done(success, remainingtime, finish)
	if success then
		if finish then
			needhacking = false
			TriggerServerEvent('pk-autodiefstal:stopalertpolitie')
			TriggerServerEvent('pk-autodiefstal:setneedhackingfalse')
		end
	end
end
