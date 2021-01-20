ESX = nil
local shopItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()

	MySQL.Async.fetchAll('SELECT * FROM weashops', {}, function(result)
		for i=1, #result, 1 do
			if shopItems[result[i].zone] == nil then
				shopItems[result[i].zone] = {}
			end

			table.insert(shopItems[result[i].zone], {
				item  = result[i].item,
				price = result[i].price,
				label = ESX.GetWeaponLabel(result[i].item)
			})
		end

		TriggerClientEvent('esx_weaponshop:sendShop', -1, shopItems)
	end)

end)

ESX.RegisterServerCallback('esx_weaponshop:getShop', function(source, cb)
	cb(shopItems)
end)

ESX.RegisterServerCallback('esx_weaponshop:buyLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	print("Dooit Captain!")
	if xPlayer.getAccount('bank').money >= Config.LicensePrice then
		xPlayer.removeAccountMoney('bank', Config.LicensePrice)

		TriggerEvent('esx_license:addLicense', source, 'weapon', function()
			cb(true)
		end)
	else
		xPlayer.showNotification(_U('not_enough'))
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_weaponshop:buyWeapon', function(source, cb, weaponName, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = GetPrice(weaponName, zone)

	if price == 0 then
		print(('esx_weaponshop: %s attempted to buy an unknown weapon!'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.hasWeapon(weaponName) then
			
			--[[
			print(('esx_weaponshop: %s wants a loop!'):format(xPlayer.identifier))
			--local ammo = xPlayer.GetWeapon(weaponName).ammo
			for i=1, xPlayer.inventory.weapons, 1 do
				local weapon = inventory.weapons[i]
	
				table.insert(elements, {
					label = weapon.label .. ' [' .. weapon.ammo .. ']',
					type  = 'item_weapon',
					value = weapon.name,
					ammo  = weapon.ammo
				})
				print(inventory.weapons[i])
			end
			--]]
			print("pre vars")
			local playerPed  = GetPlayerPed(-1)
			local weaponList = ESX.GetWeaponList()
			local a = xPlayer.inventory
			print(a)
			--for i, in weaponList do print weaponlist[i] end

			--[[print("Ped = ", playerPed, " and weaponList = ", weaponList)
			for key,value in weaponList do
			--for i,v in ipairs(weaponList) do
				print("i=", i, " and weaponlist[", i, "] = ", weaponlist[i])
				local weaponHash = GetHashKey(weaponList[i].name)
				local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
				print('hash:', weaponHash, ' ammo: ', ammo)
			end
			print('esx_weaponshop: We\'ve made a variable') --]]
			
			xPlayer.removeWeapon(weaponName)
			print('esx_weaponshop: This weapon got removed!')
			xPlayer.addWeapon(weaponName, 200)
			--GiveWeaponToPed(xPlayer, weaponName, 100, false, false) -- Gonna try this next
			--AddAmmoToPed(xPlayer, GetWeaponLabel(weaponName), 100)
			print(('esx_weaponshop: And then %s did!! addWeapon and removing the weapon was used'):format(xPlayer.identifier))
			--xPlayer.addWeapon(weaponName, 50)
			--xPlayer.showNotification(_U('already_owned'))
			cb(true)
		else
			if zone == 'BlackWeashop' then
				if xPlayer.getAccount('black_money').money >= price then
					xPlayer.removeAccountMoney('black_money', price)
					xPlayer.addWeapon(weaponName, 42)
	
					cb(true)
				else
					xPlayer.showNotification(_U('not_enough_black'))
					cb(false)
				end
			else
				if xPlayer.getAccount('bank').money >= price then
					print(('esx_weaponshop: %s is buyin a fresh gat!'):format(xPlayer.identifier))
					xPlayer.removeAccountMoney('bank', price)
					xPlayer.addWeapon(weaponName, 42)
	
					cb(true)
				else
					xPlayer.showNotification(_U('not_enough'))
					cb(false)
				end
			end
		end
	end
end)

function GetPrice(weaponName, zone)
	local price = MySQL.Sync.fetchScalar('SELECT price FROM weashops WHERE zone = @zone AND item = @item', {
		['@zone'] = zone,
		['@item'] = weaponName
	})

	if price then
		return price
	else
		return 0
	end
end
