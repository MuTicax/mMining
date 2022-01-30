ESX = nil
local mining = false
local Rocks = {
    {   
        handler = nil, 
        minerals = {
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            }
        }
    },
    {   
        handler = nil, 
        minerals = {
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            }
        }
    },
    {   
        handler = nil, 
        minerals = {
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            }
        }
    },
    {   
        handler = nil, 
        minerals = {
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            }
        }
    },
    {   
        handler = nil, 
        minerals = {
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            },
            {
                handler = nil
            }
        }
    }
}

AddEventHandler('onResourceStop', function(resource)
	despawn()
end)

function spawn()
    for i=1, #Config.Rocks, 1 do
        ESX.Game.SpawnLocalObject(Config.Rocks[i].rock, Config.Rocks[i].coords, function(obj_rock)
            Rocks[i].handler = obj_rock
            Config.Rocks[i].active = true
            PlaceObjectOnGroundProperly(Rocks[i].handler)
            FreezeEntityPosition(Rocks[i].handler, true)
            for m=1, #Config.Rocks[i].minerals, 1 do
                if not Config.Rocks[i].minerals[m].active then
                    Config.Rocks[i].minerals[m].active = true
                    ESX.Game.SpawnLocalObject(Config.Rocks[i].mineral, GetOffsetFromEntityInWorldCoords(obj_rock, Config.Rocks[i].minerals[m].pos), function(obj_mineral)
                        Rocks[i].minerals[m].handler = obj_mineral
                        SetEntityRotation(Rocks[i].minerals[m].handler, Config.Rocks[i].minerals[m].rot, 2, false)
                        SetEntityInvincible(Rocks[i].minerals[m].handler, true)
                        FreezeEntityPosition(Rocks[i].minerals[m].handler, true)
                    end)
                end
            end
        end)
    end
end

RegisterNetEvent('M_MINING:SetLoad')
AddEventHandler('M_MINING:SetLoad', function(config)
	Config.Rocks = config
    spawn()
end)

function despawn()
    for i=1, #Config.Rocks, 1 do
        if DoesEntityExist(Rocks[i].handler) then
            DeleteObject(Rocks[i].handler)
            Config.Rocks[i].active = false
            Rocks[i].handler = nil
            for m=1, #Config.Rocks[i].minerals, 1 do
                if Config.Rocks[i].minerals[m].active then
                    if DoesEntityExist(Rocks[i].minerals[m].handler) then
                        DeleteObject(Rocks[i].minerals[m].handler)
                        Rocks[i].minerals[m].handler = nil
                        Config.Rocks[i].minerals[m].active = false
                    end
                end
            end
        end
    end
end

function MineItem(index)
    if Config.Rocks[index].GetMineralChance >= math.random(0, 100) then
        
        local old_dist = 100.0
        local closest = nil
        for i=1, #Rocks[index].minerals, 1 do
            if DoesEntityExist(Rocks[index].minerals[i].handler) then
                local dist = GetDistanceBetweenCoords(GetEntityCoords(Rocks[index].minerals[i].handler), GetEntityCoords(PlayerPedId(), true), false)
                if dist < old_dist then
                    old_dist = dist
                    closest = i
                    Config.Rocks[index].minerals[closest].active = false
                end
            end
        end

        local hasMore = false
        for i=1, #Rocks[index].minerals, 1 do
            if Config.Rocks[index].minerals[i].active then
                hasMore = true
                break
            end
        end

        if closest ~= nil then
            TriggerServerEvent("M_MINING:getItem", Config.Rocks, index, closest, hasMore)
        else
            TriggerServerEvent("M_MINING:getItem", Config.Rocks, index, nil, hasMore)
        end

    else
        TriggerServerEvent("M_MINING:getItem", Config.Rocks, index, nil, hasMore)
    end
end

local seconds = 0
local minutes = 0
local timer = 0

