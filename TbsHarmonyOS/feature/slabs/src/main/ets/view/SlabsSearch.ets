import {
  CommonDataSource,
  marblesObj,
  requestMarblesList,
  StyleConst,
  GoodsInfo,
  CommonFormPageType,
  ScreenUtils
} from "@tbs/common"
import { slabsMarblesData } from "../model/SlabsModel"

@Builder
export function SlabsSearchBuilder() {
  SlabsSearch()
}

@Component
export struct SlabsSearch {
  slabsInfos: NavPathStack = new NavPathStack()
  @State kv: string = ''
  @State changeValue: string = ''
  controller: SearchController = new SearchController()
  slabsSearchDataSource = new CommonDataSource<marblesObj>()
  navContext: NavDestinationContext | null = null
  pageNo: number = 1
  pageSize: number = 1000

  aboutToAppear(): void {
    setTimeout(() => {
      this.getMarbleList()
    }, 500)
  }

  //获取名称列表
  getMarbleList() {
    requestMarblesList(this.kv, this.pageNo, this.pageSize).then((data: slabsMarblesData) => {
      if (data.code == 0 && data.data) {
        if (data.data.TotalCount && data.data.TotalCount > 0 && data.data.List) {
          this.slabsSearchDataSource.resetData(data.data.List)
        }
      }
    })
  }

  @Builder
  SlabsSearchTopBuild(){
    Stack({ alignContent: Alignment.Bottom }) {
      Stack({ alignContent: Alignment.TopStart }) {
        Image($r('app.media.furniture_topimg'))
          .width(StyleConst.FULL_WIDTH)
          .height(StyleConst.FULL_HEIGHT)
        Image($r('app.media.common_back_white'))
          .width($r('app.float.size_20'))
          .margin({ left: $r('app.float.size_5'), top: ScreenUtils.getInstance().getStatusBarHeight() })
          .onClick(() => {
            this.navContext?.pathStack.pop()
          })
      }

      Search({ value: this.changeValue, placeholder: '点击快速搜索商品', controller: this.controller })
        .searchButton('搜索')
        .width(StyleConst.PERCENT_95)
        .height($r('app.float.size_40'))
        .backgroundColor('#F5F5F5')
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: $r('app.float.size_14'), weight: 400 })
        .textFont({ size: $r('app.float.size_14'), weight: 400 })
        .margin({ bottom: $r('app.float.size_20') })
        .onSubmit((value: string) => {
          this.kv = value
          this.getMarbleList()
        })
    }
    .height(StyleConst.PERCENT_30)
  }

  @Builder
  SlabsSearchContentBuild(){
    WaterFlow() {
      LazyForEach(this.slabsSearchDataSource, (model: marblesObj) => {
        FlowItem() {
          GoodsInfo({
            goodsModel: model,
            formPageType: CommonFormPageType.SLABS_SEARCH,
            clickCallBack: () => {
              this.slabsInfos.pushPath({ name: 'SlabsDetail', param: model })
            }
          })
        }
        .width(StyleConst.FULL_WIDTH)
      }, (item: marblesObj, index: number) => {
        return item.sn?.toString() + index.toString()
      })
    }
    .padding({
      left: $r('app.float.size_12'),
      right: $r('app.float.size_12'),
    })
    .scrollBar(BarState.Off)
    .cachedCount(6)
    .columnsTemplate('1fr 1fr')
    .columnsGap($r('app.float.size_9'))
    .rowsGap($r('app.float.size_9'))
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .margin({ top: $r('app.float.size_12') })
    .layoutWeight(1)
  }

  build() {
    NavDestination() {
      Column() {
        //顶部搜索
        this.SlabsSearchTopBuild()
        //内容
        this.SlabsSearchContentBuild()
      }
      .width(StyleConst.FULL_WIDTH)
      .height(StyleConst.FULL_HEIGHT)
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.navContext = context
      this.kv = context.pathInfo.param as string
      this.slabsInfos = context.pathStack
    })
  }
}