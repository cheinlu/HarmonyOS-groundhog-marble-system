import { ScreenUtils, StyleConst, SwiperCard } from "@tbs/common"
import { furnitureObj, skusObj } from "../model/FurnitureModel"

@Builder
export function FurnitureDetailBuilder(name: string, param: Object) {
  FurnitureDetail()
}

@Component
export struct FurnitureDetail {
  scroller: Scroller = new Scroller()
  @State detailData: furnitureObj | undefined = undefined
  @State selectedSpecIndex: number = 0 // 选中规格索引
  navContext: NavDestinationContext | null = null

  @Builder
  FurnitureDetailBuild() {
    Scroll(this.scroller) {
      Column() {
        // 轮播图部分
        this.SwiperBuilder()
        // 商品基本信息
        this.GoodsInfoBuilder()
        // 商品详情图片
        this.DetailImagesBuilder()
      }
      .alignItems(HorizontalAlign.Start)
      .width(StyleConst.FULL_WIDTH)
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .scrollable(ScrollDirection.Vertical)
    .backgroundColor($r('app.color.color_f4f4f4'))
  }

  @Builder
  SwiperBuilder() {
    Stack({ alignContent: Alignment.TopStart }) {
      SwiperCard({ swiperHeight: StyleConst.PERCENT_60 })
      Image($r('app.media.common_back_white'))
        .width($r('app.float.size_20'))
        .margin({ left: $r('app.float.size_5'), top: ScreenUtils.getInstance().getStatusBarHeight() })
        .onClick(() => {
          this.navContext?.pathStack.pop()
        })
    }
  }

  @Builder
  GoodsInfoBuilder() {
    Column({ space: 20 }) {
      Text(this.detailData?.name)
        .fontSize($r('app.float.size_text_25'))
        .fontColor($r('app.color.color_333'))
        .padding({ left: $r('app.float.size_15') })
      if (this.detailData?.skus && this.detailData.skus.length > 0) {
        Text(`价格：￥${this.detailData.skus[this.selectedSpecIndex]?.price || ''}`)
          .fontColor($r('app.color.color_cf4444'))
          .fontSize($r('app.float.size_text_15'))
          .padding({ left: $r('app.float.size_15') })
      }
      // 规格选择
      if (this.detailData?.skus) {
        Text('尺寸：')
          .fontColor($r('app.color.color_cf4444'))
          .fontSize($r('app.float.size_text_15'))
          .padding({ left: $r('app.float.size_15') })

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(this.detailData.skus, (spec: skusObj, index: number) => {
            Text(spec.size || '')
              .fontSize($r('app.float.size_text_15'))
              .fontColor(this.selectedSpecIndex === index ? $r('app.color.color_c84921') : $r('app.color.color_333'))
              .backgroundColor(this.selectedSpecIndex === index ?
              $r('app.color.color_f8ebe8') : 'transparent')// 半透明背景
              .padding(5)
              .margin({ right: $r('app.float.size_15') })
              .border({
                width: 0.5,
                radius: $r('app.float.size_4'),
                color: $r('app.color.color_c84921'),
                style: BorderStyle.Solid
              })
              .onClick(() => {
                this.selectedSpecIndex = index
              })
          })
        }
        .width(StyleConst.FULL_WIDTH)
        .padding({ left: $r('app.float.size_15') })
      }
      Blank().width(StyleConst.FULL_WIDTH).height(1).color($r('app.color.color_a0a0a0'))
      Row({ space: 15 }) {
        Text('系列1').fontColor($r('app.color.color_898b94')).fontSize($r('app.float.size_18'))
        Text(`家居-${this.detailData?.sn}`).fontSize($r('app.float.size_18'))
      }.padding({ left: $r('app.float.size_15') }).width(StyleConst.FULL_WIDTH)

    }
    .width(StyleConst.FULL_WIDTH)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
    .padding({ top: $r('app.float.size_20'), bottom: $r('app.float.size_20') })
    .margin({ bottom: $r('app.float.size_15') })
  }

  @Builder
  DetailImagesBuilder() {
    Column({ space: 15 }) {
      Row() {
        Blank()
          .width($r("app.float.size_2"))
          .height($r("app.float.size_15"))
          .backgroundColor($r("app.color.color_c84921"))
        Text('产品详情')
          .fontSize($r('app.float.size_18'))
          .fontColor($r('app.color.color_333'))
          .margin({ left: $r('app.float.size_5') })
          .fontWeight(FontWeight.Bold)
      }
      .width(StyleConst.FULL_WIDTH)
      .margin({ top: $r('app.float.size_30'), bottom: $r('app.float.size_15') })
      .alignItems(VerticalAlign.Center)

      if (this.detailData?.pictureUrls) {
        Image(this.detailData?.pictureUrls).width(StyleConst.FULL_WIDTH).height($r('app.float.size_400'))
      }
      if (this.detailData?.pictureUrls1) {
        Image(this.detailData?.pictureUrls1).width(StyleConst.FULL_WIDTH).height($r('app.float.size_400'))
      }
      if (this.detailData?.pictureUrls2) {
        Image(this.detailData?.pictureUrls2).width(StyleConst.FULL_WIDTH).height($r('app.float.size_400'))
      }
      if (this.detailData?.pictureUrls3) {
        Image(this.detailData?.pictureUrls3).width(StyleConst.FULL_WIDTH).height($r('app.float.size_400'))
      }
      if (this.detailData?.pictureUrls4) {
        Image(this.detailData?.pictureUrls4).width(StyleConst.FULL_WIDTH).height($r('app.float.size_400'))
      }
    }
    .padding({ left: $r('app.float.size_20'), right: $r('app.float.size_20') })
    .backgroundColor(Color.White)
  }

  build() {
    NavDestination() {
      this.FurnitureDetailBuild()
    }
    .hideTitleBar(true)
    .mode(NavDestinationMode.STANDARD)
    .onReady((context: NavDestinationContext) => {
      this.navContext = context
      this.detailData = context.pathInfo.param as furnitureObj
    })
  }
}