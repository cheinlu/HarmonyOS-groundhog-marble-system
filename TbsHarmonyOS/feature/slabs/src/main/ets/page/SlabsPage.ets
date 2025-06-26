import { CommonDataSource, requestMarbleList, StyleConst } from "@tbs/common"
import { slabsList, slabsInfoData } from "../model/SlabsModel"

@Component
export struct SlabsPage {
  slabsInfos: NavPathStack = new NavPathStack() //路由栈
  pageNo: number = 1
  pageSize: number = 1000
  slabsDataSource = new CommonDataSource<slabsList>()
  private scroller: Scroller = new Scroller();

  aboutToAppear(): void {
    this.getSlabsMarbleList()
  }

  getSlabsMarbleList(){
    requestMarbleList(this.pageNo, this.pageSize).then((data: slabsInfoData) => {
      if (data.code == 0 && data.data) {
        if (data.data.TotalCount && data.data.TotalCount > 0 && data.data.List) {
          this.slabsDataSource.pushData(data.data.List)
        }
      }
    })
  }

  @Builder
  SlabsTopBuild(){
    Image($r('app.media.furniture_topimg'))
      .width(StyleConst.FULL_WIDTH)
      .height(StyleConst.PERCENT_30)
      .objectFit(ImageFit.Cover)
  }

  @Builder
  SlabsListBuild(){
    List({ space: 10, scroller: this.scroller }) {
      LazyForEach(this.slabsDataSource, (model: slabsList) => {
        ListItem() {
          Row() {
            Text(model.name)
              .textAlign(TextAlign.Center)
              .fontSize($r('app.float.size_text_25'))
              .width(StyleConst.PERCENT_40)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
            Image(model.pictureUrl)
              .width(StyleConst.PERCENT_60)
              .height(StyleConst.FULL_HEIGHT)
              .shadow({
                radius: $r('app.float.size_2'),
                color: $r('app.color.color_1A000000'),
                offsetX: $r('app.float.size_2'),
                offsetY: $r('app.float.size_4')
              })
          }
        }
        .backgroundColor($r('app.color.color_fff'))
        .width(StyleConst.FULL_WIDTH)
        .height($r('app.float.size_100'))
        .borderRadius($r('app.float.size_15'))
        .onClick(() => {
          this.slabsInfos.pushPath({ name: 'SlabsSearch',param:model.name })
        })
      })
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .padding({ left: $r('app.float.size_10'), right: $r('app.float.size_10'), top: $r('app.float.size_15') })
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
    .listDirection(Axis.Vertical)
    .height(StyleConst.PERCENT_70)
    .backgroundColor($r('app.color.color_f9f9f9'))
  }

  build() {
    Navigation(this.slabsInfos) {
      Column() {
        //顶部
        this.SlabsTopBuild()
        //内容区域
        this.SlabsListBuild()

      }
      .width(StyleConst.FULL_WIDTH)
      .height(StyleConst.FULL_HEIGHT)
    }
  }
}