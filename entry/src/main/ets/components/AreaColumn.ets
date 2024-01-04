import deviceInfo from '@ohos.deviceInfo';
import { GlobalContext } from '../common/utils/GlobalContext';
import { SystemArea } from '../viewmodel/AppViewModel'

@Styles
function globalArea () {
  .padding({top: deviceInfo.deviceType === 'tablet' ? px2vp((GlobalContext.getContext().getSystemArea() as SystemArea).statusBarHeight) : 0})
}

@Component
export struct  AreaColumn {
  @BuilderParam builder: ()=>void

  build(){
    Column(){
      this.builder()
    }
    .globalArea()
  }
}