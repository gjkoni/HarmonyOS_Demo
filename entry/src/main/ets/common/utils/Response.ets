export default class Response{
  /**
   * 响应码
   */
  code: number
  /**
   * 相应消息
   */
  message: string
  /**
   * 相应数据
   */
  data: any

  /**
   * 兼容部分界面调试api
    */
  result: any
}