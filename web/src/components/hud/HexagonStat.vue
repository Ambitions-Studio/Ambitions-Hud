<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  icon: string
  value?: number
  iconColor?: string
  iconOpacity?: number
  bgGradientFrom?: string
  bgGradientTo?: string
  shadowColor?: string
  glow?: boolean
  pulse?: boolean
}>()

const fillPercent = computed(() => {
  return props.value ?? 100
})
</script>

<template>
  <div
    class="w-14 h-14 md:w-16 md:h-16 flex items-center justify-center transition-[filter] duration-300"
    :class="{ 'animate-talking': pulse }"
    :style="{
      filter: glow
        ? `drop-shadow(0 0 12px ${iconColor}) drop-shadow(0 0 30px ${iconColor})`
        : `drop-shadow(0 4px 6px rgba(0,0,0,0.4))`
    }"
  >
    <div
      class="w-12 h-12 md:w-14 md:h-14 hexagon flex items-center justify-center transition-transform duration-300 hover:scale-105"
      :style="{
        background: glow
          ? `linear-gradient(135deg, ${iconColor}40, ${iconColor}20)`
          : `linear-gradient(135deg, rgba(255,255,255,0.3), rgba(255,255,255,0.1))`
      }"
    >
      <div class="w-11 h-11 md:w-[3.25rem] md:h-[3.25rem] hexagon relative overflow-hidden">
        <div class="absolute inset-0 bg-zinc-900/95"></div>
        <div
          class="absolute bottom-0 left-0 right-0 transition-[height] duration-300"
          :style="{
            height: `${fillPercent}%`,
            background: `linear-gradient(145deg, ${bgGradientFrom}, ${bgGradientTo})`
          }"
        ></div>
        <div class="absolute inset-0 flex items-center justify-center z-10">
          <VIcon
            :icon="icon"
            :color="iconColor"
            class="text-xl md:text-2xl"
            :style="{ opacity: iconOpacity ?? 1 }"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.hexagon {
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
}

@keyframes talking {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.6;
  }
}

.animate-talking {
  animation: talking 0.8s ease-in-out infinite;
  will-change: opacity;
}
</style>
