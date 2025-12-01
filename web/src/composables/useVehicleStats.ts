import { ref } from 'vue'

const speed = ref(0)
const fuel = ref(100)
const seatbelt = ref(false)
const engineDamage = ref(0)
const headlights = ref<'off' | 'on' | 'highbeam'>('off')
const indicator = ref<'off' | 'left' | 'right' | 'hazard'>('off')
const isInVehicle = ref(false)

const handleMessage = (event: MessageEvent) => {
  if (event.data.action === 'updateInVehicle') {
    isInVehicle.value = event.data.value
  }
}

window.addEventListener('message', handleMessage)

export function useVehicleStats() {
  return {
    speed,
    fuel,
    seatbelt,
    engineDamage,
    headlights,
    indicator,
    isInVehicle,
  }
}
