<script setup lang="ts">
import { computed, ref } from 'vue'
import HexagonStat from '@/components/hud/HexagonStat.vue'
import HexagonId from '@/components/hud/HexagonId.vue'
import { usePlayerStats } from '@/composables/usePlayerStats'
import { useHudOptionsStore } from '@/stores/hudOptions'
import { mdiHeartPulse, mdiFoodDrumstick, mdiCupWater, mdiShieldHalfFull, mdiRun, mdiLungs, mdiMicrophone } from '@/icons'

const { health, armor, hunger, thirst, stamina, oxygen, voice, isTalking, playerId } = usePlayerStats()
const store = useHudOptionsStore()

const isEditMode = computed(() => store.isPositionEditMode || store.isSizeEditMode)

const isDraggingHealth = ref(false)
const dragOffset = ref({ x: 0, y: 0 })

const startDragHealth = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingHealth.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  dragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragHealth)
  window.addEventListener('mouseup', stopDragHealth)
}

const onDragHealth = (e: MouseEvent) => {
  if (!isDraggingHealth.value) return
  store.positions.player.health = {
    x: e.clientX - dragOffset.value.x,
    y: e.clientY - dragOffset.value.y
  }
}

const stopDragHealth = () => {
  isDraggingHealth.value = false
  window.removeEventListener('mousemove', onDragHealth)
  window.removeEventListener('mouseup', stopDragHealth)
}

const isHealthMoved = computed(() => store.positions.player.health.x !== 0 || store.positions.player.health.y !== 0)

const isDraggingArmor = ref(false)
const armorDragOffset = ref({ x: 0, y: 0 })

const startDragArmor = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingArmor.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  armorDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragArmor)
  window.addEventListener('mouseup', stopDragArmor)
}

const onDragArmor = (e: MouseEvent) => {
  if (!isDraggingArmor.value) return
  store.positions.player.armor = {
    x: e.clientX - armorDragOffset.value.x,
    y: e.clientY - armorDragOffset.value.y
  }
}

const stopDragArmor = () => {
  isDraggingArmor.value = false
  window.removeEventListener('mousemove', onDragArmor)
  window.removeEventListener('mouseup', stopDragArmor)
}

const isArmorMoved = computed(() => store.positions.player.armor.x !== 0 || store.positions.player.armor.y !== 0)

const isDraggingHunger = ref(false)
const hungerDragOffset = ref({ x: 0, y: 0 })

const startDragHunger = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingHunger.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  hungerDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragHunger)
  window.addEventListener('mouseup', stopDragHunger)
}

const onDragHunger = (e: MouseEvent) => {
  if (!isDraggingHunger.value) return
  store.positions.player.hunger = {
    x: e.clientX - hungerDragOffset.value.x,
    y: e.clientY - hungerDragOffset.value.y
  }
}

const stopDragHunger = () => {
  isDraggingHunger.value = false
  window.removeEventListener('mousemove', onDragHunger)
  window.removeEventListener('mouseup', stopDragHunger)
}

const isHungerMoved = computed(() => store.positions.player.hunger.x !== 0 || store.positions.player.hunger.y !== 0)

const isDraggingThirst = ref(false)
const thirstDragOffset = ref({ x: 0, y: 0 })

const startDragThirst = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingThirst.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  thirstDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragThirst)
  window.addEventListener('mouseup', stopDragThirst)
}

const onDragThirst = (e: MouseEvent) => {
  if (!isDraggingThirst.value) return
  store.positions.player.thirst = {
    x: e.clientX - thirstDragOffset.value.x,
    y: e.clientY - thirstDragOffset.value.y
  }
}

const stopDragThirst = () => {
  isDraggingThirst.value = false
  window.removeEventListener('mousemove', onDragThirst)
  window.removeEventListener('mouseup', stopDragThirst)
}

const isThirstMoved = computed(() => store.positions.player.thirst.x !== 0 || store.positions.player.thirst.y !== 0)

const isDraggingVoice = ref(false)
const voiceDragOffset = ref({ x: 0, y: 0 })

const startDragVoice = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingVoice.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  voiceDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragVoice)
  window.addEventListener('mouseup', stopDragVoice)
}

const onDragVoice = (e: MouseEvent) => {
  if (!isDraggingVoice.value) return
  store.positions.player.voice = {
    x: e.clientX - voiceDragOffset.value.x,
    y: e.clientY - voiceDragOffset.value.y
  }
}

const stopDragVoice = () => {
  isDraggingVoice.value = false
  window.removeEventListener('mousemove', onDragVoice)
  window.removeEventListener('mouseup', stopDragVoice)
}

