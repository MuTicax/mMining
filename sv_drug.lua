RegisterServerEvent("ventedrogue")
AddEventHandler("ventedrogue", function(item, tonta, label, money, count)

    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end
    if cops >= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if item ~= nil then 
			xPlayer.removeInventoryItem(item, count)
			-- xPlayer.addMoney(money)
            xPlayer.addAccountMoney('money', tonumber(money))
            TriggerClientEvent('esx:showNotification', source, "~s~Merci beaucoup pour "..tonta.." ~b~"..label.."~s~ ~b~+"..money.."$~s~.")
		end
    else
        TriggerClientEvent('cancelvente', source)
    end
end)

ESX.RegisterServerCallback("esx:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil then
		cb({inventory = targetXPlayer.inventory})
	else
		cb(nil)
	end
end)

RegisterServerEvent('activedrogue')
AddEventHandler('activedrogue', function()
    TriggerClientEvent('copenservice', source)
end)