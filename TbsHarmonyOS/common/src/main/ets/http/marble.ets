import http from '@ohos.net.http';
import { Apis } from '../../../../Index';
import { request } from './httpUtils'

export function getToken() {
  return request('/wx-api/marble/password', http.RequestMethod.GET)
}

export function requestStoreList() {
  return request(Apis.STORE_LIST, http.RequestMethod.GET)
}

export function requestMarbleList(pageNo: number, pageSize: number) {
  return request(`${Apis.MARBLE_NAME}?pageNo=${pageNo}&pageSize=${pageSize}`, http.RequestMethod.GET);
}

export function requestMarblesList(name: string, pageNo: number, pageSize: number) {
  return request(`${Apis.MARBLE_LIST}?name=${name}&pageNo=${pageNo}&pageSize=${pageSize}`, http.RequestMethod.GET)
}

export function requestMarblePassword() {
  return request(Apis.MARBLE_PASSWORD, http.RequestMethod.GET)
}

export function requestCommonList(name: string, type: string, pageNo: number, pageSize: number, sn: string = '') {
  let url = `${Apis.COMMON_LIST}?name=${name}&type=${type}&pageNo=${pageNo}&pageSize=${pageSize}`
  if (sn) {
    return request(url += `&sn=${sn}`, http.RequestMethod.GET)
  }
  return request(url, http.RequestMethod.GET)
}
