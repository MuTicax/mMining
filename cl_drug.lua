OnSellDrugs = false 

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function Haveitems(item, count)
    local bool = false
    ESX.TriggerServerCallback("esx:getPlayerInventory", function(data)
        items = {}
        inventory = data.inventory

        if inventory ~= nil then
            for key, value in pairs(inventory) do
                if inventory[key].name == item then 
                    if inventory[key].count >= count then
                        bool = true   
                    else
                        bool = false 
                    end
                end
            end
        end
    end, GetPlayerServerId(PlayerId()) )
    Wait(100)
    return bool
end

RegisterNetEvent('copenservice')
AddEventHandler('copenservice', function()
    ESX.Notification("Vous avez ~g~activé~s~ la vente de drogue.")
    ESX.DrawMissionText("~r~Vous êtes à la recherche de clients..", 900000000)
    OnSellDrugs = true 
end)

RegisterNetEvent('cancelvente')
AddEventHandler('cancelvente', function()
    ESX.DrawMissionText("~r~Impossible de vendre pas assez de policiers en service.", 4000)
    OnSellDrugs = false
end)

RegisterCommand("drogue", function()
    local player = PlayerPedId()
    local found = false 
    for k,v in pairs(Config.DrugSell) do 
        if Haveitems(v.item, 1) then 
            found = true 
            break 
        else
            found = false 
        end
    end
    if not found then
        return
        ESX.ShowNotification("~r~Impossible~s~~n~Vous devez avoir de la drogue sur vous.")
    end
    if not OnSellDrugs then 
        ESX.TriggerServerCallback('JobInService', function(count)
            if count >= Config.PoliceRequireDrugSell then
                TriggerServerEvent('activedrogue')
            else
                ESX.ShowNotification("~r~Impossible aucun policier en service.")
            end
        end, "police")
    elseif OnSellDrugs then 
        ESX.Notification("Vous avez ~r~désactivé~s~ la vente de drogue.")
        ESX.DrawMissionText("", 1)
        OnSellDrugs = false 
    end
end)

function CanSellToPed(ped)
	if not IsPedAPlayer(ped) and not IsEntityAMissionEntity(ped) and not IsPedInAnyVehicle(ped, false) and not IsEntityDead(ped) and IsPedHuman(ped) and GetEntityModel(ped) ~= GetHashKey("s_m_y_cop_01") and GetEntityModel(ped) ~= GetHashKey("s_m_y_dealer_01") and GetEntityModel(ped) ~= GetHashKey("mp_m_shopkeep_01") and ped ~= PlayerPedId() then 
		return true
	end
	return false
end

function DrawText3D(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1/distance)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0 * scale, 0.25 * scale)
		SetTextFont(8)
		SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextCentre(1)
        SetTextEntry('STRING')
        AddTextComponentString(text)
		DrawText(_x,_y)
    end
end

function animationdrugs(ped, libs, anim, time)
    ESX.Streaming.RequestAnimDict(libs)
    TaskPlayAnim(ped, libs, anim, 2.0, -8.0, time, 35, 0, 0, 0, 0) 
end

local pedinteract = {   
    {
        name = 'etatveh',
        icon = 'fa-solid fa-cannabis',
        label = 'Proposer de la drogue',
        canInteract = function(entity, distance, coords, name, bone)
            local succesPed = nil 
            local retval, pnj = FindFirstPed()
            succesPed, pnj = FindNextPed(retval)
            EndFindPed(retval)
            return OnSellDrugs == true and CanSellToPed(pnj) == true
        end,
        onSelect = function()
            local wait = 1000
            local PlayerPed = PlayerPedId()
            local Ply = GetEntityCoords(PlayerPed)
    
            if OnSellDrugs and not IsPedInAnyVehicle(PlayerPed) then 
                wait = 250
                local retval, pnj = FindFirstPed()
                local succesPed = nil 
    
                repeat 
                    PlayerPed = PlayerPedId()
                    Ply = GetEntityCoords(PlayerPed)
                    succesPed, pnj = FindNextPed(retval)
                    local pos = GetEntityCoords(pnj)
                    local dist = Vdist(Ply, pos)
                    if dist <= 5.0 and CanSellToPed(pnj) then 
                        wait = 5
                        SetBlockingOfNonTemporaryEvents(pnj, true)
                        PlayAmbientSpeech2(pnj, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
                        SetPedCanRagdollFromPlayerImpact(pnj, false)
    
                        if dist <= 1.5 then
                            PlayAmbientSpeech1(pnj, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
                            PlaceObjectOnGroundProperly(pnj)
    
                            local item, minmoney, maxmoney, tonta, label = nil, nil, nil, nil, nil, nil
    
                            for k,v in pairs(Config.DrugSell) do 
                                if Haveitems(v.item, 1) then 
                                    item, minmoney, maxmoney, tonta, label = v.item, v.minmoney, v.maxmoney, v.tonta, v.label
                                    break 
                                end
                            end
                            if not minmoney and not maxmoney then 
                                ESX.ShowNotification("~r~Impossible~s~\nVous n'avez plus de drogues.")
                                ESX.DrawMissionText("", 1)
                                OnSellDrugs = false 
                            else
                                SetPedTalk(pnj)
                                PlayAmbientSpeech1(pnj, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
    
                                local chance = math.random(0, 100)
                                if chance >= 0 and chance <= 28 then
                                    chancecallpolice = math.random(1, 6)
                                    if chancecallpolice == 1 then
                                        TriggerServerEvent("call:makeCallSpecial", "police", GetEntityCoords(GetPlayerPed(-1)),"Deal en cours", "VenteDeDrogue")
                                        ESX.ShowNotification("~r~Une personne aux alentours a contacté la police.")
                                    else
                                        ESX.ShowNotification("~r~La personne à refusé votre offre.")	
                                    end
                                else
                                    if minmoney and maxmoney then
                                        animationdrugs(GetPlayerPed(-1), "mp_common", "givetake2_a", 1800)
                                        animationdrugs(pnj, "mp_common", "givetake2_a", 1800)
                                        prop = CreateObject(GetHashKey('p_meth_bag_01_s'), 0, 0, 0, true)
                                        AttachEntityToEntity(prop, PlayerPed, GetPedBoneIndex(PlayerPed, 57005), 0.15, 0.01, -0.06, 185.0, 215.0, 180.0, true, true, false, true, 1, true)

                                        money = CreateObject(GetHashKey("hei_prop_heist_cash_pile"), 0, 0, 0, true)
                                        AttachEntityToEntity(money, pnj, GetPedBoneIndex(pnj, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
                                        Wait(1000)
                                        DeleteObject(prop)
                                        DeleteObject(money)
                                        TriggerServerEvent('ventedrogue', item, tonta, label, math.random(minmoney, maxmoney), 1)
                                    else
                                        ESX.ShowNotification("~r~Vous n'avez plus de drogues.")
                                        ESX.DrawMissionText("", 1)
                                        OnSellDrugs = false 
                                    end
                                end
                                Citizen.Wait(500)
                                TaskWanderStandard(pnj, 10.0, 10)
                                PlayAmbientSpeech1(pnj, 'GENERIC_THANKS', 'SPEECH_PARAMS_STANDARD')
    
                                SetEntityAsMissionEntity(pnj, true, true)
                                SetPedCanRagdollFromPlayerImpact(pnj, true)
                            end
                        end
                    end
                until not succesPed
                EndFindPed(retval)
            end
            Wait(wait)
        end,
    },
}

exports.ox_target:addGlobalPed(pedinteract)