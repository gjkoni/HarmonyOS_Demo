import { CommonConstants } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';
import PreferencesUtils from '../common/utils/PreferencesUtils';
import { request } from '../common/utils/Request';
import Response from '../common/utils/Response';
export class UserModel{
  static login(account:string, password:string): Promise<any>{
    Logger.info('model Login start','');
    let api = CommonConstants.apis.user.login;
    return new Promise(async (resolve: Function, reject: Function) => {
      request(api.url, api.method, {account, password}).then((data: Response) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info('request ok', JSON.stringify(data));
          let p1 = PreferencesUtils.put("token", data.data.token);
          let p2 = PreferencesUtils.put("refresh_token", data.data.refresh_token);
          resolve(Promise.all([p1, p2]).then(()=>{
            return data.data
          }))
        } else {
          Logger.info('request ok', JSON.stringify(data));
          reject(data.message);
        }
      }).catch((err: Error) => {
        reject(err);
      });
    });
  }

  static getUserInfo(): Promise<any>{
    return new Promise(async (resolve: Function, reject: Function) => {
      let api = CommonConstants.apis.user.info
      request(api.url, api.method).then((data: Response) => {
        resolve(data.data);
      }).catch((err: Error) => {
        Logger.error('GetUserInfo failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}