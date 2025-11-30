<script setup lang="ts">
import { computed, ref } from 'vue'
import { useI18n } from 'vue-i18n'
import {
  mdiCog,
  mdiPalette,
  mdiCar,
  mdiAccountCircle,
  mdiHeartPulse,
  mdiShieldHalfFull,
  mdiFoodDrumstick,
  mdiCupWater,
  mdiRun,
  mdiLungs,
  mdiMicrophone,
  mdiIdentifier,
  mdiSpeedometer,
  mdiGasStation,
  mdiSeatbelt,
  mdiEngine,
  mdiCarLightHigh,
  mdiArrowRightBold,
  mdiWeatherSunny,
  mdiCompass,
  mdiRoadVariant,
  mdiCursorMove,
  mdiResize,
} from '@/icons'
import { useHudOptionsStore } from '@/stores/hudOptions'

const { t } = useI18n()
const store = useHudOptionsStore()

const props = withDefaults(defineProps<{
  modelValue: boolean
  showFab?: boolean
}>(), {
  showFab: false
})

const emit = defineEmits<{
  'update:modelValue': [value: boolean]
}>()

const isOpen = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value)
})

const tabs = [
  { id: 'player', labelKey: 'settings.tabs.player', icon: mdiAccountCircle },
  { id: 'vehicle', labelKey: 'settings.tabs.vehicle', icon: mdiCar },
  { id: 'colors', labelKey: 'settings.tabs.colors', icon: mdiPalette },
  { id: 'layout', labelKey: 'settings.tabs.layout', icon: mdiCursorMove },
]

const activeTab = ref('player')

const startPositionEdit = () => {
  store.startPositionEdit()
}

const openSizeModal = () => {
  store.startSizeEdit()
}

const saveSettings = () => {
  store.clearBackups()
  isOpen.value = false
}

const cancelSettings = () => {
  store.restoreSettings()
  isOpen.value = false
}
</script>

