import { BreakpointConstants } from '../common/constants/BreakpointConstants';
import Logger from '../common/utils/Logger';
import { MyWaterFlow } from '../components/MyWaterFlow';
import { getFreeProduct, getLastStudy, getSuggestProduct, LastStudyViewModel, LazyProducts, ProductViewModel } from '../viewmodel/CourseViewModel';

@Component
export default struct CourseComponent {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'
  @Consume @Watch('onUserChange') userid: string
  @State lastStudy: LastStudyViewModel = new LastStudyViewModel()
  //@State freeProductList: LazyProducts = new LazyProducts()
  @State freeProducts: ProductViewModel[] = []
  //@State suggestProductList: LazyProducts = new LazyProducts()
  @State suggestProducts: ProductViewModel[] = []

  scroller: Scroller = new Scroller()

  onUserChange(propName: string): void {
    this.getLastStudy()
  }

  aboutToAppear() {
    this.getLastStudy()
    Logger.debug('course aboutToAppear')
    this.loadFreeProducts()
    Logger.debug('free aboutToAppear')
    this.loadSuggestProducts()
    Logger.debug('suggest aboutToAppear')
  }

  getLastStudy(){
    if(this.userid != ''){
      getLastStudy().then((data) => {
        Logger.info(`getLastStudy-OK-debug-${JSON.stringify(data)}`)
        this.lastStudy = data;
      }).catch((err: string) => {
        Logger.error(`getLastStudy-error-${err}`)
      })
    }else{
      this.lastStudy = new LastStudyViewModel()
    }
  }


  loadFreeProducts() {
    getFreeProduct().then((data: ProductViewModel[]) => {
      Logger.debug(`freeproductlist ${JSON.stringify(data)}`)
      this.freeProducts = data
    })
  }

  loadSuggestProducts() {
    getSuggestProduct().then((data: ProductViewModel[]) => {
      Logger.debug(`suggestproductlist ${JSON.stringify(data)}`)
      this.suggestProducts = data;
    })
  }

  @Builder itemBox(item:ProductViewModel) {
        Column() {
          Stack(){
            Image(item.product_cover).width('100%').height('100%').borderRadius({topLeft:4, topRight:4})
          }.width('100%').aspectRatio(16/9)
          Text(item.product_title).width('100%').padding(5).textOverflow({overflow:TextOverflow.Ellipsis}).maxLines(2).fontSize(12)
          Row(){
            Text(item.product_teacher).fontSize(12).fontColor($r('app.color.main_color')).width('60%').textOverflow({overflow:TextOverflow.Ellipsis}).maxLines(1)
            if(item.original_price > 0 && item.original_price > item.price){
              Text(`${item.product_period}课时`).fontSize(12).width('40%').textAlign(TextAlign.End)
            }
          }.width('100%').padding(5).justifyContent(FlexAlign.SpaceBetween)
          Row(){
            if(item.original_price > 0 && item.original_price > item.price){
              Text(`${item.original_price}`).fontColor(Color.Gray).fontStyle(FontStyle.Italic).fontSize(12).decoration({type:TextDecorationType.LineThrough, color:Color.Gray}).padding({left:5, right:5})
            }else{
              Text(`${item.product_period}课时`).fontSize(12)
            }
            Button({type: ButtonType.Capsule, stateEffect:true}){
              Text(item.isfree == 1 ? '免费' : `￥ ${item.price}`).fontSize(12).fontColor(Color.White)
            }.padding({left: 10, right:10, top:5, bottom:5})
          }.width('100%').padding(5).justifyContent(FlexAlign.SpaceBetween)
        }
        .border({ width: 1, color: 'rgba(3, 3, 3, 0.5)' })
        .borderRadius(8)
        .shadow({ radius: 3, color: 'rgba(0,0,0,0.5)', offsetX: 0, offsetY: 0 })
  }

  build() {
    Column() {
      Row({ space: 10 }) {
        Text($r('app.string.tab_find')).fontSize(14).fontWeight(FontWeight.Bolder)
        Text($r('app.string.course_page_title')).fontSize(12).fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ top: 10, bottom: 10, left: 10, right: 10 })
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.Start)
      Scroll(this.scroller) {
        Column({ space: 20 }) {
          if (this.userid != '') {
            Column() {
              Row() {
                Row({ space: 10 }) {
                  Image($r('app.media.studynow')).width(20).height(20)
                  Text("正在学习").margin({ bottom: -3 })
                }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Bottom)

                Row({ space: 3 }) {
                  Text("更多").fontSize(13)
                  Image($r('app.media.ic_arrow_right_black')).width(9).height(9)
                }.justifyContent(FlexAlign.End).alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Bottom)
              .padding({ top:10, bottom:10 })
              Column() {
                Stack({ alignContent: Alignment.TopEnd }) {
                  Image(this.lastStudy.lesson_cover)
                    .width('100%')
                    .objectFit(ImageFit.Contain)
                    .backgroundColor(Color.White)
                    .borderRadius({ topLeft: 4, topRight: 4 })
                  if (this.lastStudy.class_start && this.lastStudy.class_end) {
                    Text(`${this.lastStudy.class_start}-${this.lastStudy.class_end}`)
                      .align(Alignment.TopEnd)
                      .padding(5)
                      .backgroundColor(Color.White)
                      .opacity(0.5)
                      .fontColor(Color.Black)
                  }
                }.width('100%')

                Row() {
                  Text(this.lastStudy.lesson_title).fontSize(12)
                  Button({ type: ButtonType.Capsule, stateEffect: true }) {
                    Text('继续学习').fontColor(Color.White).fontSize(12)
                  }.backgroundColor($r('app.color.main_color')).padding({ left: 10, right: 10, top: 5, bottom: 5 })
                }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding({ top: 5, bottom: 5, left: 5, right: 5 })
              }
              .width('100%')
              .border({ width: 1, color: 'rgba(3, 3, 3, 0.5)' })
              .borderRadius(8)
              .shadow({ radius: 3, color: 'rgba(0,0,0,0.5)', offsetX: 0, offsetY: 0 })
              .alignItems(HorizontalAlign.Center)
            }.padding({left:10, right:10})
          }
          Column(){
             Row(){
                  Row({ space:10 }){
                    Image($r('app.media.recommend')) .width(20).height(20)
                    Text("推荐课程")
                  }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Bottom)
                }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Bottom).padding(10)
            MyWaterFlow({ data:$suggestProducts, columns:this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 4 : 2, columnGap:10, rowGap:10, paddingLR:true, itemBuilder: (item)=>{
              this.itemBox(item)
            }})
          }
          Column() {
            Row() {
              Row({ space: 10 }) {
                Image($r('app.media.free')).width(20).height(20)
                Text("免费课程")
              }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Bottom)
            }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Bottom).padding(10)
            MyWaterFlow({ data:$freeProducts, columns:this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 4 : 2, columnGap:10, rowGap:10, paddingLR:true, itemBuilder: (item)=>{
              this.itemBox(item)
            }})
          }
        }.width('100%').padding({ bottom: $r('app.float.vp_fifty_six') })
      }
    }
  }
}