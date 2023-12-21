import { CommonConstants } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';
import PreferencesUtils from '../common/utils/PreferencesUtils';
import { request } from '../common/utils/Request';
import Response from '../common/utils/Response';
export class UserModel{
  static Login(account:string, password:string): Promise<any>{
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = CommonConstants.apis.login.url
      request(url, CommonConstants.apis.login.method, {account, password}).then((data: Response) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          PreferencesUtils.put("token", data.data.token)
          PreferencesUtils.put("refresh_token", data.data.refresh_token)
          resolve(data.data);
        } else {
          Logger.error('model login failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('model login failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  static GetUserInfo(): Promise<any>{
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = CommonConstants.apis.info
      request(url, "GET").then((data: Response) => {
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