import { StyleConst } from "@tbs/common"
import { mapListItem } from "../model/MineStoreModel"


interface TextStyle {
  height: Length
}

@Extend(Text)
//文本样式
function textStyles(item: TextStyle) {
  .fontColor($r('app.color.color_0165b8'))
  .textAlign(TextAlign.Center)
  .fontSize($r('app.float.size_18'))
  .height(item.height)
}

@CustomDialog
@Component
export struct MapDialogCall {
  mapList: mapListItem[] = []
  controller: CustomDialogController
  propBackgroundColor: Color | number | string | Resource = '#f3f4f5'
  propPadding: Padding | Length | LocalizedPadding = {}
  propBorderRadius: ResourceStr = '0'
  title: ResourceStr = '';
  titlePadding: Padding = { top: $r('app.float.size_16'), bottom: $r('app.float.size_16') }
  titleFontSize: ResourceStr = $r('app.float.size_text_16')
  titleTextColor: ResourceColor = '#222427'
  titleBgColor: ResourceColor = Color.Transparent
  onClickCallBack?: (ele: mapListItem) => void
  propHeight: Length = $r('app.float.size_25')
  propSpace: number = 13
  propContentPadding: Padding | Length | LocalizedPadding = {
    top: $r('app.float.size_12'),
    bottom: $r('app.float.size_12')
  }
  titleHeight: Length = 0

  build() {
    Column({ space: 12 }) {
      Column({ space: this.propSpace }) {
        Text(this.title)
          .fontColor(this.titleTextColor)
          .fontSize(this.titleFontSize)
          .textAlign(TextAlign.Center)
          .width(StyleConst.FULL_WIDTH)
          .height(this.titleHeight)

        ForEach(
          this.mapList,
          (ele: mapListItem) => {
            Text(ele.name)
              .textStyles({ height: this.propHeight })
              .onClick(() => {
                this.onClickCallBack && this.onClickCallBack(ele)
              })
          }
        )
      }
      .borderRadius(this.propBorderRadius)
      .justifyContent(FlexAlign.Center)
      .width(StyleConst.FULL_WIDTH)
      .backgroundColor(Color.White)
      .padding(this.propContentPadding)

      Row() {
        Text('取消')
          .textStyles({ height: this.propHeight })
          .fontColor($r('app.color.color_0165b8'))
          .width(StyleConst.FULL_WIDTH)
      }
      .borderRadius(this.propBorderRadius)
      .backgroundColor(Color.White)
      .height($r('app.float.size_50'))
      .margin({ bottom: $r('app.float.size_16') })
      .onClick(()=>{
        this.controller.close()
      })
    }
    .padding(this.propPadding)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    .width(StyleConst.FULL_WIDTH)
    .backgroundColor(this.propBackgroundColor)
  }
}
