import { StyleConst } from "@tbs/common";

@Component
export struct HomePage {
  @State videoSrc: string = 'https://static.lusson.cn/video/home.mp4'
  @State previewUri: ResourceStr = $r('app.media.videoImg')
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X

  build() {
    Stack() {
      Image('https://static.lusson.cn/wx-miniprogram-image/home_bg.png')
        .alt($r('app.media.home_bg_img'))
        .width(StyleConst.FULL_WIDTH)
        .height(StyleConst.FULL_HEIGHT)

      Video({
        src: this.videoSrc,
        previewUri: this.previewUri,
        currentProgressRate: this.curRate
      })
        .width(StyleConst.FULL_WIDTH)
        .height($r('app.float.size_300'))
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
  }
}