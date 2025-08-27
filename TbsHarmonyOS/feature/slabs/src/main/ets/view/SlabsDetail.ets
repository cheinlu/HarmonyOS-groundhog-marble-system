import {
  marblesObj,
  CommonDataSource,
  layers,
  StyleConst,
  GoodsInfo,
  CommonFormPageType,
  ScreenUtils,
  TopComponentView
} from "@tbs/common"
import { router } from "@kit.ArkUI"
import './SlabsSize'

@Extend(Text)
function textStyles(backgroundColor: ResourceColor) {
  .fontColor($r('app.color.color_e7e7e7'))
  .fontSize($r('app.float.size_text_20'))
  .padding($r('app.float.size_15'))
  .textAlign(TextAlign.Center)
  .border({
    width: $r('app.float.size_1'),
    color: $r('app.color.color_fff'),
    style: BorderStyle.Solid,
    radius: $r('app.float.size_50')
  })
  .backgroundColor(backgroundColor)
}

@Entry({ routeName: 'SlabsDetail' })
@Component
export struct SlabsDetail {
  @State marbleSlabs: marblesObj | undefined = undefined
  slabsDetailDataSource = new CommonDataSource<layers>()

  onPageShow(): void {
    const SlabsDetailParams = router.getParams()
    if (SlabsDetailParams && typeof SlabsDetailParams === 'object') {
      this.marbleSlabs = SlabsDetailParams as marblesObj
      // 校验layers是否为数组，兜底空数组
      const validLayers = Array.isArray(this.marbleSlabs.layers) ? this.marbleSlabs.layers : [];
      this.slabsDetailDataSource.pushData(validLayers);
    }
  }

  @Builder
  SlabsDetailTopBuild() {
    Column({ space: 20 }) {
      TopComponentView({ imageHeight: $r('app.float.size_150'), isShowLeftBackButton: true })

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
          .textStyles($r('app.color.color_5eafc2'))
        Text(`${this.marbleSlabs?.slices_total}片`)
          .textStyles($r('app.color.color_6e9ed5'))
        Text(`${this.marbleSlabs?.area}㎡`)
          .textStyles($r('app.color.color_bb5636'))
      }
      .width(StyleConst.FULL_WIDTH)
      .height($r('app.float.size_100'))
      .borderRadius({ bottomLeft: $r('app.float.size_10'), bottomRight: $r('app.float.size_10') })
      .backgroundColor($r('app.color.color_888888'))
      .justifyContent(FlexAlign.SpaceEvenly)
    }
  }

  @Builder
  SlabsDetailContentBuild() {
    WaterFlow() {
      LazyForEach(this.slabsDetailDataSource, (model: layers) => {
        FlowItem() {
          GoodsInfo({
            slabsDetailModel: model,
            formPageType: CommonFormPageType.SLABS_DETAIL,
            clickCallBack: () => {
              router.pushNamedRoute({
                name: 'SlabsSize',
                params: model
              })
            }
          })
        }
        .width(StyleConst.FULL_WIDTH)
      }, (model: layers) => model.sn)
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

  build() {
    Column() {
      //顶部内容
      this.SlabsDetailTopBuild()
      //内容区域
      this.SlabsDetailContentBuild()
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
  }
}