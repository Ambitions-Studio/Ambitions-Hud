local seatbeltOn = false

RegisterKeyMapping('toggleSeatbelt', 'Attacher/Détacher la ceinture', 'keyboard', hudConfig.seatbeltKey)

RegisterCommand('toggleSeatbelt', function()
    local playerPed = PlayerPedId()
    if not IsPedInAnyVehicle(playerPed, false) then return end

    seatbeltOn = not seatbeltOn

    if seatbeltOn then
        SetPedConfigFlag(playerPed, 32, false)
        SetFlyThroughWindscreenParams(10000.0, 10000.0, 10000.0, 10000.0)
    else
        SetPedConfigFlag(playerPed, 32, true)
        ResetFlyThroughWindscreenParams()
    end

    SendNUIMessage({
        action = 'updateSeatbelt',
        value = seatbeltOn
    })
end, false)

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        if IsPedInAnyVehicle(playerPed, false) then
            if seatbeltOn then
                DisableControlAction(0, 75, true)
                DisableControlAction(0, 231, true)
            end
            Wait(0)
        else
            if seatbeltOn then
                seatbeltOn = false
                SetPedConfigFlag(playerPed, 32, true)
                ResetFlyThroughWindscreenParams()
                SendNUIMessage({
                    action = 'updateSeatbelt',
                    value = false
                })
            end
            Wait(500)
        end
    end
end)
