local lastHealth = -1

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local currentHealth = math.floor((GetEntityHealth(playerPed) - 100) / 100 * 100)

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

        Wait(250)
    end
end)
