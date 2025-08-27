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
import { router } from "@kit.ArkUI"

@Entry({ routeName: 'SlabsSize' })
@Component
export struct SlabsSize {
  @State layersObj: layers | undefined = undefined
  slabsSizeDataSource = new CommonDataSource<slices>()
  @State showShareBottomSheet: boolean = false

  onPageShow(): void {
    const SlabsSizeParams = router.getParams() as Record<string, Object>
    if (SlabsSizeParams && typeof SlabsSizeParams === 'object' && Array.isArray((SlabsSizeParams as layers).slices)) {
      this.layersObj = SlabsSizeParams as layers
      // 确保slices是数组（兜底空数组）
      const validSlices = Array.isArray(this.layersObj.slices) ? this.layersObj.slices : [];
      this.slabsSizeDataSource.pushData(validSlices);
    }
  }

  @Builder
  SlabsSizeTopBuild() {
    Column({ space: 20 }) {
      Image($r('app.media.common_back_black'))
        .width($r('app.float.size_20'))
        .margin({ left: $r('app.float.size_5'), top: ScreenUtils.getInstance().getStatusBarHeight() })
        .onClick(() => {
          router.back()
        })
      Row() {
        Text(this.layersObj?.name)
          .fontSize($r('app.float.size_text_22'))
        //todo 暂不支持此功能，先注释入口
        // Image($r('app.media.share'))
        //   .width($r('app.float.size_30'))
        //   .objectFit(ImageFit.Contain)
        //   .aspectRatio(1)
        //   .onClick(() => {
        //     this.showShareBottomSheet = !this.showShareBottomSheet
        //   })
        //   .bindContentCover($$this.showShareBottomSheet, this.ShareMenusBuilder(), {
        //     modalTransition: ModalTransition.NONE
        //   })
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
        Text(`${this.layersObj?.width ?? '--'} x ${this.layersObj?.height ?? '--'} x ${this.layersObj?.length ??
          '--'}mm`)
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

  @Builder
  SlabsSizeContentBuild() {
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
    .margin({ top: $r('app.float.size_12') })
    .layoutWeight(1)
  }

  build() {
    Column() {
      //顶部内容
      this.SlabsSizeTopBuild()
      //内容区域
      this.SlabsSizeContentBuild()
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .alignItems(HorizontalAlign.Start)
    .margin({ top: $r('app.float.size_20') })
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