RegisterNetEvent('M_MINING:setRocks')
AddEventHandler('M_MINING:setRocks', function(config, ConfigRocks_i, Minerals_i)

    if Config.Rocks[ConfigRocks_i].active and not config[ConfigRocks_i].active then
        Citizen.CreateThread(function() 
            while not Config.Rocks[ConfigRocks_i].active do
                if (GetGameTimer() - timer) > 1000 then
                    timer = GetGameTimer()
                    seconds = seconds + 1
                    if seconds == 60 then
                        seconds = 0
                        minutes = minutes + 1
                        if minutes >= Config.Rocks[ConfigRocks_i].ResetTimer then
                            seconds = 0
                            minutes = 0
                            timer = 0
                            despawn()
                            spawn()
                        end
                    end
                end
                Citizen.Wait(999)
            end
        end)
    end

    Config.Rocks = config

    if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Rocks[ConfigRocks_i].coords, false) <= (Config.GetConfigDistance/2)) then
        RequestNamedPtfxAsset("core")
        while not HasNamedPtfxAssetLoaded("core") do
            Citizen.Wait(0)
        end
        UseParticleFxAssetNextCall("core")
        StartParticleFxNonLoopedAtCoord("bang_concrete", Config.Rocks[ConfigRocks_i].coords, 1.0, 1.0, 1.0, 5.0, false, false)
        UseParticleFxAssetNextCall("core")
        StartParticleFxNonLoopedAtCoord("bang_concrete", Config.Rocks[ConfigRocks_i].coords, 1.0, 1.0, 1.0, 2.0, false, false)
        if Minerals_i ~= nil then
            if DoesEntityExist(Rocks[ConfigRocks_i].minerals[Minerals_i].handler) then
                Config.Rocks[ConfigRocks_i].minerals[Minerals_i].active = false
                UseParticleFxAssetNextCall("core")
                StartParticleFxNonLoopedAtCoord("mel_carmetal", GetEntityCoords(Rocks[ConfigRocks_i].minerals[Minerals_i].handler), 1.0, 1.0, 1.0, 2.0, false, false)
                SetEntityAsMissionEntity(Rocks[ConfigRocks_i].minerals[Minerals_i].handler, true, true)
                DeleteObject(Rocks[ConfigRocks_i].minerals[Minerals_i].handler)
            end
        end
    end
end)



Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0) 
    end
    
    for i=1, #Config.Rocks, 1 do
        CreateBlip(Config.Rocks[i].coords, 570, 5, Locales['mining_blip'])
    end

    CreateBlip(Config.Sell, 605, 5, Locales['sell_mine'])

    Citizen.CreateThread(function()
        while true do
            local sleep = 1000
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Sell, true) <= 3.0 then
                sleep = 0
                TextMsg(Locales['click_sell'])
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('M_MINING:sell')
                end
            end
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Mine, true) <= Config.GetConfigDistance then
                if not inMine then
                    inMine = true
                    TriggerServerEvent("M_MINING:GetConfig")
                end
            else
                if inMine then
                    despawn()
                    inMine = false
                end
            end
            Wait(sleep)
        end
    end)

    while true do

        local CloseObj = 0
        local RockIndex = 0

        for i=1, #Config.Rocks, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Rocks[i].coords, true) <= 2.5 then
                CloseObj = Config.Rocks[i]
                RockIndex = i
                break
            end
        end

        if type(CloseObj) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), CloseObj.coords, true) <= 2.5 do
                Wait(0)
                TextMsg(Locales['hit_rock'])
                if IsControlJustReleased(0, 38) then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance == -1 or distance >= 4.0 then
                        mining = true
                        local model = loadModel(GetHashKey(Config.Objects['pickaxe']))
                        local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                        AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)

                        while mining do
                            Wait(0)
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'))
                            TextMsg(Locales['info_text'])
                            DisableControlAction(0, 24, true)
                            if IsDisabledControlJustReleased(0, 24) then
                                local dict = loadDict('melee@hatchet@streamed_core')
                                TaskPlayAnim(PlayerPedId(), dict, 'plyr_rear_takedown_b', 8.0, -8.0, -1, 2, 0, false, false, false)
                                local timer = GetGameTimer() + 800
                                while GetGameTimer() <= timer do Wait(0) DisableControlAction(0, 24, true) end
                                ClearPedTasks(PlayerPedId())
                                MineItem(RockIndex)
                            elseif IsControlJustReleased(0, 194) then
                                break
                            elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), CloseObj.coords, true) > 3.0 then
                                break
                            end
                        end
                        mining = false
                        DeleteObject(axe)
                    else
                        ESX.ShowNotification(Locales['someone_close'])
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end

        Wait(500)
    end
end)

function loadModel(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

function loadDict(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

function TextMsg(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function CreateBlip(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end