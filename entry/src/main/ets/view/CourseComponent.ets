import Logger from '../common/utils/Logger';
import { getFreeProduct, getLastStudy, getSuggestProduct, LastStudyViewModel, ProductViewModel } from '../viewmodel/CourseViewModel';

@Component
export default struct CourseComponent{
  @Consume @Watch('onUserChange') userid:string;
  @State lastStudy:LastStudyViewModel = new LastStudyViewModel()
  @State freeProductList:ProductViewModel[] = []
  @State suggestProductList:ProductViewModel[] = []

  scroller: Scroller = new Scroller()

  onUserChange(propName: string): void {
    getLastStudy().then((data) => {
      Logger.info(`getLastStudy-OK-debug-${JSON.stringify(data)}`)
      this.lastStudy = data;
    }).catch((err:string)=>{
      Logger.error(`getLastStudy-error-${err}`)
    })
  }

  aboutToAppear(){
    Logger.debug('course aboutToAppear')
    this.loadFreeProducts()
    Logger.debug('free aboutToAppear')
    this.loadSuggestProducts()
    Logger.debug('suggest aboutToAppear')
  }

  loadFreeProducts() {
    getFreeProduct().then((data:ProductViewModel[]) =>{
      Logger.debug(`freeproductlist ${JSON.stringify(data)}`)
      this.freeProductList = data;
    })
  }

  loadSuggestProducts() {
    getSuggestProduct().then((data:ProductViewModel[]) =>{
      Logger.debug(`suggestproductlist ${JSON.stringify(data)}`)
      this.suggestProductList = data;
    })
  }

  build(){
    Column(){
      Row({ space:10 }){
        Text($r('app.string.tab_find')).fontSize(14).fontWeight(FontWeight.Bolder)
        Text($r('app.string.course_page_title')).fontSize(12).fontWeight(FontWeight.Bold)
      }.width('100%').padding({top:10, bottom:10, left:10, right:10}).alignItems(VerticalAlign.Bottom).justifyContent(FlexAlign.Start)
      Scroll(this.scroller) {
        Column({space:20}) {
          if (this.userid != '') {
            Column(){
              Row(){
                Row({ space:10 }){
                  Image($r('app.media.studynow')) .width(20).height(20)
                  Text("正在学习").margin({bottom:-3})
                }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Bottom)
                Row({space:3}) {
                  Text("更多").fontSize(13)
                  Image($r('app.media.ic_arrow_right_black')) .width(9).height(9)
                }.justifyContent(FlexAlign.End).alignItems(VerticalAlign.Center)
              }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Bottom).padding({top:10, bottom:10})
              Column() {
                Stack() {
                  Image(this.lastStudy.lesson_cover).width('100%').objectFit(ImageFit.Contain).backgroundColor(Color.White).borderRadius({topLeft:4, topRight:4})
                  // if(this.lastStudy.class_start && this.lastStudy.class_end){
                  Text(`${this.lastStudy.class_start}-${this.lastStudy.class_end}`)
                    .align(Alignment.TopEnd)
                    .padding(5)
                    .backgroundColor(Color.White)
                    .opacity(0.5)
                    .fontColor(Color.Black)
                  // }
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
            }
          }
          Column(){
            Row(){
              Row({ space:10 }){
                Image($r('app.media.recommend')) .width(20).height(20)
                Text("推荐课程")
              }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Bottom)
            }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Bottom).padding({top:10, bottom:10})
            WaterFlow() {
              ForEach(this.freeProductList, (item: ProductViewModel) => {
                FlowItem() {
                  Column() {
                    Stack(){
                      Image(item.product_cover).width('100%')
                    }
                    Text(item.product_title).width('100%')
                    Row(){
                      Text(item.product_teacher)
                      if(item.original_price > 0){
                        Text(`${item.product_period}`)
                      }
                    }
                    Row(){
                      if(item.original_price > 0){
                        Text(`${item.original_price}`)
                      }else{
                        Text(`${item.product_period}`)
                      }
                      Button({type: ButtonType.Capsule, stateEffect:true}){
                        Text(item.isfree == 1 ? '免费' : `￥ ${item.price}`).fontSize(12)
                      }.padding({left: 10, right:10, top:5, bottom:5})
                    }
                  }
                }
                .backgroundColor(Color.Gray)
              }, (item: ProductViewModel, index:number) => {return item.product_id})
            }
            .columnsTemplate("1fr 1fr")
            .itemConstraintSize({
              minWidth: 0,
              maxWidth: '100%',
              minHeight: 0,
              maxHeight: '100%'
            })
            .columnsGap(10)
            .rowsGap(5)
            .width('100%')
            .layoutDirection(FlexDirection.Column)
          }
        }.width('100%').padding({left:10, right:10})
      }
    }.width('100%').height('100%')
  }
}