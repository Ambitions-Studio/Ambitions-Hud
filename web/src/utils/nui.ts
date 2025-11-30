import axios, { type AxiosInstance, type AxiosResponse } from 'axios'

const RESOURCE_NAME = 'Ambitions-Hud'

const nuiClient: AxiosInstance = axios.create({
  baseURL: `https://${RESOURCE_NAME}`,
  timeout: 5000,
  headers: {
    'Content-Type': 'application/json',
  },
})

nuiClient.interceptors.response.use(
  (response: AxiosResponse) => {
    return response
  },
  (error) => {
    if (import.meta.env.DEV) {
      console.warn(`[NUI] Request failed:`, error.config?.url, error.message)
    }
    return Promise.reject(error)
  }
)

export interface NuiCallbackResponse<T = unknown> {
  data: T
  status: number
}

export async function sendNuiCallback<T = unknown, R = unknown>(
  eventName: string,
  data?: T
): Promise<R | null> {
  try {
    const response = await nuiClient.post<R>(eventName, data || {})
    return response.data
  } catch (error) {
    if (import.meta.env.DEV) {
      console.error(`[NUI] Failed to send callback "${eventName}":`, error)
    }
    return null
  }
}

export async function sendNuiEvent<T = unknown>(eventName: string, data?: T): Promise<boolean> {
  try {
    await nuiClient.post(eventName, data || {})
    return true
  } catch (error) {
    if (import.meta.env.DEV) {
      console.error(`[NUI] Failed to send event "${eventName}":`, error)
    }
    return false
  }
}

export default {
  sendNuiCallback,
  sendNuiEvent,
}
