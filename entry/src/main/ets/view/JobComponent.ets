import { CommonConstants, H5host } from '../common/constants/CommonConstants';
import web_webview from '@ohos.web.webview'
import Logger from '../common/utils/Logger';
import { GlobalContext } from '../common/utils/GlobalContext';
import { JsParamsViewModel } from '../viewmodel/H5ViewModel'
import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';
import PreferencesUtils from '../common/utils/PreferencesUtils';
import router from '@ohos.router';

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
    getAppUAT: async (params:any) =>{
      // Logger.debug(`JsProxy success ${JSON.stringify(params)}`)

      // var req = {
      //   token: GlobalContext.getContext().getToken(),
      //   refresh_token: GlobalContext.getContext().getRefreshToken(),
      //   user_id: this.userid
      // };
      var req = {
        token: await PreferencesUtils.get('token', ''),
        refresh_token: await PreferencesUtils.get('refresh_token', ''),
        user_id: this.userid
      };

      Logger.debug(`JsProxy success ${JSON.stringify(params)}`)
      Logger.debug(`JsProxy success ${JSON.stringify(req)}`)
      let s = JSON.stringify(req)
      Logger.debug(`传递长度-${s.length}`)
      let webParams = JSON.parse(params)
      this.controller.runJavaScript(
        `${webParams.func}('${s}')`
      )
      // return JSON.stringify(req);
    },
    loginConfirm: (params:any) =>{
      Logger.debug(`JsProxy success loginConfirm ${JSON.stringify(params)}`)
      router.pushUrl({url:CommonConstants.pages.login.url})
    },
    closeView:(params:any) =>{
      router.back()
    },
    openWebview:(params:any) => {

    }
  }

  build(){
      Column() {
        Web({ src: CommonConstants.h5.job.index, controller: this.controller })
          .javaScriptAccess(true)
          .javaScriptProxy({
            object: this.jsProxy,
            name: "harmonyos",
            methodList: ["getAppUAT", "loginConfirm"],
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