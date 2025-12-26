local lastHealth = -1
local lastArmor = -1
local lastStamina = -1
local lastOxygen = -1

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        local currentHealth = math.floor((GetEntityHealth(playerPed) - 100) / 100 * 100)
        local currentArmor = GetPedArmour(playerPed)
        local currentStamina = 100 - math.floor(GetPlayerSprintStaminaRemaining(PlayerId()))

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

        if currentStamina ~= lastStamina then
            lastStamina = currentStamina
            SendNUIMessage({
                action = 'updateStamina',
                value = currentStamina
            })
        end

        local currentOxygen = 100
        if IsEntityInWater(playerPed) then
            currentOxygen = math.floor(GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10)
            if currentOxygen > 100 then
                currentOxygen = 100
            end
            if currentOxygen < 0 then
                currentOxygen = 0
            end
        end

        if currentOxygen ~= lastOxygen then
            lastOxygen = currentOxygen
            SendNUIMessage({
                action = 'updateOxygen',
                value = currentOxygen
            })
        end

        Wait(100)
    end
end)

RegisterNetEvent('ambitions-hud:client:updateNeed', function(needType, value)
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

RegisterNetEvent('ambitions-hud:client:damagePlayer', function(amount)
    local playerPed = PlayerPedId()
    local currentHealth = GetEntityHealth(playerPed)
    local newHealth = currentHealth - amount
    if newHealth < 0 then
        newHealth = 0
    end
    SetEntityHealth(playerPed, newHealth)
end)
