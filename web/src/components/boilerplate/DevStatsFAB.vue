<script setup lang="ts">
import { ref } from 'vue'
import { useI18n } from 'vue-i18n'
import { usePlayerStats } from '@/composables/usePlayerStats'
import { useVehicleStats } from '@/composables/useVehicleStats'
import { useWeather, type WeatherType } from '@/composables/useWeather'
import { useCompass, type CardinalDirection } from '@/composables/useCompass'
import { useLocation } from '@/composables/useLocation'

const { t } = useI18n()
import {
  mdiTune,
  mdiClose,
  mdiHeartPulse,
  mdiShieldHalfFull,
  mdiFoodDrumstick,
  mdiCupWater,
  mdiRun,
  mdiLungs,
  mdiMicrophone,
  mdiSpeedometer,
  mdiGasStation,
  mdiSeatbelt,
  mdiEngine,
  mdiCarLightHigh,
  mdiArrowLeftBold,
  mdiArrowRightBold,
  mdiAlertOutline,
  mdiWeatherCloudy,
  mdiCompass,
  mdiRoadVariant,
} from '@/icons'

const { health, armor, hunger, thirst, stamina, oxygen, voiceMode, isTalking } = usePlayerStats()
const { speed, fuel, seatbelt, engineDamage, headlights, indicator } = useVehicleStats()
const { weather } = useWeather()
const { direction } = useCompass()
const { streetName } = useLocation()

const headlightModes: ('off' | 'on' | 'highbeam')[] = ['off', 'on', 'highbeam']
const headlightIndex = ref(headlightModes.indexOf(headlights.value))

const updateHeadlights = (index: number) => {
  headlightIndex.value = index
  headlights.value = headlightModes[index] ?? 'off'
}

const indicatorModes: ('off' | 'left' | 'right' | 'hazard')[] = ['off', 'left', 'right', 'hazard']
const indicatorIndex = ref(indicatorModes.indexOf(indicator.value))

const updateIndicator = (index: number) => {
  indicatorIndex.value = index
  indicator.value = indicatorModes[index] ?? 'off'
}

const voiceModes: string[] = ['Whisper', 'Normal', 'Shouting', 'Megaphone']
const voiceIndex = ref(voiceModes.findIndex(m => m.toLowerCase().includes(voiceMode.value.toLowerCase())))

const updateVoice = (index: number) => {
  voiceIndex.value = index
  voiceMode.value = voiceModes[index] ?? 'Normal'
}

const weatherModes: WeatherType[] = [
  'extrasunny', 'clear', 'neutral', 'smog', 'foggy',
  'overcast', 'clouds', 'clearing', 'rain', 'thunder',
  'snow', 'blizzard', 'snowlight', 'xmas', 'halloween'
]
const weatherIndex = ref(weatherModes.indexOf(weather.value))

const updateWeather = (index: number) => {
  weatherIndex.value = index
  weather.value = weatherModes[index] ?? 'clear'
}

const compassModes: CardinalDirection[] = ['N', 'NE', 'E', 'SE', 'S', 'SO', 'O', 'NO']
const compassIndex = ref(compassModes.indexOf(direction.value))

const updateCompass = (index: number) => {
  compassIndex.value = index
  direction.value = compassModes[index] ?? 'N'
}

const isOpen = ref(false)
</script>

