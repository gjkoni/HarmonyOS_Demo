import { CommonConstants } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';
import { request } from '../common/utils/Request';
import { UserModel } from '../model/UserModel';
export class LoginViewModel {
  account:string;
  password:string;
}


function UserLogin(loginForm:LoginViewModel): Promise<boolean>{
  return new Promise(async (resolve: Function, reject: Function) => {
    UserModel.Login(loginForm.account, loginForm.password).then((data:any)=>{
      // UserModel.GetUserInfo().then((data:any)=>{
      //   resolve(data)
      // }).catch((err:Error) => {
      //   reject(err)
      // })
      resolve(data)
    }).catch((err:Error) => {
      Logger.error('viewmodel login failed', err.message);
      reject(err)
    })
  });
}

export {
  UserLogin
}