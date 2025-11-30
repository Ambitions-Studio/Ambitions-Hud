import { ref } from 'vue'

export type WeatherType =
  | 'extrasunny'
  | 'clear'
  | 'neutral'
  | 'smog'
  | 'foggy'
  | 'overcast'
  | 'clouds'
  | 'clearing'
  | 'rain'
  | 'thunder'
  | 'snow'
  | 'blizzard'
  | 'snowlight'
  | 'xmas'
  | 'halloween'

const weather = ref<WeatherType>('clear')

export function useWeather() {
  return {
    weather,
  }
}
