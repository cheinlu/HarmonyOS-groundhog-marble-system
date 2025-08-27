import { ScreenUtils, StyleConst } from "../common";
import { router } from "@kit.ArkUI";

//顶部区域展示--公共部分封装
@Component
export struct TopComponentView {
  @Prop isShowLeftBackButton: boolean //是否有返回按钮
  @Prop isShowSearchButton: boolean //是否有搜索框
  @Prop imageHeight: string | ResourceStr //图片高度
  @Prop topBuildHeight: string | ResourceStr //整个顶部高度
  @Prop changeValue: string
  controller: SearchController = new SearchController()
  onSubmit?: (value: string) => void //搜索按钮回调
  onChange?: (value: string) => void //输入框内容发生变化时的回调

  build() {
    Stack({ alignContent: this.isShowSearchButton ? Alignment.Bottom : Alignment.TopStart }) {
      Stack({ alignContent: Alignment.TopStart }) {
        Image($r('app.media.furniture_topimg'))
          .width(StyleConst.FULL_WIDTH)
          .height(this.imageHeight)
          .objectFit(ImageFit.Cover)
        if (this.isShowLeftBackButton) {
          Image($r('app.media.common_back_white'))
            .width($r('app.float.size_20'))
            .margin({ left: $r('app.float.size_5'), top: ScreenUtils.getInstance().getStatusBarHeight() })
            .onClick(() => {
              router.back()
            })
        }
      }

      if (this.isShowSearchButton) {
        Search({ value: this.changeValue, placeholder: '点击快速搜索商品', controller: this.controller })
          .searchButton('搜索')
          .width(StyleConst.PERCENT_95)
          .height($r('app.float.size_40'))
          .backgroundColor($r('app.color.color_f5f5f5'))
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: $r('app.float.size_14'), weight: StyleConst.FONT_WEIGHT_400 })
          .textFont({ size: $r('app.float.size_14'), weight: StyleConst.FONT_WEIGHT_400 })
          .margin({ bottom: $r('app.float.size_20') })
          .onChange((value: string) => {
            if (this.onChange) {
              this.onChange(value)
            }
          })
          .onSubmit((value: string) => {
            if (this.onSubmit) {
              this.onSubmit(value)
            }
          })
      }
    }
    .height(this.topBuildHeight)
  }
}