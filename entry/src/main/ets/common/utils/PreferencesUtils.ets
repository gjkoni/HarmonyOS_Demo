import dataPreferences from '@ohos.data.preferences'
import { GlobalContext } from './GlobalContext';
import Logger from './Logger';

const TAG = "PreferencesUtils"
// 默认文件名，可以在构造函数进行修改
const PREFERENCES_NAME = 'qianxunPreferences'
const KEY_PREFERENCES = "preferences"
type ValueType = number | string | boolean | Array<number> | Array<string> | Array<boolean>;

export class PreferencesUtils{
  // preferences的文件名
  private preferencesName: string = PREFERENCES_NAME
  // 用于获取preferences实例的key值，保存到单例中
  private keyPreferences: string = KEY_PREFERENCES

  constructor(name: string = PREFERENCES_NAME, keyP: string = KEY_PREFERENCES) {
    this.preferencesName = name
    this.keyPreferences = keyP
  }

  createPreferences(context: Context): Promise<dataPreferences.Preferences> {
    let preferences = dataPreferences.getPreferences(context, this.preferencesName)
    GlobalContext.getContext().setObject(this.keyPreferences, preferences)
    return preferences
  }


  getPreferences(): Promise<dataPreferences.Preferences> {
    return GlobalContext.getContext().getObject(KEY_PREFERENCES) as Promise<dataPreferences.Preferences>
  }

  async get(key: string, def?: ValueType): Promise<ValueType> {
    return (await this.getPreferences()).get(key, def)
  }

  async getAll(): Promise<Object> {
    let  preferences = await this.getPreferences()
    return preferences.getAll()
  }

  async put(key: string, value: ValueType): Promise<void> {
    let promise = await this.getPreferences().then(async (p) => {
      await p.put(key, value)
      p.flush();
    }).catch((err)=>{
      Logger.debug(TAG, err)
    })
    return promise
  }



  async delete(key: string): Promise<void> {
    return (await this.getPreferences()).delete(key)
  }

  async clear(): Promise<void> {
    return (await this.getPreferences()).clear()
  }

}

export default new PreferencesUtils()
