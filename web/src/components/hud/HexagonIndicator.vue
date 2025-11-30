<script setup lang="ts">
import { computed } from 'vue'
import { mdiArrowLeftBold, mdiArrowRightBold, mdiAlertOutline } from '@/icons'

const props = defineProps<{
  mode: 'left' | 'right' | 'hazard' | 'both' | 'off'
}>()

const icon = computed(() => {
  if (props.mode === 'left') return mdiArrowLeftBold
  if (props.mode === 'right') return mdiArrowRightBold
  if (props.mode === 'both') return mdiAlertOutline
  return mdiAlertOutline
})

const iconColor = computed(() => {
  if (props.mode === 'hazard') return '#ef4444'
  if (props.mode === 'both') return '#f97316'
  return '#22c55e'
})
</script>

<template>
  <div class="w-12 h-12 flex items-center justify-center drop-shadow-lg animate-blink">
    <div
      class="w-11 h-11 hexagon flex items-center justify-center"
      :style="{
        background: `linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05))`,
        boxShadow: `0 0 12px ${iconColor}50, inset 0 0 6px ${iconColor}30`
      }"
    >
      <div class="w-10 h-10 hexagon relative overflow-hidden bg-zinc-900/95 flex items-center justify-center">
        <VIcon
          :icon="icon"
          :color="iconColor"
          class="text-lg"
        />
      </div>
    </div>
  </div>
</template>

<style scoped>
.hexagon {
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
}

@keyframes blink {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.2;
  }
}

.animate-blink {
  animation: blink 0.6s ease-in-out infinite;
}
</style>
