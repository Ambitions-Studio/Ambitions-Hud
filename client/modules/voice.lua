if hudConfig.voiceScript == 'none' then return end

local voiceModes = {}
local currentModeIndex = 1
local lastTalkingState = false

local function InitializePmaVoice()
    local defaultMode = GetConvarInt('voice_defaultVoiceMode', 2)

    TriggerEvent("pma-voice:settingsCallback", function(settings)
        voiceModes = settings.voiceModes

        currentModeIndex = defaultMode
        local mode = voiceModes[currentModeIndex]

        if mode then
            SendNUIMessage({
                action = 'updateVoiceMode',
                index = currentModeIndex,
                mode = mode[2],
                range = mode[1]
            })
        end
    end)

    AddEventHandler('pma-voice:setTalkingMode', function(newModeIndex)
        currentModeIndex = newModeIndex
        local mode = voiceModes[newModeIndex]

        if mode then
            SendNUIMessage({
                action = 'updateVoiceMode',
                index = newModeIndex,
                mode = mode[2],
                range = mode[1]
            })
        end
    end)
end

local function InitializeVoice()
    if hudConfig.voiceScript == 'pma' then
        InitializePmaVoice()
    end
end

CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(100)
    end

    InitializeVoice()

    while true do
        local isTalking = NetworkIsPlayerTalking(PlayerId())

        if isTalking ~= lastTalkingState then
            lastTalkingState = isTalking
            SendNUIMessage({
                action = 'updateTalking',
                value = isTalking
            })
        end

        Wait(100)
    end
end)
