pif not hudConfig.debugMode then return end

RegisterCommand('debugHealthHud', function(_, args)
    local value = tonumber(args[1])
    if not value then
        amb.ShowNotification('HUD Debug', 'Valeur invalide', 'error', 3000, 'top-right')
        return
    end
    if value < 0 then value = 0 end
    if value > 100 then value = 100 end
    SendNUIMessage({
        action = 'updateHealth',
        value = value
    })
    amb.ShowNotification('HUD Debug', 'Vie définie à ' .. value, 'success', 3000, 'top-right')
end, false)

RegisterCommand('debugArmorHud', function(_, args)
    local value = tonumber(args[1])
    if not value then
        amb.ShowNotification('HUD Debug', 'Valeur invalide', 'error', 3000, 'top-right')
        return
    end
    if value < 0 then value = 0 end
    if value > 100 then value = 100 end
    SendNUIMessage({
        action = 'updateArmor',
        value = value
    })
    amb.ShowNotification('HUD Debug', 'Armure définie à ' .. value, 'success', 3000, 'top-right')
end, false)
