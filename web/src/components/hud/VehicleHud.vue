<script setup lang="ts">
import { computed, ref } from 'vue'
import { useVehicleStats } from '@/composables/useVehicleStats'
import { useHudOptionsStore } from '@/stores/hudOptions'
import SevenSegment from '@/components/hud/SevenSegment.vue'
import HexagonStatSmall from '@/components/hud/HexagonStatSmall.vue'
import HexagonWarning from '@/components/hud/HexagonWarning.vue'
import HexagonEngine from '@/components/hud/HexagonEngine.vue'
import HexagonIcon from '@/components/hud/HexagonIcon.vue'
import HexagonIndicator from '@/components/hud/HexagonIndicator.vue'
import { mdiGasStation, mdiSeatbelt, mdiEngine, mdiCarLightHigh } from '@/icons'

const { speed, fuel, seatbelt, engineDamage, headlights, indicator } = useVehicleStats()
const store = useHudOptionsStore()

const isEditMode = computed(() => store.isPositionEditMode || store.isSizeEditMode)

const isDraggingSpeedometer = ref(false)
const speedometerDragOffset = ref({ x: 0, y: 0 })

const startDragSpeedometer = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingSpeedometer.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  speedometerDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragSpeedometer)
  window.addEventListener('mouseup', stopDragSpeedometer)
}

const onDragSpeedometer = (e: MouseEvent) => {
  if (!isDraggingSpeedometer.value) return
  store.positions.vehicle.speedometer = {
    x: e.clientX - speedometerDragOffset.value.x,
    y: e.clientY - speedometerDragOffset.value.y
  }
}

const stopDragSpeedometer = () => {
  isDraggingSpeedometer.value = false
  window.removeEventListener('mousemove', onDragSpeedometer)
  window.removeEventListener('mouseup', stopDragSpeedometer)
}

const isSpeedometerMoved = computed(() => store.positions.vehicle.speedometer.x !== 0 || store.positions.vehicle.speedometer.y !== 0)

const isDraggingUnit = ref(false)
const unitDragOffset = ref({ x: 0, y: 0 })

const startDragUnit = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingUnit.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  unitDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragUnit)
  window.addEventListener('mouseup', stopDragUnit)
}

const onDragUnit = (e: MouseEvent) => {
  if (!isDraggingUnit.value) return
  store.positions.vehicle.speedometerUnit = {
    x: e.clientX - unitDragOffset.value.x,
    y: e.clientY - unitDragOffset.value.y
  }
}

const stopDragUnit = () => {
  isDraggingUnit.value = false
  window.removeEventListener('mousemove', onDragUnit)
  window.removeEventListener('mouseup', stopDragUnit)
}

const isUnitMoved = computed(() => store.positions.vehicle.speedometerUnit.x !== 0 || store.positions.vehicle.speedometerUnit.y !== 0)

const isDraggingFuel = ref(false)
const fuelDragOffset = ref({ x: 0, y: 0 })

const startDragFuel = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingFuel.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  fuelDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragFuel)
  window.addEventListener('mouseup', stopDragFuel)
}

const onDragFuel = (e: MouseEvent) => {
  if (!isDraggingFuel.value) return
  store.positions.vehicle.fuel = {
    x: e.clientX - fuelDragOffset.value.x,
    y: e.clientY - fuelDragOffset.value.y
  }
}

const stopDragFuel = () => {
  isDraggingFuel.value = false
  window.removeEventListener('mousemove', onDragFuel)
  window.removeEventListener('mouseup', stopDragFuel)
}

const isFuelMoved = computed(() => store.positions.vehicle.fuel.x !== 0 || store.positions.vehicle.fuel.y !== 0)

const isDraggingSeatbelt = ref(false)
const seatbeltDragOffset = ref({ x: 0, y: 0 })

const startDragSeatbelt = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingSeatbelt.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  seatbeltDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragSeatbelt)
  window.addEventListener('mouseup', stopDragSeatbelt)
}

