import { defineStore } from 'pinia'

export const useLocationStore = defineStore('location', {
  state: () => ({
    coordinate: {
      latitude: 22.53612, // 默认深圳坐标
      longitude: 114.0635
    }
  }),
  actions: {
    // 设置坐标
    setCoordinate(location) {
      this.coordinate = location
    },
    
    // 获取用户位置
    async getCurrentLocation() {
      try {
        await uni.authorize({ scope: 'scope.userLocation' })
        const res = await uni.getLocation({ type: 'gcj02' })
        this.setCoordinate({
          latitude: res.latitude,
          longitude: res.longitude
        })
        return res
      } catch (error) {
        console.error('获取位置失败:', error)
        throw error
      }
    }
  }
})