const isVoiceMoved = computed(() => store.positions.player.voice.x !== 0 || store.positions.player.voice.y !== 0)

const isDraggingStamina = ref(false)
const staminaDragOffset = ref({ x: 0, y: 0 })

const startDragStamina = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingStamina.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  staminaDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragStamina)
  window.addEventListener('mouseup', stopDragStamina)
}

const onDragStamina = (e: MouseEvent) => {
  if (!isDraggingStamina.value) return
  store.positions.player.stamina = {
    x: e.clientX - staminaDragOffset.value.x,
    y: e.clientY - staminaDragOffset.value.y
  }
}

const stopDragStamina = () => {
  isDraggingStamina.value = false
  window.removeEventListener('mousemove', onDragStamina)
  window.removeEventListener('mouseup', stopDragStamina)
}

const isStaminaMoved = computed(() => store.positions.player.stamina.x !== 0 || store.positions.player.stamina.y !== 0)

const isDraggingOxygen = ref(false)
const oxygenDragOffset = ref({ x: 0, y: 0 })

const startDragOxygen = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingOxygen.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  oxygenDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragOxygen)
  window.addEventListener('mouseup', stopDragOxygen)
}

const onDragOxygen = (e: MouseEvent) => {
  if (!isDraggingOxygen.value) return
  store.positions.player.oxygen = {
    x: e.clientX - oxygenDragOffset.value.x,
    y: e.clientY - oxygenDragOffset.value.y
  }
}

const stopDragOxygen = () => {
  isDraggingOxygen.value = false
  window.removeEventListener('mousemove', onDragOxygen)
  window.removeEventListener('mouseup', stopDragOxygen)
}

const isOxygenMoved = computed(() => store.positions.player.oxygen.x !== 0 || store.positions.player.oxygen.y !== 0)

const isDraggingPlayerId = ref(false)
const playerIdDragOffset = ref({ x: 0, y: 0 })

const startDragPlayerId = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingPlayerId.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  playerIdDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragPlayerId)
  window.addEventListener('mouseup', stopDragPlayerId)
}

const onDragPlayerId = (e: MouseEvent) => {
  if (!isDraggingPlayerId.value) return
  store.positions.player.playerId = {
    x: e.clientX - playerIdDragOffset.value.x,
    y: e.clientY - playerIdDragOffset.value.y
  }
}

const stopDragPlayerId = () => {
  isDraggingPlayerId.value = false
  window.removeEventListener('mousemove', onDragPlayerId)
  window.removeEventListener('mouseup', stopDragPlayerId)
}

const isPlayerIdMoved = computed(() => store.positions.player.playerId.x !== 0 || store.positions.player.playerId.y !== 0)

const hexToRgb = (hex: string) => {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
  return result ? {
    r: parseInt(result[1] ?? '00', 16),
    g: parseInt(result[2] ?? '00', 16),
    b: parseInt(result[3] ?? '00', 16)
  } : { r: 239, g: 68, b: 68 }
}

const healthGradientFrom = computed(() => {
  const rgb = hexToRgb(store.colors.player.health)
  return `rgba(${Math.floor(rgb.r * 0.6)}, ${Math.floor(rgb.g * 0.4)}, ${Math.floor(rgb.b * 0.4)}, 0.85)`
})

const healthGradientTo = computed(() => {
  const rgb = hexToRgb(store.colors.player.health)
  return `rgba(${Math.floor(rgb.r * 0.4)}, ${Math.floor(rgb.g * 0.3)}, ${Math.floor(rgb.b * 0.3)}, 0.9)`
})

const armorGradientFrom = computed(() => {
  const rgb = hexToRgb(store.colors.player.armor)
  return `rgba(${Math.floor(rgb.r * 0.6)}, ${Math.floor(rgb.g * 0.4)}, ${Math.floor(rgb.b * 0.4)}, 0.85)`
})

const armorGradientTo = computed(() => {
  const rgb = hexToRgb(store.colors.player.armor)
  return `rgba(${Math.floor(rgb.r * 0.4)}, ${Math.floor(rgb.g * 0.3)}, ${Math.floor(rgb.b * 0.3)}, 0.9)`
})

const hungerGradientFrom = computed(() => {
  const rgb = hexToRgb(store.colors.player.hunger)
  return `rgba(${Math.floor(rgb.r * 0.6)}, ${Math.floor(rgb.g * 0.4)}, ${Math.floor(rgb.b * 0.4)}, 0.85)`
})

