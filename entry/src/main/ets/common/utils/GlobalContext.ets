export class GlobalContext {
  private constructor() { }
  private static instance: GlobalContext;
  private _objects = new Map<string, Object>();

  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  getObject(value: string): Object | undefined {
    return this._objects.get(value);
  }

  setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }

  setSystemArea(systemArea:object){
    this.setObject("systemArea",  systemArea)
  }

  getSystemArea(): object{
    return this.getObject("systemArea");
  }

  setToken(token:string){
    this.setObject("token",  token)
  }

  getToken(): string{
    return this.getObject("token") as string;
  }

  setRefreshToken(token:string){
    this.setObject("refresh_token",  token)
  }

  getRefreshToken(): string{
    return this.getObject("refresh_token") as string;
  }
}
