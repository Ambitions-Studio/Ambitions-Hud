local lastHealth = -1
local lastArmor = -1
local lastStamina = -1
local lastOxygen = -1
local playerIdSent = false

CreateThread(function()
    local shape = hudConfig.minimapShape or 'square'
    local textureName = shape == 'circle' and 'circlemap' or 'squaremap'
    local clipType = shape == 'circle' and 1 or 0

    while not HasStreamedTextureDictLoaded(textureName) do
        RequestStreamedTextureDict(textureName, false)
        Wait(100)
    end

    AddReplaceTexture('platform:/textures/graphics', 'radarmasksm', textureName, 'radarmasksm')
    AddReplaceTexture('platform:/textures/graphics', 'radarmask1g', textureName, 'radarmasksm')
    SetMinimapClipType(clipType)
    SetBigmapActive(true, false)
    Wait(0)
    SetBigmapActive(false, false)
end)

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        if not playerIdSent then
            local serverId = GetPlayerServerId(PlayerId())
            if serverId > 0 then
                SendNUIMessage({
                    action = 'updatePlayerId',
                    value = serverId
                })
                playerIdSent = true
            end
        end
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
