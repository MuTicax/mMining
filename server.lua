ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('M_MINING:getItem')
AddEventHandler('M_MINING:getItem', function(cfg, ConfigRocks_i, Minerals_i, hasMore)
    
    local xPlayer = ESX.GetPlayerFromId(source)
    Config.Rocks = cfg
    if not hasMore and Config.Rocks[ConfigRocks_i].active then
        Config.Rocks[ConfigRocks_i].active = false
    end

    if Minerals_i == nil then
        xPlayer.addInventoryItem("stone", 1)
        TriggerClientEvent("M_MINING:setRocks", -1, Config.Rocks, ConfigRocks_i, nil)
    else
        xPlayer.addInventoryItem(Config.Items[""..Config.Rocks[ConfigRocks_i].mineral..""], 1)
        TriggerClientEvent("M_MINING:setRocks", -1, Config.Rocks, ConfigRocks_i, Minerals_i)
    end

end)

RegisterServerEvent('M_MINING:GetConfig')
AddEventHandler('M_MINING:GetConfig', function()
    local src = source
    TriggerClientEvent("M_MINING:SetLoad", src, Config.Rocks)
end)

RegisterServerEvent('M_MINING:sell')
AddEventHandler('M_MINING:sell', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    for k, v in pairs(Config.SellPrices) do
        if xPlayer.getInventoryItem(k).count >= 1 then
            local pay = 0
            for i = 1, xPlayer.getInventoryItem(k).count do
                pay = pay + math.random(v[1], v[2])
            end
            xPlayer.addMoney(pay)
            TriggerClientEvent('esx:showNotification', xPlayer.source, (Locales['you_sold']):format(xPlayer.getInventoryItem(k).count, ESX.GetItemLabel(k), pay))
            xPlayer.removeInventoryItem(k, xPlayer.getInventoryItem(k).count)
        end
    end
end)