local lastInVehicle = false
local lastSpeed = -1
local lastFuel = -1
local speedMultiplier = hudConfig.speedUnit == 'mph' and 2.236936 or 3.6
local speedUnitSent = false

local function GetFuelLevel(vehicle)
    if hudConfig.fuelScript == 'legacy' then
        return exports['LegacyFuel']:GetFuel(vehicle) or 0
    elseif hudConfig.fuelScript == 'ox' then
        return exports['ox_fuel']:GetFuel(vehicle) or 0
    elseif hudConfig.fuelScript == 'ambitions' then
        return exports['Ambitions-Fuel']:GetFuel(vehicle) or 0
    end
    return 0
end

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
                lastFuel = -1
            end
        end

        if not speedUnitSent then
            SendNUIMessage({
                action = 'updateSpeedUnit',
                value = hudConfig.speedUnit
            })
            SendNUIMessage({
                action = 'updateSeatbeltSoundVolume',
                value = hudConfig.seatbeltSoundVolume
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

            local currentFuel = math.floor(GetFuelLevel(vehicle))
            if currentFuel ~= lastFuel then
                lastFuel = currentFuel
                SendNUIMessage({
                    action = 'updateFuel',
                    value = currentFuel
                })
            end

            Wait(50)
        else
            Wait(500)
        end
    end
end)
