<script setup lang="ts">
import { computed, ref, onMounted, onUnmounted } from 'vue'
import { useI18n } from 'vue-i18n'
import PlayerHud from '@/components/hud/PlayerHud.vue'
import VehicleHud from '@/components/hud/VehicleHud.vue'
import HudSettings from '@/components/hud/HudSettings.vue'
import { useWeather, type WeatherType } from '@/composables/useWeather'
import { useCompass } from '@/composables/useCompass'
import { useLocation } from '@/composables/useLocation'
import { useVehicleStats } from '@/composables/useVehicleStats'
import { useHudOptionsStore } from '@/stores/hudOptions'
import {
  mdiWeatherSunny,
  mdiWeatherFog,
  mdiWeatherCloudy,
  mdiWeatherPartlyCloudy,
  mdiWeatherPouring,
  mdiWeatherLightning,
  mdiWeatherSnowy,
  mdiWeatherSnowyHeavy,
  mdiPineTree,
  mdiGhost,
  mdiSmog,
} from '@/icons'

const { t } = useI18n()

const props = withDefaults(defineProps<{
  showSettingsFab?: boolean
  forceVisible?: boolean
}>(), {
  showSettingsFab: false,
  forceVisible: false
})

const settingsOpen = ref(false)
const isHudVisible = ref(props.forceVisible)

const { weather } = useWeather()
const { direction } = useCompass()
const { streetName } = useLocation()
const { isInVehicle } = useVehicleStats()
const store = useHudOptionsStore()

const handleMessage = (event: MessageEvent) => {
  if (event.data.action === 'openSettings') {
    settingsOpen.value = true
  }
  if (event.data.action === 'closeSettings') {
    settingsOpen.value = false
  }
  if (event.data.action === 'showHud') {
    isHudVisible.value = event.data.show
  }
}

onMounted(() => {
  window.addEventListener('message', handleMessage)
})

onUnmounted(() => {
  window.removeEventListener('message', handleMessage)
})

const isEditMode = computed(() => store.isPositionEditMode || store.isSizeEditMode)

const weatherIcons: Record<WeatherType, string> = {
  extrasunny: mdiWeatherSunny,
  clear: mdiWeatherSunny,
  neutral: mdiWeatherPartlyCloudy,
  smog: mdiSmog,
  foggy: mdiWeatherFog,
  overcast: mdiWeatherCloudy,
  clouds: mdiWeatherCloudy,
  clearing: mdiWeatherPartlyCloudy,
  rain: mdiWeatherPouring,
  thunder: mdiWeatherLightning,
  snow: mdiWeatherSnowy,
  blizzard: mdiWeatherSnowyHeavy,
  snowlight: mdiWeatherSnowy,
  xmas: mdiPineTree,
  halloween: mdiGhost,
}

const weatherIcon = computed(() => weatherIcons[weather.value])

const isDraggingWeather = ref(false)
const weatherDragOffset = ref({ x: 0, y: 0 })

const startDragWeather = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingWeather.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  weatherDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragWeather)
  window.addEventListener('mouseup', stopDragWeather)
}

const onDragWeather = (e: MouseEvent) => {
  if (!isDraggingWeather.value) return
  store.positions.vehicle.weather = {
    x: e.clientX - weatherDragOffset.value.x,
    y: e.clientY - weatherDragOffset.value.y
  }
}

const stopDragWeather = () => {
  isDraggingWeather.value = false
  window.removeEventListener('mousemove', onDragWeather)
  window.removeEventListener('mouseup', stopDragWeather)
}

const isWeatherMoved = computed(() => store.positions.vehicle.weather.x !== 0 || store.positions.vehicle.weather.y !== 0)

const isDraggingCompass = ref(false)
const compassDragOffset = ref({ x: 0, y: 0 })

const startDragCompass = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingCompass.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  compassDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragCompass)
  window.addEventListener('mouseup', stopDragCompass)
}

const onDragCompass = (e: MouseEvent) => {
  if (!isDraggingCompass.value) return
  store.positions.vehicle.compass = {
    x: e.clientX - compassDragOffset.value.x,
    y: e.clientY - compassDragOffset.value.y
  }
}

const stopDragCompass = () => {
  isDraggingCompass.value = false
  window.removeEventListener('mousemove', onDragCompass)
  window.removeEventListener('mouseup', stopDragCompass)
}

const isCompassMoved = computed(() => store.positions.vehicle.compass.x !== 0 || store.positions.vehicle.compass.y !== 0)

const isDraggingStreetName = ref(false)
const streetNameDragOffset = ref({ x: 0, y: 0 })

const startDragStreetName = (e: MouseEvent) => {
  if (!store.isPositionEditMode) return
  isDraggingStreetName.value = true
  const target = e.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  streetNameDragOffset.value = {
    x: e.clientX - rect.left,
    y: e.clientY - rect.top
  }
  window.addEventListener('mousemove', onDragStreetName)
  window.addEventListener('mouseup', stopDragStreetName)
}

const onDragStreetName = (e: MouseEvent) => {
  if (!isDraggingStreetName.value) return
  store.positions.vehicle.streetName = {
    x: e.clientX - streetNameDragOffset.value.x,
    y: e.clientY - streetNameDragOffset.value.y
  }
}

const stopDragStreetName = () => {
  isDraggingStreetName.value = false
  window.removeEventListener('mousemove', onDragStreetName)
  window.removeEventListener('mouseup', stopDragStreetName)
}

const isStreetNameMoved = computed(() => store.positions.vehicle.streetName.x !== 0 || store.positions.vehicle.streetName.y !== 0)
</script>

