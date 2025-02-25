import { BlocksPage } from '@tbs/blocks'
import { StyleConst } from '@tbs/common'
import { FurniturePage } from '@tbs/furniture'
import { HomePage } from '@tbs/home'
import { MinePage } from '@tbs/mine'
import { SlabsPage } from '@tbs/slabs'
import { buttonInfo, ButtonInfoModel } from '../viewModel/pageData'

@Entry
@Component
struct Index {
  controller: TabsController = new TabsController()
  @State currentIndex: number = 0

  aboutToAppear(): void {
    getContext().eventHub.on('tabSwitch', (index: number) => {
      this.controller.changeIndex(index)
    })
  }

  aboutToDisappear(): void {
    getContext().eventHub.off('tabSwitch')
  }

  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.End, alignItems: ItemAlign.Center }) {
      Tabs({ barPosition: BarPosition.End, index: 0, controller: this.controller }) {
        ForEach(buttonInfo, (item: ButtonInfoModel, index?: number) => {
          TabContent() {
            if (index == 0) {
              HomePage()
            } else if (index == 1) {
              SlabsPage()
            } else if (index == 2) {
              BlocksPage()
            } else if (index == 3) {
              FurniturePage()
            } else if (index == 4) {
              MinePage()
            }
          }.tabBar(this.BottomNavigation(item))
        })
      }
      .width(StyleConst.FULL_WIDTH)
      .height(StyleConst.FULL_HEIGHT)
      .vertical(false)
      .scrollable(false)
      .animationDuration(0)
      .divider({ strokeWidth: 1, color: $r('app.color.color_f0f2f4') })
      .barHeight($r('app.float.size_55'))
      .onChange((index) => {
        this.currentIndex = index
      })
    }
  }

  @Builder
  BottomNavigation(item: ButtonInfoModel) {
    Column({ space: 6 }) {
      Image(this.currentIndex === item.index ? item.selectImg : item.img)
        .objectFit(ImageFit.Contain)
        .width($r('app.float.size_24'))
        .height($r('app.float.size_24'))
      Text(item.title)
        .fontColor(this.currentIndex === item.index ? $r('app.color.color_0165b8') : Color.Black)
        .opacity(this.currentIndex === item.index ? 1 : 0.6)
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
        .fontSize($r('app.float.size_text_10'))
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}