const hungerGradientTo = computed(() => {
  const rgb = hexToRgb(store.colors.player.hunger)
  return `rgba(${Math.floor(rgb.r * 0.4)}, ${Math.floor(rgb.g * 0.3)}, ${Math.floor(rgb.b * 0.3)}, 0.9)`
})

const thirstGradientFrom = computed(() => {
  const rgb = hexToRgb(store.colors.player.thirst)
  return `rgba(${Math.floor(rgb.r * 0.6)}, ${Math.floor(rgb.g * 0.4)}, ${Math.floor(rgb.b * 0.4)}, 0.85)`
})

const thirstGradientTo = computed(() => {
  const rgb = hexToRgb(store.colors.player.thirst)
  return `rgba(${Math.floor(rgb.r * 0.4)}, ${Math.floor(rgb.g * 0.3)}, ${Math.floor(rgb.b * 0.3)}, 0.9)`
})

const staminaGradientFrom = computed(() => {
  const rgb = hexToRgb(store.colors.player.stamina)
  return `rgba(${Math.floor(rgb.r * 0.6)}, ${Math.floor(rgb.g * 0.4)}, ${Math.floor(rgb.b * 0.4)}, 0.85)`
})

const staminaGradientTo = computed(() => {
  const rgb = hexToRgb(store.colors.player.stamina)
  return `rgba(${Math.floor(rgb.r * 0.4)}, ${Math.floor(rgb.g * 0.3)}, ${Math.floor(rgb.b * 0.3)}, 0.9)`
})

const oxygenGradientFrom = computed(() => {
  const rgb = hexToRgb(store.colors.player.oxygen)
  return `rgba(${Math.floor(rgb.r * 0.6)}, ${Math.floor(rgb.g * 0.4)}, ${Math.floor(rgb.b * 0.4)}, 0.85)`
})

const oxygenGradientTo = computed(() => {
  const rgb = hexToRgb(store.colors.player.oxygen)
  return `rgba(${Math.floor(rgb.r * 0.4)}, ${Math.floor(rgb.g * 0.3)}, ${Math.floor(rgb.b * 0.3)}, 0.9)`
})

const voiceGradientFrom = computed(() => {
  const rgb = hexToRgb(store.colors.player.voice)
  return `rgba(${Math.floor(rgb.r * 0.8)}, ${Math.floor(rgb.g * 0.8)}, ${Math.floor(rgb.b * 0.8)}, 0.85)`
})

const voiceGradientTo = computed(() => {
  const rgb = hexToRgb(store.colors.player.voice)
  return `rgba(${Math.floor(rgb.r * 0.6)}, ${Math.floor(rgb.g * 0.6)}, ${Math.floor(rgb.b * 0.6)}, 0.9)`
})

const voiceValue = computed(() => {
  switch (voice.value) {
    case 'whisper': return 25
    case 'normal': return 50
    case 'shout': return 100
    case 'megaphone': return 100
    default: return 50
  }
})

const voiceIconOpacity = computed(() => {
  switch (voice.value) {
    case 'whisper': return 0.25
    case 'normal': return 0.5
    case 'shout': return 1
    case 'megaphone': return 1
    default: return 0.5
  }
})

const voiceGlow = computed(() => voice.value === 'megaphone')
</script>

