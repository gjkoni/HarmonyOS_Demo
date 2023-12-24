import { CommonConstants } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';
import { UserModel } from '../model/UserModel';
export class LoginViewModel {
  account:string;
  password:string;
}


function userLogin(loginForm:LoginViewModel): Promise<boolean>{
  return new Promise(async (resolve: Function, reject: Function) => {
    UserModel.login(loginForm.account, loginForm.password).then((data:any)=>{
      Logger.info('viewmodel Login ok', JSON.stringify(data));
      UserModel.getUserInfo().then((data:any)=>{
        Logger.info('viewmodel GetUserInfo ok', JSON.stringify(data));
        AppStorage.SetOrCreate(CommonConstants.storageKeys.userid, data.user_id)
        resolve(data)
      }).catch((err:Error) => {
        Logger.error('viewmodel GetUserInfo failed', err.message);
        reject(err)
      })
    }).catch((err:string) => {
      Logger.error('viewmodel login failed', err);
      reject(err)
    })
  });
}

export {
  userLogin
}