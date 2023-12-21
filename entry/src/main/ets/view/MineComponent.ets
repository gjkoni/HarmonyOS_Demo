import router from '@ohos.router'
import { CommonConstants } from '../common/constants/CommonConstants'
@Component
export default struct MineComponent{

  build(){
    Column(){
      Text("MINE")
    }
    .onClick(()=>{
      router.pushUrl({url: CommonConstants.pages.login.url})
    })
  }

}