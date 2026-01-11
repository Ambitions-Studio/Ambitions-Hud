local currentIndicator = 'off'
local lastVehicle = nil

RegisterKeyMapping('indicatorLeft', 'Clignotant gauche', 'keyboard', hudConfig.indicatorLeftKey)
RegisterKeyMapping('indicatorRight', 'Clignotant droit', 'keyboard', hudConfig.indicatorRightKey)
RegisterKeyMapping('indicatorHazard', 'Warnings', 'keyboard', hudConfig.indicatorHazardKey)

local function SetIndicatorState(vehicle, state)
    if state == 'left' then
        SetVehicleIndicatorLights(vehicle, 1, true)
        SetVehicleIndicatorLights(vehicle, 0, false)
    elseif state == 'right' then
        SetVehicleIndicatorLights(vehicle, 0, true)
        SetVehicleIndicatorLights(vehicle, 1, false)
    elseif state == 'hazard' then
        SetVehicleIndicatorLights(vehicle, 0, true)
        SetVehicleIndicatorLights(vehicle, 1, true)
    else
        SetVehicleIndicatorLights(vehicle, 0, false)
        SetVehicleIndicatorLights(vehicle, 1, false)
    end
end

local function UpdateIndicator(newState)
    local playerPed = PlayerPedId()
    if not IsPedInAnyVehicle(playerPed, false) then return end

    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if currentIndicator == newState then
        currentIndicator = 'off'
    else
        currentIndicator = newState
    end

    SetIndicatorState(vehicle, currentIndicator)

    SendNUIMessage({
        action = 'updateIndicator',
        value = currentIndicator
    })
end

RegisterCommand('indicatorLeft', function()
    UpdateIndicator('left')
end, false)

RegisterCommand('indicatorRight', function()
    UpdateIndicator('right')
end, false)

RegisterCommand('indicatorHazard', function()
    UpdateIndicator('hazard')
end, false)

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if vehicle ~= lastVehicle then
                lastVehicle = vehicle
                currentIndicator = 'off'
                SetIndicatorState(vehicle, 'off')
                SendNUIMessage({
                    action = 'updateIndicator',
                    value = 'off'
                })
            end

            Wait(100)
        else
            if lastVehicle ~= nil then
                lastVehicle = nil
                currentIndicator = 'off'
                SendNUIMessage({
                    action = 'updateIndicator',
                    value = 'off'
                })
            end
            Wait(500)
        end
    end
end)