const onDragSeatbelt = (e: MouseEvent) => {
  if (!isDraggingSeatbelt.value) return
  store.positions.vehicle.seatbelt = {
    x: e.clientX - seatbeltDragOffset.value.x,
    y: e.clientY - seatbeltDragOffset.value.y
  }
}

const stopDragSeatbelt = () => {
  isDraggingSeatbelt.value = false
  window.removeEventListener('mousemove', onDragSeatbelt)
  window.removeEventListener('mouseup', stopDragSeatbelt)
}

const isSeatbeltMoved = computed(() => store.positions.vehicle.seatbelt.x !== 0 || store.positions.vehicle.seatbelt.y !== 0)

const isDraggingHeadlights = ref(false)
const headlightsDragOffset = ref({ x: 0, y: 0 })

const startDragHeadlights = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingHeadlights.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  headlightsDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragHeadlights)
  window.addEventListener('mouseup', stopDragHeadlights)
}

const onDragHeadlights = (e: MouseEvent) => {
  if (!isDraggingHeadlights.value) return
  store.positions.vehicle.headlights = {
    x: e.clientX - headlightsDragOffset.value.x,
    y: e.clientY - headlightsDragOffset.value.y
  }
}

const stopDragHeadlights = () => {
  isDraggingHeadlights.value = false
  window.removeEventListener('mousemove', onDragHeadlights)
  window.removeEventListener('mouseup', stopDragHeadlights)
}

const isHeadlightsMoved = computed(() => store.positions.vehicle.headlights.x !== 0 || store.positions.vehicle.headlights.y !== 0)

const isDraggingIndicator = ref(false)
const indicatorDragOffset = ref({ x: 0, y: 0 })

const startDragIndicator = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingIndicator.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  indicatorDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragIndicator)
  window.addEventListener('mouseup', stopDragIndicator)
}

const onDragIndicator = (e: MouseEvent) => {
  if (!isDraggingIndicator.value) return
  store.positions.vehicle.indicators = {
    x: e.clientX - indicatorDragOffset.value.x,
    y: e.clientY - indicatorDragOffset.value.y
  }
}

const stopDragIndicator = () => {
  isDraggingIndicator.value = false
  window.removeEventListener('mousemove', onDragIndicator)
  window.removeEventListener('mouseup', stopDragIndicator)
}

const isIndicatorMoved = computed(() => store.positions.vehicle.indicators.x !== 0 || store.positions.vehicle.indicators.y !== 0)

const isDraggingEngine = ref(false)
const engineDragOffset = ref({ x: 0, y: 0 })

const startDragEngine = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingEngine.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  engineDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragEngine)
  window.addEventListener('mouseup', stopDragEngine)
}

const onDragEngine = (e: MouseEvent) => {
  if (!isDraggingEngine.value) return
  store.positions.vehicle.engine = {
    x: e.clientX - engineDragOffset.value.x,
    y: e.clientY - engineDragOffset.value.y
  }
}

const stopDragEngine = () => {
  isDraggingEngine.value = false
  window.removeEventListener('mousemove', onDragEngine)
  window.removeEventListener('mouseup', stopDragEngine)
}

const isEngineMoved = computed(() => store.positions.vehicle.engine.x !== 0 || store.positions.vehicle.engine.y !== 0)

const headlightColor = computed(() => {
  if (headlights.value === 'highbeam') return '#3b82f6'
  return '#22c55e'
})

const hexToRgb = (hex: string) => {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
  return result ? {
    r: parseInt(result[1] ?? '00', 16),
    g: parseInt(result[2] ?? '00', 16),
    b: parseInt(result[3] ?? '00', 16)
  } : { r: 217, g: 119, b: 6 }
}

const fuelGradientFrom = computed(() => {
  const rgb = hexToRgb(store.colors.vehicle.fuel)
  return `rgba(${Math.floor(rgb.r * 0.85)}, ${Math.floor(rgb.g * 0.85)}, ${Math.floor(rgb.b * 0.85)}, 0.85)`
})

const fuelGradientTo = computed(() => {
  const rgb = hexToRgb(store.colors.vehicle.fuel)
  return `rgba(${Math.floor(rgb.r * 0.7)}, ${Math.floor(rgb.g * 0.7)}, ${Math.floor(rgb.b * 0.7)}, 0.9)`
})

