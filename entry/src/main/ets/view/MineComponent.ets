import router from '@ohos.router'
import { CommonConstants } from '../common/constants/CommonConstants'
@Component
export default struct MineComponent{
  @Consume userid:string;

  on

  build(){
    Column(){
      Row({ space: 10 }) {
        Text($r('app.string.tab_mine')).fontSize(14).fontWeight(FontWeight.Bolder)
        Button(){
          Image($r('app.media.setting')).width(20).height(20)
        }
      }
      .width('100%')
      .padding({ top: 10, bottom: 10, left: 10, right: 10 })
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.SpaceBetween)

      Stack(){
        if(this.userid != ''){
          Row(){
            Image($r('app.media.icon')).width(80).height(80).borderRadius(40).objectFit(ImageFit.Cover).border({width:1, color:'#fcfcfc'})
          }.width('100%').justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).padding({left:10, right:10})
        }else{
          Row({space:20}){
            Image($r('app.media.icon')).width(80).height(80).borderRadius(40).objectFit(ImageFit.Cover).border({width:1, color:'#fcfcfc'})
            Column(){
              Text($r('app.string.button_click_login_register')).fontSize(14)
              Text($r('app.string.button_login_service')).fontSize(12)
            }.alignItems(HorizontalAlign.Start)
          }.width('100%').justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).padding({left:10, right:10})
        }
      }.width('100%')
      Text("MINE").width(100).height(30).backgroundColor(Color.Black).fontColor(Color.White).textAlign(TextAlign.Center).onClick(()=>{
        router.pushUrl({url: CommonConstants.pages.login.url})
      })
      if(this.userid != '') {
        Text('退出').width(100).height(30).backgroundColor(Color.Red).fontColor(Color.White).textAlign(TextAlign.Center).onClick(() => {
          AppStorage.SetOrCreate(CommonConstants.storageKeys.userid, '');
          this.userid = ''
        })
      }
    }

  }

}