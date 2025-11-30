<script setup lang="ts">
defineProps<{
  icon: string
  iconColor?: string
}>()
</script>

<template>
  <div class="w-12 h-12 flex items-center justify-center drop-shadow-lg animate-warning">
    <div
      class="w-11 h-11 hexagon flex items-center justify-center"
      :style="{
        background: `linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05))`,
        boxShadow: `0 0 15px rgba(239, 68, 68, 0.5), inset 0 0 8px rgba(239, 68, 68, 0.3)`
      }"
    >
      <div class="w-10 h-10 hexagon relative overflow-hidden bg-zinc-900/95 flex items-center justify-center">
        <VIcon
          :icon="icon"
          :color="iconColor || '#ef4444'"
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

@keyframes warning {
  0%, 100% {
    opacity: 1;
    transform: scale(1);
  }
  50% {
    opacity: 0.5;
    transform: scale(1.1);
  }
}

.animate-warning {
  animation: warning 0.8s ease-in-out infinite;
}
</style>
