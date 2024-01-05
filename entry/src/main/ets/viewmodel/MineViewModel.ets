import { UserModel } from '../model/UserModel';
import Logger from '../common/utils/Logger';
import { CommonConstants } from '../common/constants/CommonConstants';

export class MineViewModel {
  fullname:string
  account:string
  head:string
  smallhead:string
}

export function getUserInfo(): Promise<any>{
  return new Promise(async (resolve: Function, reject: Function) => {
    UserModel.getUserInfo().then((res:any)=>{
      Logger.info('viewmodel GetUserInfo ok', JSON.stringify(res));
      AppStorage.SetOrCreate(CommonConstants.storageKeys.userid, res.user_id)
      resolve(res)
    }).catch((err:Error) => {
      Logger.error('viewmodel GetUserInfo failed', err.message);
      reject(err)
    })
  });
}
