
local QBCore = exports['qb-core']:GetCoreObject()
local SystemIsEnable = Config.EnableOnStart
local isAEventEnable = false
RegisterNetEvent('tac-pedloot:server:onjoin', function()
    local src = source
    if SystemIsEnable then 
        TriggerClientEvent('tac-pedloot:client:enable', src) 
    end
end)
RegisterServerEvent('tac-pedloot:server:enable', function(eventname)
    SystemIsEnable = true
end)
RegisterServerEvent('tac-pedloot:server:disable', function(eventname)
    SystemIsEnable = false
end)
RegisterServerEvent('tac-pedloot:server:enableEvent', function()
    SystemIsEnable = true
    isAEventEnable = true
end)
RegisterServerEvent('tac-pedloot:server:disableEvent', function()
    isAEventEnable = false
end)
RegisterNetEvent('tac-pedloot:server:getloot', function(entity)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    TriggerClientEvent('tac-pedloot:client:deleteped', -1, entity)
    
    if not isAEventEnable then
        if Config.UseCash and math.random(1,100) < Config.CashChance then
            Player.Functions.AddMoney(Config.CashType, Config.CashReward)
        end
        local item = Config.Items.Basic[math.random(1, #Config.Items.Basic)]
        if item.name then
            Player.Functions.AddItem(item.name, 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'add')
        end
        if Config.UseNormalWeaponLoot or Config.UseHeavyWeaponLoot then
            local ammo = Config.Items.Ammo[math.random(1, #Config.Items.Ammo)]
            if math.random(1, 100) <= 10 then -- chance for items
                Player.Functions.AddItem(ammo.name, 1, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ammo.name], 'add')
            end
        end
        if Config.UseNormalWeaponLoot then
            local normalWeapon = Config.Items.NormalWeapons[math.random(1, #Config.Items.NormalWeapons)]
            if math.random(1, 100) <= 5 then  -- chance for items
                if normalWeapon.name then
                    Player.Functions.AddItem(normalWeapon.name, 1, false, nil)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[normalWeapon.name], 'add')
                end
            end
        end
        if Config.UseHeavyWeaponLoot then
            local heavyWeapon = Config.Items.HeavyWeapons[math.random(1, #Config.Items.HeavyWeapons)]
            if math.random(1, 100) <= 1 then -- chance for items
                if heavyWeapon.name then
                    Player.Functions.AddItem(heavyWeapon.name, 1, false, nil)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[heavyWeapon.name], 'add')
                end
            end
        end
    else
        local ammo = Config.Items.Ammo[math.random(1, #Config.Items.Ammo)]
        if math.random(1, 100) <= 10 then -- chance for items
            Player.Functions.AddItem(ammo.name, 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ammo.name], 'add', 1)
        end
        local normalWeapon = Config.Items.NormalWeapons[math.random(1, #Config.Items.NormalWeapons)]
        if math.random(1, 100) <= 5 then -- chance for items
            if normalWeapon.name then
                Player.Functions.AddItem(normalWeapon.name, 1, false, nil)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[normalWeapon.name], 'add', 1)
            end
        end
        local heavyWeapon = Config.Items.HeavyWeapons[math.random(1, #Config.Items.HeavyWeapons)]
        if math.random(1, 100) <= 1 then -- chance for items
            if heavyWeapon.name then
                Player.Functions.AddItem(heavyWeapon.name, 1, false, nil)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[heavyWeapon.name], 'add', 1)
            end
        end

    end
end)
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        if SystemIsEnable then
            TriggerClientEvent('tac-pedloot:client:enable', -1)
        else
            TriggerClientEvent('tac-pedloot:client:disable', -1)
        end
    end
end)
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        SystemIsEnable = false
        TriggerClientEvent('tac-pedloot:client:disable', -1)
    end
end)
QBCore.Commands.Add(Config.Commands.toggle, Lang:t('command.start_stop', {state = Lang:t('command.on_or_off')}), {}, false, function(source, args)
    if tostring(args[1]) == 'On' then
        SystemIsEnable = true
        TriggerClientEvent('tac-pedloot:client:enable', -1)
    end
    if tostring(args[1]) == 'Off' then
        SystemIsEnable = false
        TriggerClientEvent('tac-pedloot:client:disable', -1)
    end
end, 'admin')
