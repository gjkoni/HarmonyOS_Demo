import { HeaderBar } from '../components/HeaderBar';
import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';

@Extend(Text)
function smallGrayStyle(){
  .fontColor(Color.Gray)
  .fontSize($r('app.float.smaller_font_size'))
}

@Entry
@Component
struct  SmsLogin{

  @State account:string = ""
  @State code:string = ""

  private accountController = new TextInputController();

  aboutToAppear(){
    const params = router.getParams();
    this.account = params["account"]
  }

  build(){
    Column() {
      Column(){
        HeaderBar({ iconType:'close', onBack: () => {
          router.back()
          // router.replaceUrl({url: CommonConstants.pages.main.url});
        } })
        Column({space:'20vp'}){
          Text($r('app.string.login_register_label')).alignSelf(ItemAlign.Start).margin({left:15, right:15})
          Row(){
            TextInput({ text:this.account, placeholder:$r('app.string.login_input_account_placeholder')}).height(35).padding({right:this.account != '' ? 50 : 0}).onChange((v) => {this.account = v})
            if(this.account != ''){
              Button({ type: ButtonType.Circle, stateEffect: true }){
                Image($r('app.media.ic_close')).objectFit(ImageFit.Contain)
              }.backgroundColor(Color.Transparent).margin({left:-35}).width(20).height(20).onClick(() =>{
                this.account = ''
              })
            }
          }.width('100%')
          Row(){
            TextInput({placeholder:$r('app.string.login_input_verification_placeholder')}).width('75%').height(35)
            Button({ type: ButtonType.Capsule, stateEffect: true }) {
              Row() {
                Text($r('app.string.button_captcha')).fontSize(16).fontColor(0xffffff).textAlign(TextAlign.Center)
              }.alignItems(VerticalAlign.Center).height(33).margin({top:1})

            }.backgroundColor('#0067b8').width('35%').margin({left:'-10%'})
          }.width('100%')
          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Row() {
              Text($r('app.string.button_login_register')).fontSize(16).fontColor(0xffffff).width('100%').textAlign(TextAlign.Center)
            }.alignItems(VerticalAlign.Center).width('100%').height(40)
          }.backgroundColor('#0067b8')
          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Row() {
              Text($r('app.string.button_password_login')).fontSize(16).fontColor('#585858').width('100%').textAlign(TextAlign.Center)
            }.alignItems(VerticalAlign.Center).width('100%').height(40)

          }.backgroundColor('#cccccc').onClick(()=>{
            router.replaceUrl({
              url:CommonConstants.pages.login.url,
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
      Text($r('app.string.login_description'))
        .padding('20vp')
        .smallGrayStyle()
        .alignSelf(ItemAlign.Center)
    }
    .backgroundColor($r('app.color.page_background'))
    .height('100%')
  }
}