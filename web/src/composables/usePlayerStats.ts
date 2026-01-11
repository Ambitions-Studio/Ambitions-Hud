import { ref } from 'vue'

const health = ref(100)
const armor = ref(0)
const hunger = ref(100)
const thirst = ref(100)
const stamina = ref(100)
const oxygen = ref(100)
const voiceMode = ref('Normal')
const voiceRange = ref(7.0)
const isTalking = ref(false)
const playerId = ref(1)

const handleMessage = (event: MessageEvent) => {
  if (event.data.action === 'updateHealth') {
    health.value = event.data.value
  }
  if (event.data.action === 'updateArmor') {
    armor.value = event.data.value
  }
  if (event.data.action === 'updateHunger') {
    hunger.value = event.data.value
  }
  if (event.data.action === 'updateThirst') {
    thirst.value = event.data.value
  }
  if (event.data.action === 'updateStamina') {
    stamina.value = event.data.value
  }
  if (event.data.action === 'updateOxygen') {
    oxygen.value = event.data.value
  }
  if (event.data.action === 'updatePlayerId') {
    playerId.value = event.data.value
  }
  if (event.data.action === 'updateVoiceMode') {
    voiceMode.value = event.data.mode
    voiceRange.value = event.data.range
  }
  if (event.data.action === 'updateTalking') {
    isTalking.value = event.data.value
  }
}

window.addEventListener('message', handleMessage)

export function usePlayerStats() {
  return {
    health,
    armor,
    hunger,
    thirst,
    stamina,
    oxygen,
    voiceMode,
    voiceRange,
    isTalking,
    playerId,
  }
}