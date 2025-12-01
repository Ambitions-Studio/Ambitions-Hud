local lastHealth = -1
local lastArmor = -1

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local currentHealth = math.floor((GetEntityHealth(playerPed) - 100) / 100 * 100)
        local currentArmor = GetPedArmour(playerPed)

        if currentHealth < 0 then
            currentHealth = 0
        end

        if currentHealth ~= lastHealth then
            lastHealth = currentHealth
            SendNUIMessage({
                action = 'updateHealth',
                value = currentHealth
            })
        end

        if currentArmor ~= lastArmor then
            lastArmor = currentArmor
            SendNUIMessage({
                action = 'updateArmor',
                value = currentArmor
            })
        end

        Wait(250)
    end
end)

RegisterNetEvent('ambitions:client:updateNeed', function(needType, value)
    if needType == 'hunger' then
        SendNUIMessage({
            action = 'updateHunger',
            value = value
        })
    elseif needType == 'thirst' then
        SendNUIMessage({
            action = 'updateThirst',
            value = value
        })
    end
end)

RegisterNetEvent('ambitions:client:damagePlayer', function(amount)
    local playerPed = PlayerPedId()
    local currentHealth = GetEntityHealth(playerPed)
    local newHealth = currentHealth - amount
    if newHealth < 0 then
        newHealth = 0
    end
    SetEntityHealth(playerPed, newHealth)
end)
