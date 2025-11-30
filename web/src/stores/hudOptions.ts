import { defineStore } from 'pinia'
import { ref, reactive } from 'vue'

interface Position {
  x: number
  y: number
}

export const useHudOptionsStore = defineStore('hudOptions', () => {
  const visibility = reactive({
    player: {
      health: true,
      armor: true,
      hunger: true,
      thirst: true,
      stamina: true,
      oxygen: true,
      voice: true,
      playerId: true,
    },
    vehicle: {
      speedometer: true,
      fuel: true,
      seatbelt: true,
      engine: true,
      headlights: true,
      indicators: true,
      weather: true,
      compass: true,
      streetName: true,
    },
  })

  const colors = reactive({
    player: {
      health: '#ef4444',
      armor: '#3b82f6',
      hunger: '#f97316',
      thirst: '#06b6d4',
      stamina: '#facc15',
      oxygen: '#818cf8',
      voice: '#e5e5e5',
    },
    vehicle: {
      speedometerActive: '#22d3ee',
      speedometerInactive: '#ffffff80',
      fuel: '#d97706',
      weather: '#ffffff',
      streetName: '#ffffff',
    },
  })

  const positions = reactive({
    player: {
      health: { x: 0, y: 0 } as Position,
      armor: { x: 0, y: 0 } as Position,
      hunger: { x: 0, y: 0 } as Position,
      thirst: { x: 0, y: 0 } as Position,
      stamina: { x: 0, y: 0 } as Position,
      oxygen: { x: 0, y: 0 } as Position,
      voice: { x: 0, y: 0 } as Position,
      playerId: { x: 0, y: 0 } as Position,
    },
    vehicle: {
      speedometer: { x: 0, y: 0 } as Position,
      speedometerUnit: { x: 0, y: 0 } as Position,
      fuel: { x: 0, y: 0 } as Position,
      seatbelt: { x: 0, y: 0 } as Position,
      engine: { x: 0, y: 0 } as Position,
      headlights: { x: 0, y: 0 } as Position,
      indicators: { x: 0, y: 0 } as Position,
      weather: { x: 0, y: 0 } as Position,
      compass: { x: 0, y: 0 } as Position,
      streetName: { x: 0, y: 0 } as Position,
    },
  })

  const sizes = reactive({
    player: {
      health: 1,
      armor: 1,
      hunger: 1,
      thirst: 1,
      stamina: 1,
      oxygen: 1,
      voice: 1,
      playerId: 1,
    },
    vehicle: {
      speedometer: 1,
      speedometerUnit: 1,
      fuel: 1,
      seatbelt: 1,
      engine: 1,
      headlights: 1,
      indicators: 1,
      weather: 1,
      compass: 1,
      streetName: 1,
    },
  })

  const positionsBackup = ref<typeof positions | null>(null)
  const sizesBackup = ref<typeof sizes | null>(null)
  const visibilityBackup = ref<typeof visibility | null>(null)
  const colorsBackup = ref<typeof colors | null>(null)

  const isPositionEditMode = ref(false)
  const isSizeEditMode = ref(false)
  const isSettingsHidden = ref(false)

  const startPositionEdit = () => {
    isPositionEditMode.value = true
    isSettingsHidden.value = true
  }

  const cancelPositionEdit = () => {
    if (positionsBackup.value) {
      Object.assign(positions.player, positionsBackup.value.player)
      Object.assign(positions.vehicle, positionsBackup.value.vehicle)
    }
    isPositionEditMode.value = false
    isSettingsHidden.value = false
  }

  const validatePositionEdit = () => {
    isPositionEditMode.value = false
    isSettingsHidden.value = false
  }

  const startSizeEdit = () => {
    isSizeEditMode.value = true
  }

  const cancelSizeEdit = () => {
    if (sizesBackup.value) {
      Object.assign(sizes.player, sizesBackup.value.player)
      Object.assign(sizes.vehicle, sizesBackup.value.vehicle)
    }
    isSizeEditMode.value = false
  }

  const validateSizeEdit = () => {
    isSizeEditMode.value = false
  }

  const backupSettings = () => {
    visibilityBackup.value = JSON.parse(JSON.stringify(visibility))
    colorsBackup.value = JSON.parse(JSON.stringify(colors))
    positionsBackup.value = JSON.parse(JSON.stringify(positions))
    sizesBackup.value = JSON.parse(JSON.stringify(sizes))
  }

  const restoreSettings = () => {
    if (visibilityBackup.value) {
      Object.assign(visibility.player, visibilityBackup.value.player)
      Object.assign(visibility.vehicle, visibilityBackup.value.vehicle)
    }
    if (colorsBackup.value) {
      Object.assign(colors.player, colorsBackup.value.player)
      Object.assign(colors.vehicle, colorsBackup.value.vehicle)
    }
    if (positionsBackup.value) {
      Object.assign(positions.player, positionsBackup.value.player)
      Object.assign(positions.vehicle, positionsBackup.value.vehicle)
    }
    if (sizesBackup.value) {
      Object.assign(sizes.player, sizesBackup.value.player)
      Object.assign(sizes.vehicle, sizesBackup.value.vehicle)
    }
  }

  const clearBackups = () => {
    visibilityBackup.value = null
    colorsBackup.value = null
    positionsBackup.value = null
    sizesBackup.value = null
  }

  return {
    visibility,
    colors,
    positions,
    sizes,
    isPositionEditMode,
    isSizeEditMode,
    isSettingsHidden,
    startPositionEdit,
    cancelPositionEdit,
    validatePositionEdit,
    startSizeEdit,
    cancelSizeEdit,
    validateSizeEdit,
    backupSettings,
    restoreSettings,
    clearBackups,
  }
})
