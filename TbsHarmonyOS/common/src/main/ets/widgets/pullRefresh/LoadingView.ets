import { StyleConst } from '../../common'

//页面刷新-中间大loading
@Component
export struct LoadingView {
  @Prop buildHeight: ResourceStr

  build() {
    Row() {
      LoadingProgress()
        .width($r('app.float.size_100'))
        .height($r('app.float.size_100'))
        .color($r('app.color.color_c84921'))
    }
    .width(StyleConst.FULL_WIDTH)
    .height(this.buildHeight)
    .justifyContent(FlexAlign.Center)
  }
}