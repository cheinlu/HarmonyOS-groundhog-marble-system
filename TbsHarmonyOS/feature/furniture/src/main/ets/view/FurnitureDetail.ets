import { ScreenUtils, StyleConst, SwiperCard } from "@tbs/common"
import { furnitureObj, skusObj } from "../model/FurnitureModel"
import { router } from "@kit.ArkUI"

@Extend(Text)
function textStyles(fontSize: Resource, fontColor: ResourceColor = Color.Black) {
  .fontSize(fontSize)
  .fontColor(fontColor)
}

@Extend(Image)
function imageStyles(width: ResourceStr | string) {
  .width(width)
  .objectFit(ImageFit.Cover)
}

@Entry({ routeName: 'FurnitureDetail' })
@Component
export struct FurnitureDetail {
  scroller: Scroller = new Scroller()
  @State detailData: furnitureObj | undefined = undefined
  @State selectedSpecIndex: number = 0 // 选中规格索引

  onPageShow(): void {
    const FurnitureDetailParams = router.getParams() as Record<string, Object>
    if (FurnitureDetailParams) {
      this.detailData = FurnitureDetailParams as furnitureObj
    }
  }

  // 统一处理图片数组
  getImageUrls(): string[] {
    if (!this.detailData) {
      return []
    }
    const images: string[] = [];
    // 定义要检查的属性列表
    const props = [
      'pictureUrls',
      'pictureUrls1',
      'pictureUrls2',
      'pictureUrls3',
      'pictureUrls4',
      'pictureUrls5'
    ];

    // 遍历属性列表，显式访问每个属性
    for (const prop of props) {
      let url: string | undefined;
      // 显式检查并访问每个属性
      switch (prop) {
        case 'pictureUrls':
          url = this.detailData.pictureUrls;
          break;
        case 'pictureUrls1':
          url = this.detailData.pictureUrls1;
          break;
        case 'pictureUrls2':
          url = this.detailData.pictureUrls2;
          break;
        case 'pictureUrls3':
          url = this.detailData.pictureUrls3;
          break;
        case 'pictureUrls4':
          url = this.detailData.pictureUrls4;
          break;
        case 'pictureUrls5':
          url = this.detailData.pictureUrls5;
          break;
      }

      if (url && typeof url === 'string' && url.trim() !== '') {
        images.push(url);
      }
    }

    return images;
  }

  @Builder
  FurnitureDetailTopBuild() {
    Image($r('app.media.common_back_black'))
      .imageStyles($r('app.float.size_20'))
      .margin({
        left: $r('app.float.size_5'),
        bottom: $r('app.float.size_15'),
        top: ScreenUtils.getInstance().getStatusBarHeight()
      })
      .onClick(() => {
        router.back()
      })
  }

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
    .layoutWeight(1)
    .scrollable(ScrollDirection.Vertical)
    .backgroundColor($r('app.color.color_f4f4f4'))
  }

  @Builder
  SwiperBuilder() {
    SwiperCard({ swiperHeight: StyleConst.PERCENT_50, swiperList: this.getImageUrls() })
  }

  @Builder
  GoodsInfoBuilder() {
    Column({ space: 20 }) {
      Text(this.detailData?.name)
        .textStyles($r('app.float.size_text_25'), $r('app.color.color_333'))
        .padding({ left: $r('app.float.size_15') })
      if (this.detailData?.skus && this.detailData.skus.length > 0) {
        Text(`价格：￥${this.detailData.skus[this.selectedSpecIndex]?.price || ''}`)
          .textStyles($r('app.float.size_text_15'), $r('app.color.color_cf4444'))
          .padding({ left: $r('app.float.size_15') })
      }
      // 规格选择
      if (this.detailData?.skus && Array.isArray(this.detailData.skus)) {
        Text('尺寸：')
          .textStyles($r('app.float.size_text_15'), $r('app.color.color_cf4444'))
          .padding({ left: $r('app.float.size_15') })

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(this.detailData.skus, (spec: skusObj, index: number) => {
            Text(spec.size || '')
              .fontSize($r('app.float.size_text_15'))
              .fontColor(this.selectedSpecIndex === index ? $r('app.color.color_c84921') : $r('app.color.color_333'))
              .backgroundColor(this.selectedSpecIndex === index ?
              $r('app.color.color_f8ebe8') : 'transparent')// 半透明背景
              .padding($r('app.float.size_5'))
              .margin({ right: $r('app.float.size_15') })
              .border({
                width: $r('app.float.size_0_5'),
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
      Blank().width(StyleConst.FULL_WIDTH).height($r('app.float.size_1')).color($r('app.color.color_a0a0a0'))
      Row({ space: 15 }) {
        Text('系列1').textStyles($r('app.float.size_18'), $r('app.color.color_898b94'))
        Text(`家居-${this.detailData?.sn}`).textStyles($r('app.float.size_18'))
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
    Column() {
      Row() {
        Blank()
          .width($r("app.float.size_2"))
          .height($r("app.float.size_15"))
          .backgroundColor($r("app.color.color_c84921"))
        Text('产品详情')
          .textStyles($r('app.float.size_18'), $r('app.color.color_333'))
          .margin({ left: $r('app.float.size_5') })
          .fontWeight(FontWeight.Bold)
      }
      .width(StyleConst.FULL_WIDTH)
      .margin({ top: $r('app.float.size_30'), bottom: $r('app.float.size_15') })
      .alignItems(VerticalAlign.Center)

      ForEach(this.getImageUrls(), (url: string) => {
        Image(url)
          .imageStyles(StyleConst.FULL_WIDTH)
          .aspectRatio(1)
          .margin({ bottom: $r('app.float.size_10') })
      })
    }
    .padding({ left: $r('app.float.size_20'), right: $r('app.float.size_20'), bottom: $r('app.float.size_20') })
    .backgroundColor(Color.White)
  }

  build() {
    Column() {
      //顶部内容
      this.FurnitureDetailTopBuild()
      //主体部分
      this.FurnitureDetailBuild()
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .alignItems(HorizontalAlign.Start)
  }
}