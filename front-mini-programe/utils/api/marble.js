import { setRequestConfig } from '@/utils/request.js';

// 调用setRequestConfig函数进行请求配置
setRequestConfig();

const http = uni.$u.http

//获取充电站列表  /wx-api/station/list   get
/*
参数：{"name":"新安","address":"深圳市","pageNo":1,"pageSize":2,我的位置#"coordinate":"36.5853,109.4898"}
*/
// export const requestStations = (name,address,pageNo,pageSize,coordinate) => http.get(`/wx-api/station/list?name=${name}&address=${address}&pageNo=${pageNo}&pageSize=${pageSize}&coordinate=${coordinate}`)
export const requestStations = params => http.get('/wx-api/station/list', { params })

//获取充电桩列表  /wx-api/pile/list  get   参数："stationId":1
export const requestPiles = (stationId) => http.get(`/wx-api/pile/list?stationId=${stationId}`)

//开始充电  /wx-api/charge/start  post  参数："pileId":22
export const requestStartCharge = (pileId) => http.post(`/wx-api/charge/start?pileId=${pileId}`)

//获取充电订单列表  /wx-api/charge/list  get
export const requestChargeOrders = (pageNo, pageSize) => http.get(`/wx-api/charge/list?pageNo=${pageNo}&pageSize=${pageSize}`)

//停止充电  /wx-api/charge/stop post  参数："orderId":6
export const requestStopCharge = (orderId) => http.post(`/wx-api/charge/stop?orderId=${orderId}`)

//展示不同区间价格  /api/charge/price/list?pageNo=1&pageSize=2   get
export const requestChargePrice = (pageNo, pageSize) => http.get(`/wx-api/price/list?pageNo=${pageNo}&pageSize=${pageSize}`)

//大理石名称列表  /wx-api/marble/name/list?pageNo=1&pageSize=2   get
export const requestMarbleList = (pageNo, pageSize) => http.get(`/wx-api/marble/name/list?pageNo=${pageNo}&pageSize=${pageSize}`)

//大理石列表 http://127.0.0.1:8000/wx-api/marbles/marble/list
export const requestMarblesList = (name,pageNo, pageSize) => http.get(`/wx-api/marbles/marble/list?name=${name}&pageNo=${pageNo}&pageSize=${pageSize}`)

//http://127.0.0.1:8000/wx-api/marbles/list
// export const requestCommonList =  (name,type,pageNo, pageSize) => http.get(`/wx-api/marbles/list?name=${name}&type=${type}&pageNo=${pageNo}&pageSize=${pageSize}`)
export const requestCommonList = (name, type, pageNo, pageSize, sn = '') => {
  let url = `/wx-api/marbles/list?name=${name}&type=${type}&pageNo=${pageNo}&pageSize=${pageSize}`;
  if (sn) {
    url += `&sn=${sn}`;  // 如果 sn 参数有值，添加到 URL 中
  }
  return http.get(url);
}

//http://127.0.0.1:8000/wx-api/marble/password
export const requestPassword = () => http.get(`/wx-api/marble/password`)

//http://127.0.0.1:8000/wx-api/marble/store/list
export const requestStoreList = () => http.get('/wx-api/marble/store/list')