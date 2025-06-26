import http from '@ohos.net.http';
import { ResponseResult } from './response';


export function request(url: string, method: http.RequestMethod, headers?: Record<string, Object>,
  data?: Record<string, Object>): Promise<ResponseResult> {
  const BASE_URL = 'https://marble.lusson.xyz'
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(BASE_URL + url, {
    method: method,
    header: headers,
    extraData: JSON.stringify(data),
  });
  let response: ResponseResult = new ResponseResult();
  console.log('lucy== response',JSON.stringify(response),JSON.stringify(responseResult))
  return responseResult.then((value: http.HttpResponse) => {
    console.log('lucy== 111')
    if (value.responseCode === 200) {
      let res: ResponseResult = JSON.parse(`${value.result}`);
      response.data = res.data;
      response.code = res.code;
      response.message = res.message;
    } else {
      response.message = '请求错误';
      response.code = 400;
    }
    return response;
  }).catch((error: Error) => {
    response.message = '请求错误';
    response.code = 400;
    return response;
  })
}
