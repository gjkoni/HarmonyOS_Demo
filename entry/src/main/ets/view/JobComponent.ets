import { CommonConstants } from '../common/constants/CommonConstants';
import web_webview from '@ohos.web.webview'
import Logger from '../common/utils/Logger';
import { GlobalContext } from '../common/utils/GlobalContext';
import { JsParamsViewModel } from '../viewmodel/H5ViewModel'
import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';

@Component
export default struct JobComponent{
  @Consume @Watch('onUserChange') userid:string;
  controller:web_webview.WebviewController = new web_webview.WebviewController()

  onUserChange(propName: string): void {
    try {
      this.controller.runJavaScript(
        `checkUser()`,
        (error, result) => {
          if (error) {
            console.info(`run JavaScript error: ` + JSON.stringify(error))
            return;
          }
          if (result) {
            console.info(`The test() return value is: ${result}`)
          }
        });
    } catch (error) {
      console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
    }
  }

  jsProxy = {
    getAppUAT: (params:any) =>{
      Logger.debug(`JsProxy success ${JSON.stringify(params)}`)

      var req = {
        token: GlobalContext.getContext().getToken(),
        refresh_token: GlobalContext.getContext().getRefreshToken(),
        user_id: this.userid
      };

      let s = JSON.stringify(req)
      // Logger.debug(`传递长度-${s.length}`)
      return JSON.stringify(req);
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
            // try {
            //   const jsonString = { "city": '上海', "id": 1 }
            //   this.controller.runJavaScript(
            //     `setParams(${jsonString})`,
            //     (error, result) => {
            //       if (error) {
            //         console.info(`run JavaScript error: ` + JSON.stringify(error))
            //         return;
            //       }
            //       if (result) {
            //         console.info(`The test() return value is: ${result}`)
            //       }
            //     });
            //   console.info('url: ', e.url);
            // } catch (error) {
            //   console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
            // }
          })
          .onConsole((event) => {
            console.log('getMessage:' + event.message.getMessage())
            console.log('getSourceId:' + event.message.getSourceId())
            console.log('getLineNumber:' + event.message.getLineNumber())
            console.log('getMessageLevel:' + event.message.getMessageLevel())
            return false
          })
      }
  }

}