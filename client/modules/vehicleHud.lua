local lastInVehicle = false

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
        end

        Wait(inVehicle and 100 or 500)
    end
end)