<template>
  <div v-show="isHudVisible">
  <span
    v-if="(store.visibility.vehicle.streetName || isEditMode) && isStreetNameMoved"
    :class="[
      'fixed street-name',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.vehicle.streetName.x}px`,
      top: `${store.positions.vehicle.streetName.y}px`,
      color: store.colors.vehicle.streetName,
      transform: `scale(${store.sizes.vehicle.streetName})`
    }"
    @mousedown="startDragStreetName"
  >{{ streetName }}</span>

  <div
    v-if="(store.visibility.vehicle.compass || isEditMode) && isCompassMoved"
    :class="[
      'fixed w-12 h-12 flex items-center justify-center drop-shadow-lg',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.vehicle.compass.x}px`,
      top: `${store.positions.vehicle.compass.y}px`,
      transform: `scale(${store.sizes.vehicle.compass})`
    }"
    @mousedown="startDragCompass"
  >
    <div
      class="w-11 h-11 hexagon flex items-center justify-center"
      :style="{
        background: 'linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05))',
        boxShadow: '0 0 12px rgba(255,255,255,0.2), inset 0 0 6px rgba(255,255,255,0.1)'
      }"
    >
      <div class="w-10 h-10 hexagon bg-zinc-900/95 flex items-center justify-center">
        <span class="text-white text-xs font-bold drop-shadow-lg">{{ direction }}</span>
      </div>
    </div>
  </div>

  <VIcon
    v-if="(store.visibility.vehicle.weather || isEditMode) && isWeatherMoved"
    :class="[
      'fixed drop-shadow-lg',
      store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
    ]"
    :style="{
      left: `${store.positions.vehicle.weather.x}px`,
      top: `${store.positions.vehicle.weather.y}px`,
      transform: `scale(${store.sizes.vehicle.weather})`
    }"
    :icon="weatherIcon"
    :color="store.colors.vehicle.weather"
    size="32"
    @mousedown="startDragWeather"
  />

  <div class="fixed inset-0 w-full h-full pointer-events-none z-[100]">
    <div class="absolute top-8 left-1/2 -translate-x-1/2 flex items-center gap-3">
      <VIcon
        v-if="(store.visibility.vehicle.weather || isEditMode) && !isWeatherMoved"
        :class="store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''"
        :style="{
          transform: `scale(${store.sizes.vehicle.weather})`
        }"
        :icon="weatherIcon"
        :color="store.colors.vehicle.weather"
        size="32"
        class="drop-shadow-lg"
        @mousedown="startDragWeather"
      />

      <div
        v-if="(store.visibility.vehicle.compass || isEditMode) && !isCompassMoved"
        :class="[
          'w-12 h-12 flex items-center justify-center drop-shadow-lg',
          store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
        ]"
        :style="{
          transform: `scale(${store.sizes.vehicle.compass})`
        }"
        @mousedown="startDragCompass"
      >
        <div
          class="w-11 h-11 hexagon flex items-center justify-center"
          :style="{
            background: 'linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05))',
            boxShadow: '0 0 12px rgba(255,255,255,0.2), inset 0 0 6px rgba(255,255,255,0.1)'
          }"
        >
          <div class="w-10 h-10 hexagon bg-zinc-900/95 flex items-center justify-center">
            <span class="text-white text-xs font-bold drop-shadow-lg">{{ direction }}</span>
          </div>
        </div>
      </div>

      <span
        v-if="(store.visibility.vehicle.streetName || isEditMode) && !isStreetNameMoved"
        :class="[
          'street-name',
          store.isPositionEditMode ? 'cursor-move pointer-events-auto' : ''
        ]"
        :style="{
          color: store.colors.vehicle.streetName,
          transform: `scale(${store.sizes.vehicle.streetName})`
        }"
        @mousedown="startDragStreetName"
      >{{ streetName }}</span>
    </div>

    <div class="absolute bottom-8 right-8 flex flex-col items-end gap-4">
      <VehicleHud v-if="isInVehicle" />
      <PlayerHud />
    </div>
  </div>

  <HudSettings v-model="settingsOpen" :show-fab="showSettingsFab" />
  </div>

  <div
    v-if="store.isPositionEditMode"
    class="fixed inset-0 pointer-events-none grid-overlay"
  ></div>

  <div
    v-if="store.isPositionEditMode"
    class="fixed top-6 right-6 flex gap-3 z-[200]"
  >
    <button
      class="px-6 py-2.5 bg-red-700 hover:bg-red-800 text-white font-semibold rounded-lg shadow-lg hover:shadow-red-700/30 transition-all duration-200"
      @click="store.cancelPositionEdit"
    >
      {{ t('settings.buttons.cancel') }}
    </button>
    <button
      class="px-6 py-2.5 bg-green-700 hover:bg-green-800 text-white font-semibold rounded-lg shadow-lg hover:shadow-green-700/30 transition-all duration-200"
      @click="store.validatePositionEdit"
    >
      {{ t('settings.buttons.validate') }}
    </button>
  </div>
</template>

<style scoped>
.hexagon {
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
}

.street-name {
  font-weight: 700;
  font-size: 2rem;
  -webkit-text-stroke: 0.5px #3b82f6;
  text-shadow:
    0 0 8px rgba(59, 130, 246, 0.5),
    2px 2px 4px rgba(0, 0, 0, 0.5);
}

.grid-overlay {
  z-index: 50;
  opacity: 0.4;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='50' height='50'%3E%3Cpath d='M 50 0 L 0 0 0 50' fill='none' stroke='white' stroke-width='1'/%3E%3C/svg%3E");
  background-repeat: repeat;
}
</style>
