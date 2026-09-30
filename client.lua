local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('brainrotduel:startDuel')
AddEventHandler('brainrotduel:startDuel', function(target)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
    
    -- Animation and effects for the duel
    TaskTurnPedToFaceEntity(playerPed, targetPed, -1)
    TaskTurnPedToFaceEntity(targetPed, playerPed, -1)
    
    -- Simulate the duel outcome
    Citizen.Wait(5000)
    
    local outcome = math.random(1, 2)
    if outcome == 1 then
        TriggerServerEvent('brainrotduel:duelOutcome', target, true)
    else
        TriggerServerEvent('brainrotduel:duelOutcome', target, false)
    end
end)

RegisterNetEvent('brainrotduel:notify')
AddEventHandler('brainrotduel:notify', function(message)
    ESX.ShowNotification(message)
end)