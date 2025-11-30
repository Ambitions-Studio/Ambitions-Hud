<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  value: number
  color?: string
}>()

const defaultSegments: boolean[] = [true, true, true, false, true, true, true]

const segments = computed((): boolean[] => {
  const map: Record<number, boolean[]> = {
    0: [true, true, true, false, true, true, true],
    1: [false, false, true, false, false, true, false],
    2: [true, false, true, true, true, false, true],
    3: [true, false, true, true, false, true, true],
    4: [false, true, true, true, false, true, false],
    5: [true, true, false, true, false, true, true],
    6: [true, true, false, true, true, true, true],
    7: [true, false, true, false, false, true, false],
    8: [true, true, true, true, true, true, true],
    9: [true, true, true, true, false, true, true],
  }
  return map[props.value] ?? defaultSegments
})

const activeColor = computed(() => props.color || '#22d3ee')
const inactiveColor = computed(() => '#404040')
</script>

<template>
  <svg width="32" height="52" viewBox="0 0 24 40">
    <polygon
      :points="'2,1 22,1 19,4 5,4'"
      :fill="segments[0] ? activeColor : inactiveColor"
    />
    <polygon
      :points="'1,2 4,5 4,18 1,20'"
      :fill="segments[1] ? activeColor : inactiveColor"
    />
    <polygon
      :points="'23,2 23,20 20,18 20,5'"
      :fill="segments[2] ? activeColor : inactiveColor"
    />
    <polygon
      v-if="segments[3]"
      :points="'3,20 5,18 19,18 21,20 19,22 5,22'"
      :fill="activeColor"
    />
    <polygon
      :points="'1,21 4,23 4,36 1,39'"
      :fill="segments[4] ? activeColor : inactiveColor"
    />
    <polygon
      :points="'23,21 23,39 20,36 20,23'"
      :fill="segments[5] ? activeColor : inactiveColor"
    />
    <polygon
      :points="'2,40 5,37 19,37 22,40'"
      :fill="segments[6] ? activeColor : inactiveColor"
    />
  </svg>
</template>
