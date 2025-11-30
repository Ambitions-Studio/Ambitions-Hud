<script setup lang="ts">
import BoilerplateView from './views/BoilerplateView.vue'
import HudView from './views/HudView.vue'

const isDevelopment = import.meta.env.DEV
</script>

<template>
  <VApp>
    <BoilerplateView v-if="isDevelopment" />
    <HudView v-else />
  </VApp>
</template>