import { ref } from 'vue'

export type CardinalDirection = 'N' | 'NE' | 'E' | 'SE' | 'S' | 'SO' | 'O' | 'NO'

const direction = ref<CardinalDirection>('N')

export function useCompass() {
  return {
    direction,
  }
}
