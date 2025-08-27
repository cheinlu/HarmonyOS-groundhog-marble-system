import { StyleConst } from "../../common";

//底部加载状态提示
@Component
export struct LoadMoreFooterView {
  @Prop isBottomLoading: boolean

  build() {
    Row() {
      if (this.isBottomLoading) {
        // 加载中状态
        LoadingProgress()
          .width($r('app.float.size_28'))
          .height($r('app.float.size_28'))
          .color($r('app.color.color_c84921'))
          .margin({ right: $r('app.float.size_10') })
        Text('加载中')
          .fontSize($r('app.float.size_text_16'))
          .fontColor($r('app.color.color_c84921'))
      } else {
        // 没有更多数据
        Text('已显示全部数据')
          .fontSize($r('app.float.size_text_16'))
          .fontColor($r('app.color.color_999'))
          .textAlign(TextAlign.Center)
          .width(StyleConst.FULL_WIDTH)
      }
    }
    .height($r('app.float.size_40'))
    .width(StyleConst.FULL_WIDTH)
    .justifyContent(FlexAlign.Center);
  }
}