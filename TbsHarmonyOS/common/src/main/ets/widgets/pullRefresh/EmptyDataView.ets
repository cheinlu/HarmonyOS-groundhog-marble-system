import { StyleConst } from "../../common"

//空数据试图
@Component
export struct EmptyDataView {
  @Prop buildHeight: ResourceStr

  build() {
    Column({ space: 20 }) {
      Image($r('app.media.empty'))
        .width($r('app.float.size_180'))
        .height($r('app.float.size_180'))
        .borderRadius($r('app.float.size_10'))
      Text('暂无数据')
        .fontSize($r('app.float.size_text_16'))
    }
    .width(StyleConst.FULL_WIDTH)
    .height(this.buildHeight)
    .justifyContent(FlexAlign.Center)
  }
}