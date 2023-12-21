import Logger from '../common/utils/Logger';
import { UserModel } from '../model/UserModel';
export class LoginViewModel {
  account:string;
  password:string;
}


function UserLogin(loginForm:LoginViewModel): Promise<boolean>{
  return new Promise(async (resolve: Function, reject: Function) => {
    UserModel.Login(loginForm.account, loginForm.password).then((data:any)=>{
      Logger.info('viewmodel Login ok', JSON.stringify(data));
      UserModel.GetUserInfo().then((data:any)=>{
        Logger.info('viewmodel GetUserInfo ok', JSON.stringify(data));
        resolve(data)
      }).catch((err:Error) => {
        Logger.error('viewmodel GetUserInfo failed', err.message);
        reject(err)
      })
    }).catch((err:Error) => {
      Logger.error('viewmodel login failed', err.message);
      reject(err)
    })
  });
}

function UserLogin2(loginForm:LoginViewModel): Promise<boolean>{
  return UserModel.Login(loginForm.account, loginForm.password).then((data:any)=>{
    Logger.info('viewmodel Login ok', JSON.stringify(data));
    return UserModel.GetUserInfo().then((data:any)=>{
      Logger.info('viewmodel GetUserInfo ok', JSON.stringify(data));
      return data
    }).catch((err:Error) => {
      Logger.error('viewmodel GetUserInfo failed', err.message);
      return err
    })
  }).catch((err:Error) => {
    Logger.error('viewmodel login failed', err.message);
    return err
  })
}

export {
  UserLogin,
  UserLogin2
}