local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('brainrotduel:checkCooldown', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    
    MySQL.Async.fetchScalar('SELECT timestamp FROM duels WHERE player_id = @player_id AND status = "active"', {
        ['@player_id'] = identifier
    }, function(result)
        if result then
            local currentTime = os.time()
            local cooldownTime = result + Config.DuelCooldown
            
            if currentTime < cooldownTime then
                cb(false, cooldownTime - currentTime)
            else
                cb(true)
            end
        else
            cb(true)
        end
    end)
end)

RegisterNetEvent('brainrotduel:startDuel')
AddEventHandler('brainrotduel:startDuel', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    
    if xPlayer.getAccount('bank').money >= Config.DuelCost then
        xPlayer.removeAccountMoney('bank', Config.DuelCost)
        
        MySQL.Async.execute('INSERT INTO duels (player_id, target_id, timestamp, status) VALUES (@player_id, @target_id, @timestamp, "active")', {
            ['@player_id'] = xPlayer.identifier,
            ['@target_id'] = xTarget.identifier,
            ['@timestamp'] = os.time()
        }, function(rowsChanged)
            TriggerClientEvent('brainrotduel:startDuel', source, target)
            TriggerClientEvent('brainrotduel:startDuel', target, source)
        end)
    else
        TriggerClientEvent('brainrotduel:notify', source, 'Not enough money to start a duel.')
    end
end)

RegisterNetEvent('brainrotduel:duelOutcome')
AddEventHandler('brainrotduel:duelOutcome', function(target, won)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    
    if won then
        xPlayer.addAccountMoney('bank', Config.BrainrotReward)
        TriggerClientEvent('brainrotduel:notify', source, 'You won the duel and received ' .. Config.BrainrotReward .. ' brainrot.')
        TriggerClientEvent('brainrotduel:notify', target, 'You lost the duel.')
    else
        xTarget.addAccountMoney('bank', Config.BrainrotReward)
        TriggerClientEvent('brainrotduel:notify', source, 'You lost the duel.')
        TriggerClientEvent('brainrotduel:notify', target, 'You won the duel and received ' .. Config.BrainrotReward .. ' brainrot.')
    end
    
    MySQL.Async.execute('UPDATE duels SET status = "completed" WHERE player_id = @player_id AND target_id = @target_id AND status = "active"', {
        ['@player_id'] = xPlayer.identifier,
        ['@target_id'] = xTarget.identifier
    })
end)