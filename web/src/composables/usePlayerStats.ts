import { ref, onMounted, onUnmounted } from 'vue'

const health = ref(100)
const armor = ref(0)
const hunger = ref(100)
const thirst = ref(100)
const stamina = ref(100)
const oxygen = ref(100)
const voice = ref<'whisper' | 'normal' | 'shout' | 'megaphone'>('normal')
const isTalking = ref(false)
const playerId = ref(1)

const handleMessage = (event: MessageEvent) => {
  if (event.data.action === 'updateHealth') {
    health.value = event.data.value
  }
  if (event.data.action === 'updateArmor') {
    armor.value = event.data.value
  }
}

let isListenerRegistered = false

export function usePlayerStats() {
  onMounted(() => {
    if (!isListenerRegistered) {
      window.addEventListener('message', handleMessage)
      isListenerRegistered = true
    }
  })

  onUnmounted(() => {
    window.removeEventListener('message', handleMessage)
    isListenerRegistered = false
  })

  return {
    health,
    armor,
    hunger,
    thirst,
    stamina,
    oxygen,
    voice,
    isTalking,
    playerId,
  }
}
