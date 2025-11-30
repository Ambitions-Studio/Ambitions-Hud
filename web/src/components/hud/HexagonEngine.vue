<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  icon: string
  damage: number
}>()

const opacity = computed(() => {
  if (props.damage <= 0) return 0
  return Math.min(props.damage / 50, 1)
})

const iconColor = computed(() => {
  const d = props.damage / 100
  const r = Math.round(255)
  const g = Math.round(255 * (1 - d))
  const b = Math.round(255 * (1 - d))
  return `rgb(${r}, ${g}, ${b})`
})

const animationClass = computed(() => {
  if (props.damage >= 100) return 'animate-critical'
  if (props.damage >= 75) return 'animate-blink'
  return ''
})
</script>

<template>
  <div
    v-if="damage > 0"
    class="w-12 h-12 flex items-center justify-center drop-shadow-lg transition-opacity duration-300"
    :class="animationClass"
    :style="{ opacity }"
  >
    <div
      class="w-11 h-11 hexagon flex items-center justify-center"
      :style="{
        background: `linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05))`,
        boxShadow: `0 0 12px rgba(239, 68, 68, ${damage / 200}), inset 0 0 6px rgba(239, 68, 68, ${damage / 300})`
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
    opacity: 0.4;
  }
}

@keyframes critical {
  0%, 100% {
    opacity: 1;
    transform: scale(1);
  }
  50% {
    opacity: 0.4;
    transform: scale(1.15);
  }
}

.animate-blink {
  animation: blink 0.6s ease-in-out infinite;
}

.animate-critical {
  animation: critical 0.5s ease-in-out infinite;
}
</style>
