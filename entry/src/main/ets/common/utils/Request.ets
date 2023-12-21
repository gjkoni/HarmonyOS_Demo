import http from '@ohos.net.http';
import { CommonConstants } from '../constants/CommonConstants';
import Logger from './Logger';
import PreferencesUtils from './PreferencesUtils';
import Response from './Response';

//导出httpRequest请求函数
export function request(url: string, method: string, requestData?: any): Promise<Response>{
  //如果使用本地模拟器，则ip为本机的IP地址
  const BASE_URL: string = CommonConstants.RELEASE ? CommonConstants.ApiHost : CommonConstants.ApiHost_DEV
  let httpRequest = http.createHttp()
  let requestUrl = BASE_URL + url;
  Logger.debug(`request start`, '');

  return PreferencesUtils.get('token', '').then((v)=>{
    return createRequest(requestUrl, method, requestData, httpRequest, v as string)
  })

  // return new Promise(async (resolve: Function) => {
  //   let token = await PreferencesUtils.get('token', '');
  //   Logger.debug(`token-${token as string}`);
  //   resolve(createRequest(requestUrl, method, requestData, httpRequest, token as string));
  // });
}

function createRequest(url:string, method:string, requestData:any,httpRequest:http.HttpRequest, token?:string ): Promise<Response>{
  Logger.debug(`ttttt-${token}`);

  let httpOptions = {
    method: getRequestMethod(method),
    header: {
      'Content-Type': 'application/json'
    },
    //携带额外参数
    extraData: JSON.stringify(requestData),
    //可选，默认为60000ms
    connectTimeout: 60000,
    readTimeout: 60000,
  };
  if(token && token != ''){
    httpOptions.header['Authorization'] = `Bearer ${token}`
  }
  let responseResult = httpRequest.request(
    url,
    httpOptions
  )
  let response = new Response();
  //处理数据，并返回

  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === 200) {
      Logger.info('response-200', `${value.result}`)
      //获取返回数据,将返回的json数据解析成事先预定好的响应格式
      //这里建议和后端的保持一致
      let res: Response = JSON.parse(`${value.result}`);
      response.data = res.data;
      response.code = res.code;
      response.message = res.message;
    }else {
      Logger.info('response-400', `${value.responseCode}`)
      response.message = `请求错误，${value.result}`;
      response.code = 400;
    }
    return response;
  }).catch((err: Error) => {
    Logger.info('response-400', `${err.message}`)
    response.message = `请求错误：${err.message}`;
    response.code = 400;
    return response;
  });
}

// 辅助函数，将方法字符串映射到 http.RequestMethod
function getRequestMethod(method: string): http.RequestMethod {
  switch (method.toLowerCase()) {
    case 'get':
      return http.RequestMethod.GET;
    case 'post':
      return http.RequestMethod.POST;
    case 'put':
      return http.RequestMethod.PUT;
    case 'delete':
      return http.RequestMethod.DELETE;
  // 针对其他 HTTP 方法需要添加更多的情况
    default:
      throw new Error(`不支持的 HTTP 方法: ${method}`);
  }
}