<template>
  <div
    v-if="(store.visibility.player.health || isEditMode) && isHealthMoved"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.player.health.x}px`,
      top: `${store.positions.player.health.y}px`,
      transform: `scale(${store.sizes.player.health})`
    }"
    @mousedown="startDragHealth"
  >
    <HexagonStat
      :icon="mdiHeartPulse"
      :value="health"
      :icon-color="store.colors.player.health"
      :bg-gradient-from="healthGradientFrom"
      :bg-gradient-to="healthGradientTo"
      :shadow-color="store.colors.player.health"
    />
  </div>

  <div
    v-if=" (store.visibility.player.armor || isEditMode) && (armor > 0 || isEditMode) && isArmorMoved"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.player.armor.x}px`,
      top: `${store.positions.player.armor.y}px`,
      transform: `scale(${store.sizes.player.armor})`
    }"
    @mousedown="startDragArmor"
  >
    <HexagonStat
      :icon="mdiShieldHalfFull"
      :value="isEditMode ? 100 : armor"
      :icon-color="store.colors.player.armor"
      :bg-gradient-from="armorGradientFrom"
      :bg-gradient-to="armorGradientTo"
      :shadow-color="store.colors.player.armor"
    />
  </div>

  <div
    v-if=" (store.visibility.player.hunger || isEditMode) && isHungerMoved"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.player.hunger.x}px`,
      top: `${store.positions.player.hunger.y}px`,
      transform: `scale(${store.sizes.player.hunger})`
    }"
    @mousedown="startDragHunger"
  >
    <HexagonStat
      :icon="mdiFoodDrumstick"
      :value="hunger"
      :icon-color="store.colors.player.hunger"
      :bg-gradient-from="hungerGradientFrom"
      :bg-gradient-to="hungerGradientTo"
      :shadow-color="store.colors.player.hunger"
    />
  </div>

  <div
    v-if=" (store.visibility.player.thirst || isEditMode) && isThirstMoved"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.player.thirst.x}px`,
      top: `${store.positions.player.thirst.y}px`,
      transform: `scale(${store.sizes.player.thirst})`
    }"
    @mousedown="startDragThirst"
  >
    <HexagonStat
      :icon="mdiCupWater"
      :value="thirst"
      :icon-color="store.colors.player.thirst"
      :bg-gradient-from="thirstGradientFrom"
      :bg-gradient-to="thirstGradientTo"
      :shadow-color="store.colors.player.thirst"
    />
  </div>

  <div
    v-if=" (store.visibility.player.voice || isEditMode) && isVoiceMoved"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.player.voice.x}px`,
      top: `${store.positions.player.voice.y}px`,
      transform: `scale(${store.sizes.player.voice})`
    }"
    @mousedown="startDragVoice"
  >
    <HexagonStat
      :icon="mdiMicrophone"
      :value="voiceValue"
      :icon-opacity="voiceIconOpacity"
      :glow="voiceGlow"
      :pulse="isTalking"
      :icon-color="store.colors.player.voice"
      :bg-gradient-from="voiceGradientFrom"
      :bg-gradient-to="voiceGradientTo"
      :shadow-color="store.colors.player.voice"
    />
  </div>

  <div
    v-if=" (store.visibility.player.stamina || isEditMode) && (stamina < 100 || isEditMode) && isStaminaMoved"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.player.stamina.x}px`,
      top: `${store.positions.player.stamina.y}px`,
      transform: `scale(${store.sizes.player.stamina})`
    }"
    @mousedown="startDragStamina"
  >
    <HexagonStat
      :icon="mdiRun"
      :value="isEditMode ? 100 : stamina"
      :icon-color="store.colors.player.stamina"
      :bg-gradient-from="staminaGradientFrom"
      :bg-gradient-to="staminaGradientTo"
      :shadow-color="store.colors.player.stamina"
    />
  </div>

  <div
    v-if=" (store.visibility.player.oxygen || isEditMode) && (oxygen < 100 || isEditMode) && isOxygenMoved"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.player.oxygen.x}px`,
      top: `${store.positions.player.oxygen.y}px`,
      transform: `scale(${store.sizes.player.oxygen})`
    }"
    @mousedown="startDragOxygen"
  >
    <HexagonStat
      :icon="mdiLungs"
      :value="isEditMode ? 100 : oxygen"
      :icon-color="store.colors.player.oxygen"
      :bg-gradient-from="oxygenGradientFrom"
      :bg-gradient-to="oxygenGradientTo"
      :shadow-color="store.colors.player.oxygen"
    />
  </div>

  <!-- <div
    v-if=" (store.visibility.player.playerId || isEditMode) && isPlayerIdMoved"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.player.playerId.x}px`,
      top: `${store.positions.player.playerId.y}px`,
      transform: `scale(${store.sizes.player.playerId})`
    }"
    @mousedown="startDragPlayerId"
  >
    <HexagonId :id="playerId" />
  </div> -->

  <div class="flex items-center gap-3">
    <div
      v-if=" (store.visibility.player.health || isEditMode) && !isHealthMoved"
      :class="[
        'relative',
        store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
      ]"
      :style="{
        transform: `translate(${store.positions.player.health.x}px, ${store.positions.player.health.y}px) scale(${store.sizes.player.health})`
      }"
      @mousedown="startDragHealth"
    >
      <HexagonStat
        :icon="mdiHeartPulse"
        :value="health"
        :icon-color="store.colors.player.health"
        :bg-gradient-from="healthGradientFrom"
        :bg-gradient-to="healthGradientTo"
        :shadow-color="store.colors.player.health"
      />
    </div>

    <Transition :name="isEditMode ? '' : 'armor'">
      <div
        v-if=" (store.visibility.player.armor || isEditMode) && (armor > 0 || isEditMode) && !isArmorMoved"
        :class="[
          'relative',
          store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
        ]"
        :style="{
          transform: `scale(${store.sizes.player.armor})`
        }"
        @mousedown="startDragArmor"
      >
        <HexagonStat
          :icon="mdiShieldHalfFull"
          :value="isEditMode ? 100 : armor"
          :icon-color="store.colors.player.armor"
          :bg-gradient-from="armorGradientFrom"
          :bg-gradient-to="armorGradientTo"
          :shadow-color="store.colors.player.armor"
        />
      </div>
    </Transition>

    <div
      v-if=" (store.visibility.player.hunger || isEditMode) && !isHungerMoved"
      :class="[
        'relative',
        store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
      ]"
      :style="{
        transform: `scale(${store.sizes.player.hunger})`
      }"
      @mousedown="startDragHunger"
    >
      <HexagonStat
        :icon="mdiFoodDrumstick"
        :value="hunger"
        :icon-color="store.colors.player.hunger"
        :bg-gradient-from="hungerGradientFrom"
        :bg-gradient-to="hungerGradientTo"
        :shadow-color="store.colors.player.hunger"
      />
    </div>

    <div
      v-if=" (store.visibility.player.thirst || isEditMode) && !isThirstMoved"
      :class="[
        'relative',
        store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
      ]"
      :style="{
        transform: `scale(${store.sizes.player.thirst})`
      }"
      @mousedown="startDragThirst"
    >
      <HexagonStat
        :icon="mdiCupWater"
        :value="thirst"
        :icon-color="store.colors.player.thirst"
        :bg-gradient-from="thirstGradientFrom"
        :bg-gradient-to="thirstGradientTo"
        :shadow-color="store.colors.player.thirst"
      />
    </div>

    <Transition :name="isEditMode ? '' : 'stamina'">
      <div
        v-if=" (store.visibility.player.stamina || isEditMode) && (stamina < 100 || isEditMode) && !isStaminaMoved"
        :class="[
          'relative',
          store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
        ]"
        :style="{
          transform: `scale(${store.sizes.player.stamina})`
        }"
        @mousedown="startDragStamina"
      >
        <HexagonStat
          :icon="mdiRun"
          :value="isEditMode ? 100 : stamina"
          :icon-color="store.colors.player.stamina"
          :bg-gradient-from="staminaGradientFrom"
          :bg-gradient-to="staminaGradientTo"
          :shadow-color="store.colors.player.stamina"
        />
      </div>
    </Transition>

    <Transition :name="isEditMode ? '' : 'oxygen'">
      <div
        v-if=" (store.visibility.player.oxygen || isEditMode) && (oxygen < 100 || isEditMode) && !isOxygenMoved"
        :class="[
          'relative',
          store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
        ]"
        :style="{
          transform: `scale(${store.sizes.player.oxygen})`
        }"
        @mousedown="startDragOxygen"
      >
        <HexagonStat
          :icon="mdiLungs"
          :value="isEditMode ? 100 : oxygen"
          :icon-color="store.colors.player.oxygen"
          :bg-gradient-from="oxygenGradientFrom"
          :bg-gradient-to="oxygenGradientTo"
          :shadow-color="store.colors.player.oxygen"
        />
      </div>
    </Transition>

    <div
      v-if=" (store.visibility.player.voice || isEditMode) && !isVoiceMoved"
      :class="[
        'relative',
        store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
      ]"
      :style="{
        transform: `scale(${store.sizes.player.voice})`
      }"
      @mousedown="startDragVoice"
    >
      <HexagonStat
        :icon="mdiMicrophone"
        :value="voiceValue"
        :icon-opacity="voiceIconOpacity"
        :glow="voiceGlow"
        :pulse="isTalking"
        :icon-color="store.colors.player.voice"
        :bg-gradient-from="voiceGradientFrom"
        :bg-gradient-to="voiceGradientTo"
        :shadow-color="store.colors.player.voice"
      />
    </div>

    <!-- <div
      v-if=" (store.visibility.player.playerId || isEditMode) && !isPlayerIdMoved"
      :class="[
        'relative',
        store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
      ]"
      :style="{
        transform: `scale(${store.sizes.player.playerId})`
      }"
      @mousedown="startDragPlayerId"
    >
      <HexagonId :id="playerId" />
    </div> -->
  </div>
</template>

<style scoped>
.armor-enter-active,
.armor-leave-active,
.stamina-enter-active,
.stamina-leave-active,
.oxygen-enter-active,
.oxygen-leave-active {
  transition: all 0.3s ease;
}

.armor-enter-from,
.armor-leave-to,
.stamina-enter-from,
.stamina-leave-to,
.oxygen-enter-from,
.oxygen-leave-to {
  opacity: 0;
  transform: scale(0.8);
}
</style>
