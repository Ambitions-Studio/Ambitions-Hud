local lastInVehicle = false
local lastSpeed = -1
local speedMultiplier = hudConfig.speedUnit == 'mph' and 2.236936 or 3.6
local speedUnitSent = false

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local inVehicle = IsPedInAnyVehicle(playerPed, false)

        if inVehicle ~= lastInVehicle then
            lastInVehicle = inVehicle
            SendNUIMessage({
                action = 'updateInVehicle',
                value = inVehicle
            })

            if not inVehicle then
                lastSpeed = -1
            end
        end

        if not speedUnitSent then
            SendNUIMessage({
                action = 'updateSpeedUnit',
                value = hudConfig.speedUnit
            })
            speedUnitSent = true
        end

        if inVehicle then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local currentSpeed = math.floor(GetEntitySpeed(vehicle) * speedMultiplier)

            if currentSpeed ~= lastSpeed then
                lastSpeed = currentSpeed
                SendNUIMessage({
                    action = 'updateSpeed',
                    value = currentSpeed
                })
            end

            Wait(50)
        else
            Wait(500)
        end
    end
end)