<template>
  <div v-if="showFab" class="fixed bottom-8 left-24 z-50">
    <button
      class="w-14 h-14 rounded-xl bg-slate-900/80 backdrop-blur-sm border border-blue-500/30 flex items-center justify-center hover:bg-slate-800/90 hover:border-blue-400/50 hover:scale-105 transition-all duration-300 shadow-lg shadow-blue-500/10"
      @click="store.backupSettings(); isOpen = true"
    >
      <VIcon :icon="mdiCog" color="white" size="24" />
    </button>
  </div>

  <Transition name="modal">
    <div
      v-if="isOpen && !store.isSettingsHidden"
      class="fixed inset-0 z-[100] flex items-center justify-center"
    >
      <div
        class="absolute inset-0"
        :class="showFab ? '' : 'bg-black/50 backdrop-blur-sm'"
      ></div>

      <div class="relative w-[700px] max-h-[80vh] overflow-hidden">
        <div class="absolute inset-0 bg-slate-900/95 backdrop-blur-xl rounded-2xl border border-blue-500/20 shadow-2xl shadow-blue-500/10"></div>

        <div class="relative">
          <div class="flex items-center justify-center px-8 py-6 border-b border-slate-700/50">
            <div class="flex items-center gap-4">
              <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-blue-500 to-cyan-400 flex items-center justify-center shadow-lg shadow-blue-500/30">
                <VIcon :icon="mdiCog" color="white" size="20" />
              </div>
              <div>
                <h2 class="text-xl font-bold text-white tracking-wide">{{ t('settings.title') }}</h2>
                <div class="w-12 h-0.5 bg-gradient-to-r from-blue-500 to-cyan-400 mt-1"></div>
              </div>
            </div>
          </div>

          <div class="flex">
            <div class="w-52 border-r border-slate-700/50 py-4 px-3 flex flex-col">
              <div class="flex-1">
                <div
                  v-for="tab in tabs"
                  :key="tab.id"
                  class="flex items-center gap-3 px-4 py-3 rounded-xl cursor-pointer transition-all duration-200 mb-1"
                  :class="activeTab === tab.id
                    ? 'bg-gradient-to-r from-blue-500/20 to-cyan-500/10 border border-blue-500/30'
                    : 'hover:bg-slate-800/50 border border-transparent'"
                  @click="activeTab = tab.id"
                >
                  <VIcon
                    :icon="tab.icon"
                    :color="activeTab === tab.id ? '#60a5fa' : '#94a3b8'"
                    size="20"
                  />
                  <span
                    class="text-sm font-medium transition-colors"
                    :class="activeTab === tab.id ? 'text-blue-300' : 'text-slate-400'"
                  >
                    {{ t(tab.labelKey) }}
                  </span>
                </div>
              </div>

              <div class="mt-4 pt-4 border-t border-slate-700/50 space-y-2">
                <button
                  class="w-full py-2.5 rounded-xl bg-gradient-to-r from-blue-500 to-cyan-400 text-white font-medium text-sm hover:from-blue-600 hover:to-cyan-500 transition-all shadow-lg shadow-blue-500/30"
                  @click="saveSettings"
                >
                  {{ t('settings.buttons.save') }}
                </button>
                <button
                  class="w-full py-2.5 rounded-xl bg-red-500/20 border border-red-500/30 text-red-400 font-medium text-sm hover:bg-red-500/30 transition-all"
                  @click="cancelSettings"
                >
                  {{ t('settings.buttons.cancel') }}
                </button>
              </div>
            </div>

            <div class="flex-1 p-6 max-h-[60vh] overflow-y-auto scrollbar-thin scrollbar-track-slate-800/50 scrollbar-thumb-blue-600/40 hover:scrollbar-thumb-blue-500/60">
              <Transition name="tab-fade" mode="out-in">
                <div v-if="activeTab === 'player'" key="player" class="space-y-3">
                  <div class="flex items-center gap-3 mb-6">
                    <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                    <h3 class="text-white font-semibold text-sm uppercase tracking-wider">{{ t('settings.player.title') }}</h3>
                    <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-red-500/20"><VIcon :icon="mdiHeartPulse" color="#ef4444" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.player.health') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.player.health">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-blue-500/20"><VIcon :icon="mdiShieldHalfFull" color="#3b82f6" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.player.armor') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.player.armor">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-orange-500/20"><VIcon :icon="mdiFoodDrumstick" color="#f97316" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.player.hunger') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.player.hunger">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-cyan-500/20"><VIcon :icon="mdiCupWater" color="#06b6d4" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.player.thirst') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.player.thirst">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-yellow-500/20"><VIcon :icon="mdiRun" color="#facc15" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.player.stamina') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.player.stamina">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-indigo-500/20"><VIcon :icon="mdiLungs" color="#818cf8" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.player.oxygen') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.player.oxygen">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-slate-500/20"><VIcon :icon="mdiMicrophone" color="#e5e5e5" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.player.voice') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.player.voice">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-emerald-500/20"><VIcon :icon="mdiIdentifier" color="#10b981" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.player.playerId') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.player.playerId">
                      <span class="slider"></span>
                    </label>
                  </div>
                </div>

                <div v-else-if="activeTab === 'vehicle'" key="vehicle" class="space-y-3">
                  <div class="flex items-center gap-3 mb-6">
                    <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                    <h3 class="text-white font-semibold text-sm uppercase tracking-wider">{{ t('settings.vehicle.title') }}</h3>
                    <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-cyan-500/20"><VIcon :icon="mdiSpeedometer" color="#22d3ee" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.vehicle.speedometer') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.vehicle.speedometer">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-amber-500/20"><VIcon :icon="mdiGasStation" color="#d97706" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.vehicle.fuel') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.vehicle.fuel">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-red-500/20"><VIcon :icon="mdiSeatbelt" color="#ef4444" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.vehicle.seatbelt') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.vehicle.seatbelt">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-green-500/20"><VIcon :icon="mdiEngine" color="#22c55e" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.vehicle.engine') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.vehicle.engine">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-blue-500/20"><VIcon :icon="mdiCarLightHigh" color="#3b82f6" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.vehicle.headlights') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.vehicle.headlights">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-orange-500/20"><VIcon :icon="mdiArrowRightBold" color="#f97316" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.vehicle.indicators') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.vehicle.indicators">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-yellow-500/20"><VIcon :icon="mdiWeatherSunny" color="#facc15" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.vehicle.weather') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.vehicle.weather">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-slate-500/20"><VIcon :icon="mdiCompass" color="#e5e5e5" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.vehicle.compass') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.vehicle.compass">
                      <span class="slider"></span>
                    </label>
                  </div>

                  <div class="flex items-center justify-between py-3 px-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all">
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-lg flex items-center justify-center bg-blue-500/20"><VIcon :icon="mdiRoadVariant" color="#3b82f6" size="18" /></div>
                      <span class="text-slate-200 text-sm">{{ t('settings.vehicle.streetName') }}</span>
                    </div>
                    <label class="switch">
                      <input type="checkbox" v-model="store.visibility.vehicle.streetName">
                      <span class="slider"></span>
                    </label>
                  </div>
                </div>

                <div v-else-if="activeTab === 'colors'" key="colors" class="space-y-6">
                  <div>
                    <div class="flex items-center gap-3 mb-6">
                      <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                      <h3 class="text-white font-semibold text-sm uppercase tracking-wider">{{ t('settings.colors.player.title') }}</h3>
                      <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                    </div>

                    <div class="grid grid-cols-2 gap-3">
                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiHeartPulse" :color="store.colors.player.health" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.player.health') }}</span>
                        </div>
                        <label class="relative cursor-pointer">
                          <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.player.health }"></div>
                          <input type="color" v-model="store.colors.player.health" class="color-picker-input">
                        </label>
                      </div>

                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiShieldHalfFull" :color="store.colors.player.armor" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.player.armor') }}</span>
                        </div>
                        <label class="relative cursor-pointer">
                          <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.player.armor }"></div>
                          <input type="color" v-model="store.colors.player.armor" class="color-picker-input">
                        </label>
                      </div>

                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiFoodDrumstick" :color="store.colors.player.hunger" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.player.hunger') }}</span>
                        </div>
                        <label class="relative cursor-pointer">
                          <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.player.hunger }"></div>
                          <input type="color" v-model="store.colors.player.hunger" class="color-picker-input">
                        </label>
                      </div>

                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiCupWater" :color="store.colors.player.thirst" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.player.thirst') }}</span>
                        </div>
                        <label class="relative cursor-pointer">
                          <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.player.thirst }"></div>
                          <input type="color" v-model="store.colors.player.thirst" class="color-picker-input">
                        </label>
                      </div>

                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiRun" :color="store.colors.player.stamina" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.player.stamina') }}</span>
                        </div>
                        <label class="relative cursor-pointer">
                          <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.player.stamina }"></div>
                          <input type="color" v-model="store.colors.player.stamina" class="color-picker-input">
                        </label>
                      </div>

                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiLungs" :color="store.colors.player.oxygen" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.player.oxygen') }}</span>
                        </div>
                        <label class="relative cursor-pointer">
                          <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.player.oxygen }"></div>
                          <input type="color" v-model="store.colors.player.oxygen" class="color-picker-input">
                        </label>
                      </div>

                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30 col-span-2">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiMicrophone" :color="store.colors.player.voice" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.player.voice') }}</span>
                        </div>
                        <label class="relative cursor-pointer">
                          <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.player.voice }"></div>
                          <input type="color" v-model="store.colors.player.voice" class="color-picker-input">
                        </label>
                      </div>
                    </div>
                  </div>

                  <div>
                    <div class="flex items-center gap-3 mb-6">
                      <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                      <h3 class="text-white font-semibold text-sm uppercase tracking-wider">{{ t('settings.colors.vehicle.title') }}</h3>
                      <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                    </div>

                    <div class="grid grid-cols-2 gap-3">
                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiSpeedometer" :color="store.colors.vehicle.speedometerActive" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.vehicle.speedometer') }}</span>
                        </div>
                        <div class="flex gap-2">
                          <label class="relative cursor-pointer">
                            <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.vehicle.speedometerInactive }"></div>
                            <input type="color" v-model="store.colors.vehicle.speedometerInactive" class="color-picker-input">
                          </label>
                          <label class="relative cursor-pointer">
                            <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.vehicle.speedometerActive }"></div>
                            <input type="color" v-model="store.colors.vehicle.speedometerActive" class="color-picker-input">
                          </label>
                        </div>
                      </div>

                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiGasStation" :color="store.colors.vehicle.fuel" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.vehicle.fuel') }}</span>
                        </div>
                        <label class="relative cursor-pointer">
                          <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.vehicle.fuel }"></div>
                          <input type="color" v-model="store.colors.vehicle.fuel" class="color-picker-input">
                        </label>
                      </div>

                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiWeatherSunny" :color="store.colors.vehicle.weather" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.vehicle.weather') }}</span>
                        </div>
                        <label class="relative cursor-pointer">
                          <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.vehicle.weather }"></div>
                          <input type="color" v-model="store.colors.vehicle.weather" class="color-picker-input">
                        </label>
                      </div>

                      <div class="flex items-center justify-between py-2.5 px-3 rounded-xl bg-slate-800/40 border border-slate-700/30">
                        <div class="flex items-center gap-2">
                          <VIcon :icon="mdiRoadVariant" :color="store.colors.vehicle.streetName" size="16" />
                          <span class="text-slate-300 text-xs">{{ t('settings.colors.vehicle.streetName') }}</span>
                        </div>
                        <label class="relative cursor-pointer">
                          <div class="w-7 h-7 rounded-lg border-2 border-slate-600 hover:border-blue-400 transition-colors" :style="{ backgroundColor: store.colors.vehicle.streetName }"></div>
                          <input type="color" v-model="store.colors.vehicle.streetName" class="color-picker-input">
                        </label>
                      </div>
                    </div>
                  </div>
                </div>

                <div v-else-if="activeTab === 'layout'" key="layout" class="space-y-4">
                  <div class="flex items-center gap-3 mb-6">
                    <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                    <h3 class="text-white font-semibold text-sm uppercase tracking-wider">{{ t('settings.layout.title') }}</h3>
                    <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                  </div>

                  <button
                    class="w-full flex items-center gap-4 p-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all group"
                    @click="startPositionEdit"
                  >
                    <div class="w-12 h-12 rounded-xl flex items-center justify-center transition-colors bg-blue-500/20 group-hover:bg-blue-500/30">
                      <VIcon :icon="mdiCursorMove" color="#60a5fa" size="24" />
                    </div>
                    <div class="flex-1 text-left">
                      <span class="text-white font-medium">{{ t('settings.layout.position.button') }}</span>
                      <p class="text-slate-400 text-xs mt-0.5">Drag & drop elements</p>
                    </div>
                  </button>

                  <button
                    class="w-full flex items-center gap-4 p-4 rounded-xl bg-slate-800/40 border border-slate-700/30 hover:border-blue-500/30 transition-all group"
                    @click="openSizeModal"
                  >
                    <div class="w-12 h-12 rounded-xl flex items-center justify-center transition-colors bg-cyan-500/20 group-hover:bg-cyan-500/30">
                      <VIcon :icon="mdiResize" color="#22d3ee" size="24" />
                    </div>
                    <div class="flex-1 text-left">
                      <span class="text-white font-medium">{{ t('settings.layout.size.button') }}</span>
                      <p class="text-slate-400 text-xs mt-0.5">Adjust element scales</p>
                    </div>
                  </button>
                </div>
              </Transition>
            </div>
          </div>
        </div>
      </div>
    </div>
  </Transition>

  <Transition name="size-modal">
    <div
      v-if="store.isSizeEditMode"
      class="fixed right-0 top-1/2 -translate-y-1/2 z-[150] mr-6"
    >
      <div class="relative w-80 max-h-[85vh] overflow-hidden">
        <div class="absolute inset-0 bg-slate-900/95 backdrop-blur-xl rounded-2xl border border-blue-500/20 shadow-2xl shadow-blue-500/10"></div>

        <div class="relative">
          <div class="flex items-center justify-center gap-3 px-6 py-5 border-b border-slate-700/50">
            <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-cyan-500 to-blue-400 flex items-center justify-center">
              <VIcon :icon="mdiResize" color="white" size="16" />
            </div>
            <span class="text-white font-semibold">{{ t('settings.layout.size.title') }}</span>
          </div>

          <div class="p-5 max-h-[calc(85vh-140px)] overflow-y-auto scrollbar-thin scrollbar-track-slate-800/50 scrollbar-thumb-blue-600/40">
            <div class="flex items-center gap-3 mb-4">
              <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
              <h3 class="text-slate-300 font-medium text-xs uppercase tracking-wider">{{ t('settings.layout.size.player.title') }}</h3>
              <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
            </div>

            <div class="space-y-2 mb-6">
              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiHeartPulse" :color="store.colors.player.health" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.player.health') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.player.health" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiShieldHalfFull" :color="store.colors.player.armor" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.player.armor') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.player.armor" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiFoodDrumstick" :color="store.colors.player.hunger" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.player.hunger') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.player.hunger" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiCupWater" :color="store.colors.player.thirst" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.player.thirst') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.player.thirst" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiRun" :color="store.colors.player.stamina" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.player.stamina') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.player.stamina" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiLungs" :color="store.colors.player.oxygen" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.player.oxygen') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.player.oxygen" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiMicrophone" :color="store.colors.player.voice" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.player.voice') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.player.voice" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiIdentifier" color="#10b981" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.player.playerId') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.player.playerId" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>
            </div>

            <div class="flex items-center gap-3 mb-4">
              <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
              <h3 class="text-slate-300 font-medium text-xs uppercase tracking-wider">{{ t('settings.layout.size.vehicle.title') }}</h3>
              <div class="flex-1 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
            </div>

            <div class="space-y-2">
              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiSpeedometer" :color="store.colors.vehicle.speedometerActive" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.vehicle.speedometer') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.vehicle.speedometer" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <span class="text-slate-300 text-xs font-bold w-4 text-center">M</span>
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.vehicle.unit') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.vehicle.speedometerUnit" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiGasStation" :color="store.colors.vehicle.fuel" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.vehicle.fuel') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.vehicle.fuel" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiSeatbelt" color="#ef4444" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.vehicle.seatbelt') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.vehicle.seatbelt" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiCarLightHigh" color="#3b82f6" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.vehicle.headlights') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.vehicle.headlights" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiArrowRightBold" color="#f97316" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.vehicle.indicators') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.vehicle.indicators" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiEngine" color="#22c55e" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.vehicle.engine') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.vehicle.engine" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiWeatherSunny" :color="store.colors.vehicle.weather" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.vehicle.weather') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.vehicle.weather" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiCompass" color="#e5e5e5" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.vehicle.compass') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.vehicle.compass" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>

              <div class="flex items-center justify-between py-2 px-3 rounded-lg bg-slate-800/40 border border-slate-700/30">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiRoadVariant" :color="store.colors.vehicle.streetName" size="16" />
                  <span class="text-slate-300 text-xs">{{ t('settings.layout.size.vehicle.streetName') }}</span>
                </div>
                <input type="number" v-model.number="store.sizes.vehicle.streetName" min="0.5" max="5" step="0.1" class="w-16 px-2 py-1.5 bg-slate-800 border border-slate-600 rounded-lg text-white text-center text-xs focus:outline-none focus:border-blue-500 transition-colors">
              </div>
            </div>
          </div>

          <div class="flex gap-3 p-5 border-t border-slate-700/50">
            <button
              class="flex-1 py-2.5 rounded-xl bg-red-500/20 border border-red-500/30 text-red-400 font-medium text-sm hover:bg-red-500/30 transition-all"
              @click="store.cancelSizeEdit()"
            >
              {{ t('settings.buttons.cancel') }}
            </button>
            <button
              class="flex-1 py-2.5 rounded-xl bg-gradient-to-r from-blue-500 to-cyan-400 text-white font-medium text-sm hover:from-blue-600 hover:to-cyan-500 transition-all shadow-lg shadow-blue-500/30"
              @click="store.validateSizeEdit()"
            >
              {{ t('settings.buttons.validate') }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </Transition>
</template>

<style scoped>
.modal-enter-active,
.modal-leave-active {
  transition: all 0.3s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-from > div:last-child,
.modal-leave-to > div:last-child {
  transform: scale(0.95);
}

.tab-fade-enter-active,
.tab-fade-leave-active {
  transition: all 0.2s ease;
}

.tab-fade-enter-from,
.tab-fade-leave-to {
  opacity: 0;
  transform: translateX(-10px);
}

.size-modal-enter-active,
.size-modal-leave-active {
  transition: all 0.3s ease;
}

.size-modal-enter-from,
.size-modal-leave-to {
  opacity: 0;
  transform: translateX(100px) translateY(-50%);
}

.switch {
  @apply relative inline-block w-11 h-6;
}

.switch input {
  @apply opacity-0 w-0 h-0;
}

.slider {
  @apply absolute cursor-pointer inset-0 bg-slate-700 rounded-full transition-all duration-300;
}

.slider:before {
  @apply absolute content-[''] h-4 w-4 left-1 bottom-1 bg-slate-400 rounded-full transition-all duration-300;
}

input:checked + .slider {
  @apply bg-gradient-to-r from-blue-500 to-cyan-400;
}

input:checked + .slider:before {
  @apply translate-x-5 bg-white;
}

.color-picker-input {
  @apply absolute inset-0 opacity-0 cursor-pointer w-full h-full;
}
</style>
