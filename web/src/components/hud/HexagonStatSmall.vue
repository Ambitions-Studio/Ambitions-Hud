<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  icon: string
  value?: number
  iconColor?: string
  bgGradientFrom?: string
  bgGradientTo?: string
  shadowColor?: string
}>()

const fillPercent = computed(() => props.value ?? 100)
</script>

<template>
  <div class="w-12 h-12 flex items-center justify-center drop-shadow-lg">
    <div
      class="w-11 h-11 hexagon flex items-center justify-center"
      :style="{
        background: `linear-gradient(135deg, rgba(255,255,255,0.25), rgba(255,255,255,0.08))`,
        boxShadow: `0 0 12px ${shadowColor}40, inset 0 0 6px ${shadowColor}25`
      }"
    >
      <div class="w-10 h-10 hexagon relative overflow-hidden">
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
            class="text-lg"
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
</style>
