import Logger from '../common/utils/Logger';
import { getLastStudy, LastStudyViewModel } from '../viewmodel/CourseViewModel';
@Component
export default struct CourseComponent{
  @Consume @Watch('onUserChange') userid:string;
  @State lastStudy:LastStudyViewModel = new LastStudyViewModel()

  scroller: Scroller = new Scroller()

  onUserChange(propName: string): void {
    getLastStudy().then((data) => {
      Logger.info(`getLastStudy-OK-debug-${JSON.stringify(data)}`)
      this.lastStudy = data;
    }).catch((err:string)=>{
      Logger.error(`getLastStudy-error-${err}`)
    })
  }

  build(){
    Column(){
      Row({ space:10 }){
        Text($r('app.string.tab_find')).fontSize(14).fontWeight(FontWeight.Bolder)
        Text($r('app.string.course_page_title')).fontSize(12).fontWeight(FontWeight.Bold)
      }.width('100%').padding({top:10, bottom:10, left:10, right:10}).alignItems(VerticalAlign.Bottom).justifyContent(FlexAlign.Start)
      Scroll(this.scroller) {
        Column() {
          if (this.userid != '') {
            Column() {
              Stack() {
                Image(this.lastStudy.lesson_cover).width('100%').objectFit(ImageFit.Contain).backgroundColor(Color.White)
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
            .border({ width: 1, color: 'rgba(3, 3, 3, 0.5)' })
            .borderRadius(4)
            .shadow({ radius: 5, color: 'rgba(0,0,0,0.3)', offsetX: 0, offsetY: 0 })
          }
        }.width('100%').padding({left:10, right:10})
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
        Text('xasdasdas').width('100%').height(100).backgroundColor('00ff00')
      }
    }.width('100%').height('100%')
  }
}