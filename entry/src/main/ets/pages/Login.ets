import { HeaderBar } from '../components/HeaderBar';
import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { LoginViewModel, UserLogin, UserLogin2 } from '../viewmodel/LoginViewModel';
import Logger from '../common/utils/Logger';

@Extend(Text)
function smallGrayStyle(){
  .fontColor(Color.Gray)
  .fontSize($r('app.float.smaller_font_size'))
}

@Entry
@Component
struct  Login{
  @State account:string = "18917825059"
  @State password:string = "123456"

  aboutToAppear(){
    const params = router.getParams();
    if(params){
      this.account = params["account"]
    }
  }

  build(){
    Column(){
      Column() {
        HeaderBar({ iconType: 'close', onBack: () => {
          router.replaceUrl({ url: CommonConstants.pages.main.url });
        } })
        Column({ space: '20vp' }) {
          Text($r('app.string.login_title')).alignSelf(ItemAlign.Start).margin({ left: 15, right: 15 })
          Text($r('app.string.login_subtitle')).alignSelf(ItemAlign.Start).margin({ left: 15, right: 15 })
          Text($r('app.string.login_label')).alignSelf(ItemAlign.Start).margin({ left: 15, right: 15, top: 20 })
          Row(){
            TextInput({ text: this.account, placeholder:$r('app.string.login_input_account_placeholder')}).height(35).padding({right:this.account != '' ? 50 : 0}).onChange((v) => {this.account = v})
            if(this.account != ''){
              Button({ type: ButtonType.Circle, stateEffect: true }){
                Image($r('app.media.ic_close')).objectFit(ImageFit.Contain)
              }.backgroundColor(Color.Transparent).margin({left:-35}).width(20).height(20).onClick(() =>{
                this.account = ''
              })
            }
          }.width('100%')
          TextInput({ placeholder: $r('app.string.login_input_password_placeholder') }).type(InputType.Password).showPasswordIcon(true).onChange((v) => {this.password = v})
          Text($r('app.string.text_forgot_password')).alignSelf(ItemAlign.End).margin({ left: 15, right: 15 }).smallGrayStyle()
          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Row() {
              Text($r('app.string.button_login')).fontSize(16).fontColor(0xffffff).width('100%').textAlign(TextAlign.Center)
            }.alignItems(VerticalAlign.Center).width('100%').height(40)
          }.backgroundColor('#0067b8').onClick(() => {
            const model = new LoginViewModel();
            model.account = this.account;
            model.password = this.password;
            UserLogin2(model).then((data) => {
              Logger.info(`GetUserInfo-OK-debug-${JSON.stringify(data)}`)
              router.back()
            }).catch((err:Error)=>{
              Logger.error(`login-error-${err.message}`)
            })
          })
          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Row() {
              Text($r('app.string.button_sms_login'))
                .fontSize(16)
                .fontColor('#585858')
                .width('100%')
                .textAlign(TextAlign.Center)
            }.alignItems(VerticalAlign.Center).width('100%').height(40)

          }.backgroundColor('#cccccc').onClick(() => {
            router.replaceUrl({
              url: CommonConstants.pages.sms_login.url,
              params: {
                account: this.account
              }
            })
          })
        }
        .width('100%')
        .padding('20vp')
        .alignItems(HorizontalAlign.Center)
      }
      .flexGrow(2)
      Column({space:10}){
        Row({space:20}){
          Text('用户协议').smallGrayStyle()
          Text('隐私政策').smallGrayStyle()
        }
        Text($r('app.string.app_copyright')).smallGrayStyle()
        Text($r('app.string.app_email')).smallGrayStyle()
      }
      .width('100%')
      .padding('20vp')
    }
    .backgroundColor($r('app.color.page_background'))
    .height('100%')
  }
}