local isSettingsOpen = false

local function OpenSettings()
    if isSettingsOpen then
        amb.ShowNotification('HUD', 'Les paramètres sont déjà ouverts', 'warning', 3000, 'top-right')
        return
    end
    isSettingsOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openSettings'
    })
end

local function CloseSettings()
    if not isSettingsOpen then return end
    isSettingsOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'closeSettings'
    })
end

RegisterNUICallback('closeSettings', function(_, cb)
    CloseSettings()
    cb('ok')
end)

RegisterCommand('hud', function()
    OpenSettings()
end, false)
