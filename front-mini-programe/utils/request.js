
import useUserStore from '@/store/user.js'
export const setRequestConfig = () => {
  uni.$u.http.setConfig((config) => {
    /* config 为默认全局配置*/
	// config.baseURL = 'http://127.0.0.1:8000/'
    config.baseURL = 'https://marble.lusson.xyz'
    return config
  })
  // 请求拦截
  uni.$u.http.interceptors.request.use(
    (config) => {
      let token = useUserStore().token
      if (token) {
        config.header.Authorization = `Bearer ${token}`
      }
      return config
    },
    (error) => {
      return Promise.reject(error)
    }
  )
  // 响应拦截
  uni.$u.http.interceptors.response.use(
    (response) => {
      if (response.data.code == 401) {
        // 提示重新登录
        uni.$showMsg('请登录')
        useUserStore().userLogout()
        setTimeout(() => {
          uni.switchTab({
            url: '/pages/my/my'
          })
        }, 1000);
        
      }
      return response
    },
    (error) => {
      return Promise.reject(error)
    }
  )
}
