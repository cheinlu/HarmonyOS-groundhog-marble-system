import {
  CommonDataSource,
  CommonFormPageType,
  GoodsInfo,
  layers,
  ScreenUtils,
  ShareMenuSheet,
  slices,
  StyleConst,
  toast
} from "@tbs/common"

@Builder
export function SlabsSizeBuilder() {
  SlabsSize()
}

@Component
export struct SlabsSize {
  layersObj: layers | undefined = undefined
  slabsSizeDataSource = new CommonDataSource<slices>()
  @State showShareBottomSheet: boolean = false
  navContext: NavDestinationContext | null = null

  @Builder
  SlabsSizeTopBuild() {
    Column({ space: 20 }) {
      Image($r('app.media.common_back_black'))
        .width($r('app.float.size_20'))
        .margin({ left: $r('app.float.size_5'), top: ScreenUtils.getInstance().getStatusBarHeight() })
        .onClick(() => {
          this.navContext?.pathStack.pop()
        })
      Row() {
        Text(this.layersObj?.name)
          .fontSize($r('app.float.size_text_22'))
        Image($r('app.media.share'))
          .width($r('app.float.size_30'))
          .objectFit(ImageFit.Contain)
          .aspectRatio(1)
          .onClick(() => {
            this.showShareBottomSheet = !this.showShareBottomSheet
          })
          .bindContentCover($$this.showShareBottomSheet, this.ShareMenusBuilder(), {
            modalTransition: ModalTransition.NONE
          })
      }
      .width(StyleConst.FULL_WIDTH)
      .padding({ left: $r('app.float.size_10'), right: $r('app.float.size_10') })
      .justifyContent(FlexAlign.SpaceBetween)

      Text('A级大板、现货直供、项目深化、效果制作、可咨询客服')
        .fontColor($r('app.color.color_666666'))
        .fontSize($r('app.float.size_text_18'))
        .width(StyleConst.FULL_WIDTH)
        .padding({ left: $r('app.float.size_10'), right: $r('app.float.size_10') })
      Blank().height($r('app.float.size_1')).color(Color.Black)
      Row() {
        Text('规格')
          .fontSize($r('app.float.size_text_18'))
          .fontColor($r('app.color.color_666666'))
        Text(`${this.layersObj?.width} x ${this.layersObj?.height} x ${this.layersObj?.length}mm`)
          .fontColor($r('app.color.color_666666'))
          .fontSize($r('app.float.size_text_18'))
      }
      .padding({ left: $r('app.float.size_10'), right: $r('app.float.size_10') })
      .width(StyleConst.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height($r('app.float.size_1')).color(Color.Black)
      Row() {
        Text('平方数')
          .fontSize($r('app.float.size_text_18'))
          .fontColor($r('app.color.color_666666'))
        Text(`${this.layersObj?.slices?.length}片 / ${this.layersObj?.area}㎡`)
          .fontColor($r('app.color.color_c84921'))
          .fontSize($r('app.float.size_text_18'))
      }
      .padding({ left: $r('app.float.size_10'), right: $r('app.float.size_10') })
      .width(StyleConst.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height($r('app.float.size_1')).color(Color.Black)
    }
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    NavDestination() {
      Column() {
        //顶部内容
        this.SlabsSizeTopBuild()

        WaterFlow() {
          LazyForEach(this.slabsSizeDataSource, (model: slices) => {
            FlowItem() {
              GoodsInfo({
                slabsSizeModel: model,
                formPageType: CommonFormPageType.SLABS_SIZE,
              })
            }
            .width(StyleConst.FULL_WIDTH)
          })
        }
        .padding({
          left: $r('app.float.size_12'),
          right: $r('app.float.size_12'),
        })
        .scrollBar(BarState.Off)
        .cachedCount(6)
        .columnsTemplate('1fr 1fr')
        .columnsGap($r('app.float.size_9'))
        .rowsGap($r('app.float.size_9'))
        .width(StyleConst.FULL_WIDTH)
        .height(StyleConst.FULL_HEIGHT)
        .margin({ top: $r('app.float.size_12') })
        .layoutWeight(1)
      }
      .width(StyleConst.FULL_WIDTH)
      .height(StyleConst.FULL_HEIGHT)
      .alignItems(HorizontalAlign.Start)
      .margin({ top: $r('app.float.size_20') })
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.navContext = context
      this.layersObj = context.pathInfo.param as layers
      this.slabsSizeDataSource.pushData(this.layersObj.slices as slices)
    })
  }

  @Builder
  ShareMenusBuilder() {
    Column() {
      Blank().layoutWeight(1).onClick(() => {
        this.showShareBottomSheet = false
      })
      Stack() {
        ShareMenuSheet({
          showShareBottomSheet: this.showShareBottomSheet,
          onClickShareToFriends: () => {
            toast('功能开发中，敬请期待！')
          }
        })
      }
      .height(ScreenUtils.getInstance().getSafeBottomHeight() + 251)
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .justifyContent(FlexAlign.End)
    .backgroundColor($r('app.color.color_80000000'))
  }
}


