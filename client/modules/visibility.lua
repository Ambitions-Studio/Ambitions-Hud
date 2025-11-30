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

exports('ShowHUD', ShowHUD)
exports('HideHUD', HideHUD)
