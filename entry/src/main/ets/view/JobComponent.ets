import { CommonConstants } from '../common/constants/CommonConstants';
import web_webview from '@ohos.web.webview'
import Logger from '../common/utils/Logger';
@Component
export default struct JobComponent{
  @Consume userid:string;
  controller:web_webview.WebviewController = new web_webview.WebviewController()

  jsProxy = {
    getAppUAT: (params:any) =>{
      Logger.debug(`JsProxy success ${JSON.stringify(params)}`)
      var result = {
        'token': '',
        'refresh_token': '',
        'user_id': this.userid
      };
      return result;
    }
  }

  build(){
      Column() {
        Web({ src: CommonConstants.h5.job.index, controller: this.controller })
          .javaScriptAccess(true)
          .javaScriptProxy({
            object: this.jsProxy,
            name: "harmonyos",
            methodList: ["getAppUAT"],
            controller: this.controller,
          })
          .onPageEnd(e => {
            try {
              const jsonString = { "city": '上海', "id": 1 }
              this.controller.runJavaScript(
                `setParams(${jsonString})`,
                (error, result) => {
                  if (error) {
                    console.info(`run JavaScript error: ` + JSON.stringify(error))
                    return;
                  }
                  if (result) {
                    console.info(`The test() return value is: ${result}`)
                  }
                });
              console.info('url: ', e.url);
            } catch (error) {
              console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
            }
          })
      }
  }

}