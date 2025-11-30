local function ShowHUD()
    SendNUIMessage({
        action = 'showHud',
        show = true
    })
end

local function HideHUD()
    SendNUIMessage({
        action = 'showHud',
        show = false
    })
end

local function SendHudConfig()
    SendNUIMessage({
        action = 'setHudConfig',
        hudStats = hudConfig.hudStats
    })
end

CreateThread(function()
    SendHudConfig()
end)

exports('ShowHUD', ShowHUD)
exports('HideHUD', HideHUD)
