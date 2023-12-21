import { BreakpointConstants } from '../common/constants/BreakpointConstants';
import { CommonConstants } from '../common/constants/CommonConstants';
import { StyleConstants } from '../common/constants/StyleConstants';
import { BreakpointSystem } from '../common/utils/BreakpointSystem';
import CourseComponent from '../view/CourseComponent';
import FindComponent from '../view/FindComponent';
import JobComponent from '../view/JobComponent';
import MineComponent from '../view/MineComponent';
import { buttonInfo, ButtonInfoModel } from '../viewmodel/MainPageData';
@Entry
@Component
struct Main {
  @State message: string = 'Hello World'

  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  @StorageLink('IndexPage') currentPageIndex: number = 0;
  private breakpointSystem = new BreakpointSystem();

  aboutToAppear() {
    this.breakpointSystem.register();
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister();
  }

  @Builder BottomNavigation(button: ButtonInfoModel) {
    Column({ space: CommonConstants.BUTTON_SPACE }) {
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
  }

  build() {
    Column() {
      Tabs({
        barPosition: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarPosition.Start : BarPosition.End,
        index: this.currentPageIndex
      }) {
        TabContent() {
          FindComponent()
        }
        .tabBar(this.BottomNavigation(buttonInfo[CommonConstants.FIND_INDEX]))

        TabContent() {
          CourseComponent()
        }
        .tabBar(this.BottomNavigation(buttonInfo[CommonConstants.COURSE_INDEX]))

        TabContent() {
          JobComponent()
        }
        .tabBar(this.BottomNavigation(buttonInfo[CommonConstants.JOB_INDEX]))

        TabContent() {
          MineComponent()
        }
        .tabBar(this.BottomNavigation(buttonInfo[CommonConstants.MINE_INDEX]))
      }
      .barWidth(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      $r('app.float.bar_width') : StyleConstants.FULL_WIDTH)
      .barHeight(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      StyleConstants.SIXTY_HEIGHT : $r('app.float.vp_fifty_six'))
      .vertical(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG)
      .scrollable(false)
      .onChange((index: number) => {
        this.currentPageIndex = index;
      })
    }
    .backgroundColor($r('app.color.page_background'))
  }
}