const digits = computed(() => {
  const padded = String(speed.value).padStart(3, '0')
  return padded.split('').map(Number)
})

const isActive = (index: number) => {
  const s = speed.value
  if (s >= 100) return true
  if (s >= 10) return index >= 1
  return index >= 2
}
</script>

<template>
  <HexagonIndicator
    v-if="(store.visibility.vehicle.indicators || isEditMode) && isIndicatorMoved && (indicator !== 'off' || isEditMode)"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.vehicle.indicators.x}px`,
      top: `${store.positions.vehicle.indicators.y}px`,
      transform: `scale(${store.sizes.vehicle.indicators})`
    }"
    :mode="isEditMode ? 'both' : indicator"
    @mousedown="startDragIndicator"
  />

  <HexagonIcon
    v-if="(store.visibility.vehicle.headlights || isEditMode) && isHeadlightsMoved && (headlights !== 'off' || isEditMode)"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.vehicle.headlights.x}px`,
      top: `${store.positions.vehicle.headlights.y}px`,
      transform: `scale(${store.sizes.vehicle.headlights})`
    }"
    :icon="mdiCarLightHigh"
    :icon-color="isEditMode ? '#3b82f6' : headlightColor"
    @mousedown="startDragHeadlights"
  />

  <div
    v-if="(store.visibility.vehicle.seatbelt || isEditMode) && isSeatbeltMoved && (!seatbelt || isEditMode)"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.vehicle.seatbelt.x}px`,
      top: `${store.positions.vehicle.seatbelt.y}px`,
      transform: `scale(${store.sizes.vehicle.seatbelt})`
    }"
    @mousedown="startDragSeatbelt"
  >
    <HexagonWarning
      :icon="mdiSeatbelt"
      icon-color="#ef4444"
    />
  </div>

  <HexagonStatSmall
    v-if="(store.visibility.vehicle.fuel || isEditMode) && isFuelMoved"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.vehicle.fuel.x}px`,
      top: `${store.positions.vehicle.fuel.y}px`,
      transform: `scale(${store.sizes.vehicle.fuel})`
    }"
    :icon="mdiGasStation"
    :value="fuel"
    :icon-color="store.colors.vehicle.fuel"
    :bg-gradient-from="fuelGradientFrom"
    :bg-gradient-to="fuelGradientTo"
    :shadow-color="store.colors.vehicle.fuel"
    @mousedown="startDragFuel"
  />

  <div
    v-if="(store.visibility.vehicle.engine || isEditMode) && isEngineMoved"
    :class="[
      'fixed',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.vehicle.engine.x}px`,
      top: `${store.positions.vehicle.engine.y}px`,
      transform: `scale(${store.sizes.vehicle.engine})`
    }"
    @mousedown="startDragEngine"
  >
    <HexagonEngine
      :icon="mdiEngine"
      :damage="isEditMode ? 50 : engineDamage"
    />
  </div>

  <div
    v-if="(store.visibility.vehicle.speedometer || isEditMode) && isSpeedometerMoved"
    :class="[
      'fixed flex items-end gap-1',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.vehicle.speedometer.x}px`,
      top: `${store.positions.vehicle.speedometer.y}px`,
      transform: `scale(${store.sizes.vehicle.speedometer})`
    }"
    @mousedown="startDragSpeedometer"
  >
    <SevenSegment
      v-for="(digit, index) in digits"
      :key="index"
      :value="digit"
      :color="isActive(index) ? store.colors.vehicle.speedometerActive : store.colors.vehicle.speedometerInactive"
    />
  </div>

  <span
    v-if="(store.visibility.vehicle.speedometer || isEditMode) && isUnitMoved"
    :class="[
      'fixed text-white text-3xl font-bold uppercase',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.vehicle.speedometerUnit.x}px`,
      top: `${store.positions.vehicle.speedometerUnit.y}px`,
      transform: `scale(${store.sizes.vehicle.speedometerUnit})`
    }"
    @mousedown="startDragUnit"
  >MPH</span>

  <div class="flex items-end gap-3">
      <div v-if="(store.visibility.vehicle.speedometer || isEditMode)" class="flex items-end gap-1">
        <div
          v-if="!isSpeedometerMoved"
          :class="[
            'flex items-end gap-1',
            store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
          ]"
          :style="{
            transform: `scale(${store.sizes.vehicle.speedometer})`
          }"
          @mousedown="startDragSpeedometer"
        >
          <SevenSegment
            v-for="(digit, index) in digits"
            :key="index"
            :value="digit"
            :color="isActive(index) ? store.colors.vehicle.speedometerActive : store.colors.vehicle.speedometerInactive"
          />
        </div>
        <span
          v-if="!isUnitMoved"
          :class="[
            'text-white text-3xl font-bold ml-2 uppercase',
            store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
          ]"
          :style="{
            transform: `scale(${store.sizes.vehicle.speedometerUnit})`
          }"
          @mousedown="startDragUnit"
        >MPH</span>
      </div>

      <div class="flex flex-col items-center gap-1">
      <Transition :name="isEditMode ? '' : 'indicator'">
        <HexagonIndicator
          v-if="(store.visibility.vehicle.indicators || isEditMode) && !isIndicatorMoved && (indicator !== 'off' || isEditMode)"
          :class="store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''"
          :style="{
            transform: `scale(${store.sizes.vehicle.indicators})`
          }"
          :mode="isEditMode ? 'both' : indicator"
          @mousedown="startDragIndicator"
        />
      </Transition>

      <Transition :name="isEditMode ? '' : 'headlights'">
        <HexagonIcon
          v-if="(store.visibility.vehicle.headlights || isEditMode) && !isHeadlightsMoved && (headlights !== 'off' || isEditMode)"
          :class="store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''"
          :style="{
            transform: `scale(${store.sizes.vehicle.headlights})`
          }"
          :icon="mdiCarLightHigh"
          :icon-color="isEditMode ? '#3b82f6' : headlightColor"
          @mousedown="startDragHeadlights"
        />
      </Transition>

      <div
        v-if="(store.visibility.vehicle.engine || isEditMode) && !isEngineMoved"
        :class="store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''"
        :style="{
          transform: `scale(${store.sizes.vehicle.engine})`
        }"
        @mousedown="startDragEngine"
      >
        <HexagonEngine
          :icon="mdiEngine"
          :damage="isEditMode ? 50 : engineDamage"
        />
      </div>

      <Transition :name="isEditMode ? '' : 'seatbelt'">
        <div
          v-if="(store.visibility.vehicle.seatbelt || isEditMode) && !isSeatbeltMoved && (!seatbelt || isEditMode)"
          :class="store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''"
          :style="{
            transform: `scale(${store.sizes.vehicle.seatbelt})`
          }"
          @mousedown="startDragSeatbelt"
        >
          <HexagonWarning
            :icon="mdiSeatbelt"
            icon-color="#ef4444"
          />
        </div>
      </Transition>

      <HexagonStatSmall
        v-if="(store.visibility.vehicle.fuel || isEditMode) && !isFuelMoved"
        :class="store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''"
        :style="{
          transform: `scale(${store.sizes.vehicle.fuel})`
        }"
        :icon="mdiGasStation"
        :value="fuel"
        :icon-color="store.colors.vehicle.fuel"
        :bg-gradient-from="fuelGradientFrom"
        :bg-gradient-to="fuelGradientTo"
        :shadow-color="store.colors.vehicle.fuel"
        @mousedown="startDragFuel"
      />
    </div>
  </div>
</template>

<style scoped>
.seatbelt-enter-active,
.seatbelt-leave-active,
.headlights-enter-active,
.headlights-leave-active,
.indicator-enter-active,
.indicator-leave-active {
  transition: all 0.3s ease;
}

.seatbelt-enter-from,
.seatbelt-leave-to,
.headlights-enter-from,
.headlights-leave-to,
.indicator-enter-from,
.indicator-leave-to {
  opacity: 0;
  transform: scale(0.8);
}
</style>
