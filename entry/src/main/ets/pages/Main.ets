import App from '@system.app';
import { BreakpointConstants } from '../common/constants/BreakpointConstants';
import { CommonConstants } from '../common/constants/CommonConstants';
import { StyleConstants } from '../common/constants/StyleConstants';
import { BreakpointSystem } from '../common/utils/BreakpointSystem';
import CourseComponent from '../view/CourseComponent';
import FindComponent from '../view/FindComponent';
import JobComponent from '../view/JobComponent';
import MineComponent from '../view/MineComponent';
import { buttonInfo, ButtonInfoModel } from '../viewmodel/MainPageData';

PersistentStorage.PersistProp(CommonConstants.storageKeys.userid, '');

@Entry
@Component
struct Main {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'
  @StorageLink('IndexPage') currentPageIndex: number = 0
  @Provide userid:string = AppStorage.Get(CommonConstants.storageKeys.userid)
  private breakpointSystem = new BreakpointSystem()
  controller:TabsController = new TabsController()

  aboutToAppear() {
    this.breakpointSystem.register()
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister()
  }

  onPageShow(){
    if(AppStorage.Has(CommonConstants.storageKeys.userid)){
      this.userid = AppStorage.Get(CommonConstants.storageKeys.userid)
    }
  }

  @Builder BottomNavigation(button: ButtonInfoModel) {
    Column({ space: StyleConstants.BUTTON_SPACE }) {
      Image(this.currentPageIndex === button.index ? button.selectImg : button.img)
        .objectFit(ImageFit.Contain)
        .width($r('app.float.main_image_size'))
        .height($r('app.float.main_image_size'))
      Text(button.title)
        .fontColor(this.currentPageIndex === button.index ? $r('app.color.focus_color') : Color.Black)
        .opacity(this.currentPageIndex === button.index ? StyleConstants.FULL_OPACITY : StyleConstants.SIXTY_OPACITY)
        .fontWeight(StyleConstants.FONT_WEIGHT_FIVE)
        .textAlign(TextAlign.Center)
        .fontSize($r('app.float.micro_font_size'))
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .onClick(()=>{
      this.currentPageIndex = button.index
      this.controller.changeIndex(this.currentPageIndex)
    })
  }

  build() {
    Column() {
      Tabs({
        barPosition: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarPosition.Start : BarPosition.End, controller:this.controller}) {
        TabContent() {
          FindComponent()
        }.backgroundColor($r('app.color.start_window_background')).align(Alignment.TopStart)
        .tabBar(this.BottomNavigation(buttonInfo[CommonConstants.FIND_INDEX]))

        TabContent() {
          CourseComponent()
        }.backgroundColor($r('app.color.start_window_background')).align(Alignment.TopStart)
        .tabBar(this.BottomNavigation(buttonInfo[CommonConstants.COURSE_INDEX]))

        TabContent() {
          JobComponent()
        }.backgroundColor($r('app.color.start_window_background')).align(Alignment.TopStart)
        .tabBar(this.BottomNavigation(buttonInfo[CommonConstants.JOB_INDEX]))

        TabContent() {
          MineComponent()
        }.backgroundColor($r('app.color.start_window_background')).align(Alignment.TopStart)
        .tabBar(this.BottomNavigation(buttonInfo[CommonConstants.MINE_INDEX]))
      }
      .barWidth(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
        StyleConstants.BAR_WIDTH : StyleConstants.FULL_WIDTH)
      .barHeight(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      StyleConstants.SIXTY_HEIGHT : $r('app.float.vp_fifty_six'))
      .vertical(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG)
      .scrollable(false)
    }
    .backgroundColor($r('app.color.page_background'))
  }
}