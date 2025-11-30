<script setup lang="ts">
import { ref } from 'vue'
import DevInfoMenu from '@/components/boilerplate/DevInfoMenu.vue'
import DevStatsFAB from '@/components/boilerplate/DevStatsFAB.vue'
import HudView from '@/views/HudView.vue'

const currentView = ref('hud')
</script>

<template>
  <div
    class="fixed inset-0 w-full h-full bg-contain bg-center bg-no-repeat bg-gray-900 sm:bg-contain md:bg-cover lg:bg-cover xl:bg-cover 2xl:bg-cover bg-[url('/boilerplate-background.jpg')] transition-all duration-300"
  >
    <div class="absolute inset-0 bg-black/20"></div>

    <DevInfoMenu :current-view="currentView" />

    <!-- <DevStatusBar /> -->

    <HudView show-settings-fab force-visible />

    <DevStatsFAB />
  </div>
</template>
