import { ref } from 'vue'

const speed = ref(0)
const fuel = ref(100)
const seatbelt = ref(false)
const engineDamage = ref(0)
const headlights = ref<'off' | 'on' | 'highbeam'>('off')
const indicator = ref<'off' | 'left' | 'right' | 'hazard'>('off')
const isInVehicle = ref(false)
const speedUnit = ref<'kmh' | 'mph'>('kmh')

const handleMessage = (event: MessageEvent) => {
  if (event.data.action === 'updateInVehicle') {
    isInVehicle.value = event.data.value
  }
  if (event.data.action === 'updateSpeed') {
    speed.value = event.data.value
  }
  if (event.data.action === 'updateSpeedUnit') {
    speedUnit.value = event.data.value
  }
  if (event.data.action === 'updateSeatbelt') {
    seatbelt.value = event.data.value
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
    speedUnit,
  }
}
