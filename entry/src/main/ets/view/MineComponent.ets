import router from '@ohos.router'
import { CommonConstants } from '../common/constants/CommonConstants'
@Component
export default struct MineComponent{
  @Consume userid:string;

  build(){
    Column(){
      Text(this.userid)
      if(this.userid != ''){
        Image($r('app.media.mine_active')).width(30);
      }
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