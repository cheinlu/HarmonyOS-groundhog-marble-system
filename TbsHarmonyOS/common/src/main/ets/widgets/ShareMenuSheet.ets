import { StyleConst } from "../common";

@Extend(Image)
function shareMenuIMGStyle() {
  .aspectRatio(1)
  .width($r('app.float.size_64'))
}
@Extend(Text)
function shareMenuTxtStyle() {
  .fontSize($r('app.float.size_text_14'))
  .fontColor($r('app.color.color_222427')).fontWeight(FontWeight.Normal)
}

@Component
export struct ShareMenuSheet {
  @Link showShareBottomSheet: boolean
  /**
   * 点击分享好友
   */
  onClickShareToFriends: () => void = () => {
  }
  /**
   * 点击分享朋友圈
   */
  onClickShareToTimeline: () => void = () => {
  }
  /**
   * 点击一键生成图片
   */
  onClickGenerateImage: () => void = () => {
  }

  build() {
    Stack(){
      Row() {
        Text('分享至').fontSize($r('app.float.size_text_16'))
          .fontColor($r('app.color.color_222427')).fontWeight(FontWeight.Bold)
      }
      .justifyContent(FlexAlign.Center)
      .padding({ top: $r('app.float.size_16') })
      .alignItems(VerticalAlign.Top)
      .width(StyleConst.FULL_WIDTH)
      .alignSelf(ItemAlign.Center)

      Row() {
        // 微信好友
        Column({ space: 11 }) {
          Image($r('app.media.share_wechat')).shareMenuIMGStyle()
          Text('微信好友').shareMenuTxtStyle()
        }.layoutWeight(1)
        .margin({ top: $r('app.float.size_85'), bottom: $r('app.float.size_60') }).onClick(()=>{
          this.onClickShareToFriends()
          this.showShareBottomSheet = false
        })

        // 朋友圈
        Column({ space: 11 }) {
          Image($r('app.media.friends_circle')).shareMenuIMGStyle()
          Text('朋友圈').shareMenuTxtStyle()
        }
        .layoutWeight(1)
        .margin({ top: $r('app.float.size_85'), bottom: $r('app.float.size_60') })
        .onClick(()=>{
          this.onClickShareToTimeline()
          this.showShareBottomSheet = false
        })

        // 生成图片
        Column({ space: 11 }) {
          Image($r('app.media.share_image')).shareMenuIMGStyle()
          Text('一键生成图片').shareMenuTxtStyle()
        }.layoutWeight(1)
        .margin({ top: $r('app.float.size_85'), bottom: $r('app.float.size_60') })
        .onClick(()=>{
          this.onClickGenerateImage()
          this.showShareBottomSheet = false
        })
      }

      Row() {
        Image($r('app.media.close'))
          .objectFit(ImageFit.Contain)
          .width($r('app.float.size_18'))
          .margin($r('app.float.size_12'))
      }
      .aspectRatio(1)
      .responseRegion([{
        //增加触摸热区
        width: '100%',
        height: '100%'
      }]).hitTestBehavior(HitTestMode.Block).onClick(()=>{
        //关闭
        this.showShareBottomSheet = false
      })
    }
    .align(Alignment.TopEnd)
    .borderRadius({
      topLeft: $r('app.float.size_16'),
      topRight: $r('app.float.size_16')
    })
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .backgroundColor(Color.White)
  }
}