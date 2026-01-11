local lastHeadlightState = 'off'

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local lightsOn, highbeamsOn = GetVehicleLightsState(vehicle)

            local currentState = 'off'
            if IsVehicleEngineOn(vehicle) then
                if highbeamsOn then
                    currentState = 'highbeam'
                elseif IsVehicleLightOn(vehicle) or lightsOn then
                    currentState = 'on'
                end
            end

            if currentState ~= lastHeadlightState then
                lastHeadlightState = currentState
                SendNUIMessage({
                    action = 'updateHeadlights',
                    value = currentState
                })
            end

            Wait(100)
        else
            if lastHeadlightState ~= 'off' then
                lastHeadlightState = 'off'
                SendNUIMessage({
                    action = 'updateHeadlights',
                    value = 'off'
                })
            end
            Wait(500)
        end
    end
end)
