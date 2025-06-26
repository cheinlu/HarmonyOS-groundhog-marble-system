import { marblesObj, CommonDataSource, layers, StyleConst, GoodsInfo, CommonFormPageType,
  ScreenUtils } from "@tbs/common"

// SlabsDetail.ets
@Builder
export function SlabsDetailBuilder(name: string, param: Object) {
  SlabsDetail()
}

@Component
export struct SlabsDetail {
  pathStack: NavPathStack = new NavPathStack()
  @State marbleSlabs: marblesObj | undefined = undefined
  slabsDetailDataSource = new CommonDataSource<layers>()
  navContext: NavDestinationContext | null = null

  @Builder
  SlabsDetailTopBuild(){
    Column({ space: 20 }){
      Stack({ alignContent: Alignment.TopStart }) {
        Image($r('app.media.furniture_topimg'))
          .width(StyleConst.FULL_WIDTH)
          .height($r('app.float.size_150'))
        Image($r('app.media.common_back_white'))
          .width($r('app.float.size_20'))
          .margin({ left: $r('app.float.size_5'), top: ScreenUtils.getInstance().getStatusBarHeight() })
          .onClick(() => {
            this.navContext?.pathStack.pop()
          })
      }

      Text(this.marbleSlabs?.name)
        .width(StyleConst.FULL_WIDTH)
        .fontSize($r('app.float.size_text_25'))
        .padding({ left: $r('app.float.size_20') })

      Text(this.marbleSlabs?.sn)
        .width(StyleConst.FULL_WIDTH)
        .fontSize($r('app.float.size_text_15'))
        .padding({ left: $r('app.float.size_20') })
        .fontColor($r('app.color.color_666666'))

      Row() {
        Text(`${this.marbleSlabs?.layers?.length}匝`)
          .fontColor($r('app.color.color_e7e7e7'))
          .fontSize($r('app.float.size_text_20'))
          .width($r('app.float.size_80'))
          .height($r('app.float.size_50'))
          .textAlign(TextAlign.Center)
          .border({
            width: $r('app.float.size_1'),
            color: $r('app.color.color_fff'),
            style: BorderStyle.Solid,
            radius: $r('app.float.size_50')
          })
          .backgroundColor($r('app.color.color_5eafc2'))
        Text(`${this.marbleSlabs?.slices_total}片`)
          .fontColor($r('app.color.color_e7e7e7'))
          .fontSize($r('app.float.size_text_20'))
          .width($r('app.float.size_100'))
          .height($r('app.float.size_50'))
          .textAlign(TextAlign.Center)
          .border({
            width: $r('app.float.size_1'),
            color: $r('app.color.color_fff'),
            style: BorderStyle.Solid,
            radius: $r('app.float.size_50')
          })
          .backgroundColor($r('app.color.color_6e9ed5'))
        Text(`${this.marbleSlabs?.area}㎡`)
          .fontColor($r('app.color.color_e7e7e7'))
          .fontSize($r('app.float.size_text_20'))
          .width($r('app.float.size_130'))
          .height($r('app.float.size_50'))
          .textAlign(TextAlign.Center)
          .border({
            width: $r('app.float.size_1'),
            color: $r('app.color.color_fff'),
            style: BorderStyle.Solid,
            radius: $r('app.float.size_50')
          })
          .backgroundColor($r('app.color.color_bb5636'))
      }
      .width(StyleConst.FULL_WIDTH)
      .height($r('app.float.size_100'))
      .borderRadius({ bottomLeft: $r('app.float.size_10'), bottomRight: $r('app.float.size_10') })
      .backgroundColor($r('app.color.color_888888'))
      .justifyContent(FlexAlign.SpaceEvenly)
      .onClick(() => {
        this.pathStack.pushPathByName('SlabsSize', null)
      })
    }
  }

  build() {
    NavDestination() {
      Column() {
        this.SlabsDetailTopBuild()

        WaterFlow() {
          LazyForEach(this.slabsDetailDataSource, (model: layers) => {
            FlowItem() {
              GoodsInfo({
                slabsDetailModel: model,
                formPageType: CommonFormPageType.SLABS_DETAIL,
                clickCallBack: () => {
                  this.pathStack.pushPathByName('SlabsSize', model)
                }
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
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.navContext = context
      this.pathStack = context.pathStack;
      this.marbleSlabs = context.pathInfo.param as marblesObj
      this.slabsDetailDataSource.pushData(this.marbleSlabs.layers as layers)
    })
  }
}