<script setup lang="ts">
defineProps<{
  id: number
}>()
</script>

<template>
  <div class="w-14 h-14 md:w-16 md:h-16 flex items-center justify-center drop-shadow-lg">
    <div
      class="w-12 h-12 md:w-14 md:h-14 hexagon flex items-center justify-center transition-transform duration-300 hover:scale-105"
      :style="{
        background: `linear-gradient(135deg, rgba(255,255,255,0.2), rgba(255,255,255,0.05))`,
        boxShadow: `0 0 15px rgba(255,255,255,0.15), inset 0 0 8px rgba(255,255,255,0.1)`
      }"
    >
      <div class="w-11 h-11 md:w-[3.25rem] md:h-[3.25rem] hexagon relative overflow-hidden bg-zinc-900/95 flex flex-col items-center justify-center">
        <span class="text-neutral-400 text-[8px] md:text-[9px] uppercase tracking-wider">ID</span>
        <span class="text-white font-bold text-base md:text-lg leading-none">{{ id }}</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.hexagon {
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
}
</style>
