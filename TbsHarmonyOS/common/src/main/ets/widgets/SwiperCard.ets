import { StyleConst } from "../../../../Index"

@Component
export struct SwiperCard {
  //轮播图数据源
  @State swiperList: ResourceStr[] = [
    $r("app.media.home_bg"), $r('app.media.furniture_topimg')
  ]
  @State selectedIndex: number = 0 //默认选中索引为0
  @Prop swiperHeight: ResourceStr

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Swiper() {
        ForEach(this.swiperList, (item: ResourceStr, index: number) => {
          Image(item)
            .width(StyleConst.FULL_WIDTH)
            .height(StyleConst.FULL_HEIGHT)
        })
      }
      .onChange((index: number) => {
        this.selectedIndex = index
      })

      .loop(true)
      .autoPlay(true)
      .interval(2000)
      .width(StyleConst.FULL_WIDTH)
      .height(this.swiperHeight)
    }
  }
}