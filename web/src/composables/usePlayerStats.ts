import { ref } from 'vue'

const health = ref(100)
const armor = ref(100)
const hunger = ref(100)
const thirst = ref(100)
const stamina = ref(100)
const oxygen = ref(100)
const voice = ref<'whisper' | 'normal' | 'shout' | 'megaphone'>('normal')
const isTalking = ref(false)
const playerId = ref(1)

export function usePlayerStats() {
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
