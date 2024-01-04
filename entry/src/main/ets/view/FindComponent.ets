import { CommonConstants } from '../common/constants/CommonConstants';
import web_webview from '@ohos.web.webview'
@Component
export default struct JobComponent{
  @Consume userid:string;
  controller:web_webview.WebviewController = new web_webview.WebviewController()

  onPageShow(){
  }

  build(){
      Column() {
        // Web({ src: CommonConstants.h5.find.index, controller: this.controller })
      }
  }

}