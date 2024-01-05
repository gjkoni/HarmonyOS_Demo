import { CommonConstants } from '../common/constants/CommonConstants'
import { MineViewModel, getUserInfo } from '../viewmodel/MineViewModel'
import lottie from '@ohos/lottie'
import display from '@ohos.display';
import router from '@ohos.router';

@Component
export default struct MineComponent{
  @Consume @Watch('onUserChange') userid:string;
  @State user:MineViewModel = new MineViewModel()

  private mainRenderingSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private mainCanvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.mainRenderingSettings)
  private path:string = "common/lottie/bg_girl.json"

  scroller:Scroller = new Scroller()

  onUserChange(propName: string): void {
    this.getUsetInfo()
  }

  getUsetInfo(){
    getUserInfo().then(res =>{
      this.user.fullname = res.fullname
      this.user.account = res.account
      this.user.head = res.pic
      this.user.smallhead = res.small_pic
    })
  }

  aboutToAppear(){
    this.getUsetInfo()
  }

  build(){
    Column(){
      Row({ space: 10 }) {
        Text($r('app.string.tab_mine')).fontSize(14).fontWeight(FontWeight.Bolder)
        Button(){
          Image($r('app.media.setting')).width(20).height(20)
        }
        .width(50)
        .align(Alignment.End)
        .backgroundColor('rgba(0,0,0,0)')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10, left: 10, right: 10 })
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.SpaceBetween)

      Scroll(this.scroller){
        Column(){
          Stack(){
            if(this.userid != ''){
              Row(){
                Image(this.user.smallhead).width(60).height(60).borderRadius(30).objectFit(ImageFit.Cover).border({width:1, color:'#fcfcfc'})
                Column({space:8}){
                  Text(this.user.fullname).fontSize(14)
                  Text(this.user.account).fontSize(12)
                }.alignItems(HorizontalAlign.Start)
              }.width('100%').justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).padding({left:10, right:10}).zIndex(999).position({x:0, y:0})
            }else{
              Row({space:10}){
                Image($r('app.media.icon')).width(60).height(60).borderRadius(30).objectFit(ImageFit.Cover).border({width:1, color:'#fcfcfc'})
                Column({space:8}){
                  Text($r('app.string.button_click_login_register')).fontSize(14)
                  Text($r('app.string.button_login_service')).fontSize(12)
                }.alignItems(HorizontalAlign.Start)
              }.width('100%').justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).padding({left:10, right:10}).zIndex(999).position({x:0, y:0})
            }
            Row(){
              Canvas(this.mainCanvasRenderingContext)
                .backgroundColor(Color.Transparent)
                .onReady(()=>{
                  let animationItem = lottie.loadAnimation({
                    container: this.mainCanvasRenderingContext,  // 渲染上下文
                    renderer: 'canvas',                          // 渲染方式
                    loop: true,                                  // 是否循环播放,默认true
                    autoplay: true,                              // 是否自动播放，默认true
                    path: this.path,                             // json路径
                    // initialSegment: [10,50]                      // 播放的动画片段
                  })
                })
            }.position({x:180}).width(display.getDefaultDisplaySync().width / display.getDefaultDisplaySync().densityPixels - 180).aspectRatio(4/3).padding({top:35})
            Stack(){
              Path()
                .commands(`M50 0 L${display.getDefaultDisplaySync().width - 50} 0 L${display.getDefaultDisplaySync().width} 150 L0 150 Z`)
                .fill('rgba(242,242,242,0.5)')
                .stroke('rgba(242,242,242,0.5)')
                .strokeWidth(1)
              Text('0.00')
            }.backgroundColor(Color.Transparent).width('100%').height(50)
          }.width('100%').alignContent(Alignment.Bottom)
          .onClick(()=>{
            router.pushUrl({url:CommonConstants.pages.user.login})
          })

          if(this.userid != '') {
            Text('退出').width('100%').height(30).backgroundColor(Color.Red).fontColor(Color.White).textAlign(TextAlign.Center).onClick(() => {
              AppStorage.SetOrCreate(CommonConstants.storageKeys.userid, '');
              this.userid = ''
            }).margin({top:50})
          }
        }
      }
    }

  }

}