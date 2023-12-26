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
  let requestUrl = url.startsWith("http")? url : BASE_URL + url;
  Logger.debug(`request start`, '');

  return PreferencesUtils.get('token', '').then((v)=>{
    return createRequest(httpRequest, requestUrl, method, requestData, v as string)
  })

  // return new Promise(async (resolve: Function) => {
  //   let token = await PreferencesUtils.get('token', '');
  //   Logger.debug(`token-${token as string}`);
  //   resolve(createRequest(requestUrl, method, requestData, httpRequest, token as string));
  // });
}

function createRequest(httpRequest:http.HttpRequest, url:string, method:string, requestData?:any, token?:string ): Promise<Response>{
  Logger.debug(`ttttt-${token}`);

  let httpOptions = {
    method: getRequestMethod(method),
    header: {
      'Content-Type': 'application/json',
      "User-Agent": "Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Mobile Safari/537.36"
    },
    //携带额外参数
    extraData: formatRequestData(method, requestData),
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
      response.data = res.data ?? res.result ?? null;
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
      return http.RequestMethod.GET; break;
    case 'post':
      return http.RequestMethod.POST; break;
    case 'put':
      return http.RequestMethod.PUT; break;
    case 'delete':
      return http.RequestMethod.DELETE; break;
  // 针对其他 HTTP 方法需要添加更多的情况
    default:
      return http.RequestMethod.GET; break;
  }
}

function formatRequestData(method:string, requestData?:any):string{
  switch (method.toLowerCase()) {
    case 'get':
      return objToUrlParam(requestData); break;
    default:
      return JSON.stringify(requestData); break;
  }
}

export function objToUrlParam(obj, ignoreFields = []) {
  if(!obj){
    return null
  }

  let newObj = Object.keys(obj)
  // 判断是否是空对象
  if(newObj.length == 0){
    return null
  }
  return Object.keys(obj)
    .filter(
      (key) =>
      ignoreFields.indexOf(key) === -1 &&
      obj[key] !== null &&
      obj[key] !== undefined &&
      obj[key] !== ""
    )
    .map((key) => key + "=" + obj[key])
    .join("&");
}