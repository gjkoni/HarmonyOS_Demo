import { CommonConstants } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';
import PreferencesUtils from '../common/utils/PreferencesUtils';
import { request } from '../common/utils/Request';
import Response from '../common/utils/Response';
export class UserModel{
  static Login(account:string, password:string): Promise<any>{
    Logger.info('model Login start','');
    let url = CommonConstants.apis.login.url
    return request(url, CommonConstants.apis.login.method, {account, password}).then((data: Response) => {
      if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
        Logger.info('request ok', JSON.stringify(data));
        let p1 = PreferencesUtils.put("token", data.data.token);
        let p2 = PreferencesUtils.put("refresh_token", data.data.refresh_token);
        return Promise.all([p1, p2]).then(()=>{
          return data.data
        })
      } else {
        Logger.info('request ok', JSON.stringify(data));
        return $r('app.string.page_none_msg');
      }
    }).catch((err: Error) => {
      return $r('app.string.http_error_message');
    });


    // return new Promise(async (resolve: Function, reject: Function) => {
    //
    // });
  }

  static GetUserInfo(): Promise<any>{
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = CommonConstants.apis.info.url
      request(url, CommonConstants.apis.info.method).then((data: Response) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          resolve(data.data);
        } else {
          Logger.error('GetUserInfo failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('GetUserInfo failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}