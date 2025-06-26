import { StyleConst, SwiperCard } from "@tbs/common"
import { ContactList } from "../view/ContactList"

@Component
export struct MinePage {
  scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column() {
        SwiperCard({ swiperHeight: StyleConst.PERCENT_40 })
        ContactList()
      }
      .width(StyleConst.FULL_WIDTH)
      .height(StyleConst.FULL_HEIGHT)
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .scrollable(ScrollDirection.Vertical)
  }
}
