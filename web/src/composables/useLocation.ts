import { ref } from 'vue'

const streetName = ref('Vinewood Blvd')

export function useLocation() {
  return {
    streetName,
  }
}
