import {
  CommonDataSource,
  CommonFormPageType,
  commonObj,
  GoodsInfo,
  requestCommonList,
  ScreenUtils,
  StyleConst,
} from "@tbs/common"
import { blocksCommonData } from "../model/BlocksModel"

@Builder
export function BlocksSearchBuilder(name: string, param: Object) {
  BlocksSearch()
}

@Component
export struct BlocksSearch {
  blocksInfos: NavPathStack = new NavPathStack()
  @State kv: string = ''
  @State changeValue: string = ''
  navContext: NavDestinationContext | null = null
  pageNo: number = 1
  pageSize: number = 1000
  blocksSearchDataSource = new CommonDataSource<commonObj>()
  controller: SearchController = new SearchController()

  aboutToAppear(): void {
    this.getCommonList()
  }

  getCommonList() {
    requestCommonList(this.kv, 'marble', this.pageNo, this.pageSize).then((data: blocksCommonData) => {
      if (data.code == 0 && data.data) {
        if (data.data.TotalCount && data.data.TotalCount > 0 && data.data.List) {
          this.blocksSearchDataSource.resetData(data.data.List)
        }
      }
    })
  }

  @Builder
  BlocksSearchTopBuild() {
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
        .backgroundColor($r('app.color.color_f5f5f5'))
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: $r('app.float.size_14'), weight: 400 })
        .textFont({ size: $r('app.float.size_14'), weight: 400 })
        .margin({ bottom: $r('app.float.size_20') })
        .onSubmit((value: string) => {
          this.kv = value
          this.getCommonList()
        })
    }
    .height(StyleConst.PERCENT_30)
  }

  @Builder
  GoodsInfoBuilder() {
    WaterFlow() {
      LazyForEach(this.blocksSearchDataSource, (model: commonObj) => {
        FlowItem() {
          GoodsInfo({
            blocksModel: model,
            formPageType: CommonFormPageType.BLOCKS_SEARCH,
          })
        }
        .width(StyleConst.FULL_WIDTH)
      }, (item: commonObj, index: number) => {
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
        //顶部部分
        this.BlocksSearchTopBuild()
        // 商品基本信息
        this.GoodsInfoBuilder()
      }
      .width(StyleConst.FULL_WIDTH)
      .height(StyleConst.FULL_HEIGHT)
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.navContext = context
      this.kv = context.pathInfo.param as string
      this.blocksInfos = context.pathStack
    })
  }
}