<template>
  <div class="fixed bottom-8 left-8 z-50">
    <VBtn
      icon
      size="large"
      class="bg-charcoal-elegant !border border-gray-400/30 hover:scale-105 transition-transform duration-300"
      @click="isOpen = true"
    >
      <VIcon :icon="mdiTune" color="white" />
    </VBtn>
  </div>

  <VDialog v-model="isOpen" width="auto" :scrim="false">
    <VCard class="bg-charcoal-elegant !border border-gray-400/30">
      <VCardTitle class="flex items-center justify-between !py-4 !px-6 border-b border-gray-600/30">
        <span class="text-white text-lg font-semibold">{{ t('devStats.title') }}</span>
        <VBtn icon variant="text" size="small" @click="isOpen = false">
          <VIcon :icon="mdiClose" color="white" />
        </VBtn>
      </VCardTitle>

      <VCardText class="pa-6">
        <div class="flex justify-center items-center gap-12">
          <div class="flex flex-col items-center gap-2">
            <VIcon :icon="mdiHeartPulse" color="#ef4444" size="24" />
            <span class="text-white text-sm font-mono">{{ health }}</span>
            <VSlider
              v-model="health"
              direction="vertical"
              :min="0"
              :max="100"
              :step="1"
              thumb-label
              track-color="rgba(255,255,255,0.1)"
              color="#ef4444"
              :height="120"
            />
          </div>

          <div class="flex flex-col items-center gap-2">
            <VIcon :icon="mdiShieldHalfFull" color="#3b82f6" size="24" />
            <span class="text-white text-sm font-mono">{{ armor }}</span>
            <VSlider
              v-model="armor"
              direction="vertical"
              :min="0"
              :max="100"
              :step="1"
              thumb-label
              track-color="rgba(255,255,255,0.1)"
              color="#3b82f6"
              :height="120"
            />
          </div>

          <div class="flex flex-col items-center gap-2">
            <VIcon :icon="mdiFoodDrumstick" color="#f97316" size="24" />
            <span class="text-white text-sm font-mono">{{ hunger }}</span>
            <VSlider
              v-model="hunger"
              direction="vertical"
              :min="0"
              :max="100"
              :step="1"
              thumb-label
              track-color="rgba(255,255,255,0.1)"
              color="#f97316"
              :height="120"
            />
          </div>

          <div class="flex flex-col items-center gap-2">
            <VIcon :icon="mdiCupWater" color="#06b6d4" size="24" />
            <span class="text-white text-sm font-mono">{{ thirst }}</span>
            <VSlider
              v-model="thirst"
              direction="vertical"
              :min="0"
              :max="100"
              :step="1"
              thumb-label
              track-color="rgba(255,255,255,0.1)"
              color="#06b6d4"
              :height="120"
            />
          </div>

          <div class="flex flex-col items-center gap-2">
            <VIcon :icon="mdiRun" color="#eab308" size="24" />
            <span class="text-white text-sm font-mono">{{ stamina }}</span>
            <VSlider
              v-model="stamina"
              direction="vertical"
              :min="0"
              :max="100"
              :step="1"
              thumb-label
              track-color="rgba(255,255,255,0.1)"
              color="#eab308"
              :height="120"
            />
          </div>

          <div class="flex flex-col items-center gap-2">
            <VIcon :icon="mdiLungs" color="#6366f1" size="24" />
            <span class="text-white text-sm font-mono">{{ oxygen }}</span>
            <VSlider
              v-model="oxygen"
              direction="vertical"
              :min="0"
              :max="100"
              :step="1"
              thumb-label
              track-color="rgba(255,255,255,0.1)"
              color="#6366f1"
              :height="120"
            />
          </div>
        </div>

        <div class="mt-6 pt-4 border-t border-gray-600/30">
          <div class="flex justify-center gap-12">
            <div class="flex flex-col items-center gap-2">
              <div class="flex items-center gap-2">
                <VIcon :icon="mdiMicrophone" color="#e5e5e5" size="24" />
                <span class="text-white text-sm">{{ voiceMode }}</span>
              </div>
              <VSlider
                :model-value="voiceIndex"
                :min="0"
                :max="3"
                :step="1"
                track-color="rgba(255,255,255,0.1)"
                color="#e5e5e5"
                class="w-64"
                @update:model-value="updateVoice"
              />
              <div class="flex items-center gap-2 mt-2">
                <span class="text-white text-xs">{{ t('devStats.talking') }}</span>
                <VSwitch
                  v-model="isTalking"
                  color="#22c55e"
                  hide-details
                  density="compact"
                />
              </div>
            </div>

            <div class="flex flex-col items-center gap-2">
              <div class="flex items-center gap-2">
                <VIcon :icon="mdiWeatherCloudy" color="#60a5fa" size="24" />
                <span class="text-white text-sm">{{ t(`devStats.weather.${weather}`) }}</span>
              </div>
              <VSlider
                :model-value="weatherIndex"
                :min="0"
                :max="14"
                :step="1"
                track-color="rgba(255,255,255,0.1)"
                color="#60a5fa"
                class="w-64"
                @update:model-value="updateWeather"
              />
            </div>

            <div class="flex flex-col items-center gap-2">
              <div class="flex items-center gap-2">
                <VIcon :icon="mdiCompass" color="#a78bfa" size="24" />
                <span class="text-white text-sm">{{ direction }}</span>
              </div>
              <VSlider
                :model-value="compassIndex"
                :min="0"
                :max="7"
                :step="1"
                track-color="rgba(255,255,255,0.1)"
                color="#a78bfa"
                class="w-64"
                @update:model-value="updateCompass"
              />
            </div>
          </div>
        </div>

        <div class="mt-6 pt-4 border-t border-gray-600/30">
          <div class="flex flex-col items-center gap-2">
            <div class="flex items-center gap-2">
              <VIcon :icon="mdiRoadVariant" color="#22d3ee" size="24" />
              <span class="text-white text-sm">{{ t('devStats.street') }}</span>
            </div>
            <VTextField
              v-model="streetName"
              density="compact"
              variant="outlined"
              hide-details
              class="w-64"
            />
          </div>
        </div>

        <div class="mt-6 pt-4 border-t border-gray-600/30">
          <div class="flex justify-center gap-16">
            <div class="flex flex-col gap-6">
              <div class="flex flex-col items-center gap-2">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiSpeedometer" color="#38bdf8" size="24" />
                  <span class="text-white text-sm font-mono">{{ speed }} MPH</span>
                </div>
                <VSlider
                  v-model="speed"
                  :min="0"
                  :max="300"
                  :step="1"
                  track-color="rgba(255,255,255,0.1)"
                  color="#38bdf8"
                  class="w-64"
                />
              </div>

              <div class="flex flex-col items-center gap-2">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiSeatbelt" :color="seatbelt ? '#22c55e' : '#ef4444'" size="24" />
                  <span class="text-white text-sm">{{ t('devStats.seatbelt') }}</span>
                </div>
                <VSwitch
                  v-model="seatbelt"
                  color="#22c55e"
                  hide-details
                />
              </div>

              <div class="flex flex-col items-center gap-2">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiCarLightHigh" :color="headlights === 'highbeam' ? '#3b82f6' : headlights === 'on' ? '#22c55e' : '#6b7280'" size="24" />
                  <span class="text-white text-sm">{{ t(`devStats.headlights.${headlights}`) }}</span>
                </div>
                <VSlider
                  :model-value="headlightIndex"
                  :min="0"
                  :max="2"
                  :step="1"
                  track-color="rgba(255,255,255,0.1)"
                  color="#3b82f6"
                  class="w-64"
                  @update:model-value="updateHeadlights"
                />
              </div>
            </div>

            <div class="flex flex-col gap-6">
              <div class="flex flex-col items-center gap-2">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiGasStation" color="#d97706" size="24" />
                  <span class="text-white text-sm font-mono">{{ fuel }}%</span>
                </div>
                <VSlider
                  v-model="fuel"
                  :min="0"
                  :max="100"
                  :step="1"
                  track-color="rgba(255,255,255,0.1)"
                  color="#d97706"
                  class="w-64"
                />
              </div>

              <div class="flex flex-col items-center gap-2">
                <div class="flex items-center gap-2">
                  <VIcon :icon="mdiEngine" :color="engineDamage > 50 ? '#ef4444' : '#ffffff'" size="24" />
                  <span class="text-white text-sm font-mono">{{ engineDamage }}%</span>
                </div>
                <VSlider
                  v-model="engineDamage"
                  :min="0"
                  :max="100"
                  :step="1"
                  track-color="rgba(255,255,255,0.1)"
                  color="#ef4444"
                  class="w-full max-w-xs"
                />
              </div>

              <div class="flex flex-col items-center gap-2">
                <div class="flex items-center gap-2">
                  <VIcon
                    :icon="indicator === 'left' ? mdiArrowLeftBold : indicator === 'right' ? mdiArrowRightBold : mdiAlertOutline"
                    :color="indicator === 'hazard' ? '#ef4444' : indicator !== 'off' ? '#22c55e' : '#6b7280'"
                    size="24"
                  />
                  <span class="text-white text-sm">{{ t(`devStats.indicators.${indicator}`) }}</span>
                </div>
                <VSlider
                  :model-value="indicatorIndex"
                  :min="0"
                  :max="3"
                  :step="1"
                  track-color="rgba(255,255,255,0.1)"
                  color="#22c55e"
                  class="w-64"
                  @update:model-value="updateIndicator"
                />
              </div>
            </div>
          </div>
        </div>
      </VCardText>
    </VCard>
  </VDialog>
</template>
