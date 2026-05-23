import {
  CommonDataSource,
  CommonFormPageType,
  CommonInterfaceType,
  commonObj,
  EmptyDataView,
  GoodsInfo,
  handleRefreshLoadMore,
  ImagePreviewView,
  LoadingView,
  LoadMoreFooterView,
  requestCommonList,
  ScreenUtils,
  StyleConst,
  toast,
  TopComponentView,
} from "@tbs/common"
import { blocksCommonData } from "../model/BlocksModel"
import { router } from "@kit.ArkUI"
import {
  pullRefreshLoadMoreModel,
  pullRefreshResponse
} from "@tbs/common/src/main/ets/widgets/pullRefresh/model/pullRefreshModel"

@Extend(Image)
function imageStyles(width: ResourceStr | string = StyleConst.FULL_WIDTH,
  height: ResourceStr | string = StyleConst.FULL_HEIGHT) {
  .width(width)
  .height(height)
  .objectFit(ImageFit.Cover)
}

@Entry({ routeName: 'BlocksSearch' })
@Component
export struct BlocksSearch {
  @State state: pullRefreshLoadMoreModel<commonObj> = {
    dataSource: new CommonDataSource<commonObj>(),
    hasMore: true,
    isBottomLoading: false,
    isLoading: false,
    totalCount: 0,
    isRefreshing: false,
    pageNo: 1,
    pageSize: 10
  }
  @State kv: string = ''
  @State changeValue: string = ''
  @State imageUrl: ResourceStr = ''
  private scroller = new ListScroller()
  navContext: NavDestinationContext | null = null
  controller: SearchController = new SearchController()
  searchTimer: number | null = null

  aboutToDisappear(): void {
    // 组件销毁时清理定时器
    if (this.searchTimer !== null) {
      clearTimeout(this.searchTimer);
      this.searchTimer = null;
    }
  }

  onPageShow(): void {
    const BlocksSearchParams = router.getParams() as Record<string, Object>
    if (BlocksSearchParams && typeof BlocksSearchParams.searchKey === 'string') {
      this.kv = BlocksSearchParams.searchKey
      this.getCommonList(true, true)
    } else {
      this.kv = ''
      this.getCommonList(true, true)
    }
  }

  getCommonList(isRefresh: boolean = true, isShowLoading: boolean = true): Promise<void> {
    return handleRefreshLoadMore<commonObj>(
      // 断言 requestCommonList 的返回类型符合要求
      (pageNo, pageSize, searchKey, type) => requestCommonList(pageNo, pageSize, searchKey, type
      ) as Promise<pullRefreshResponse<commonObj>>,
      this.state,
      isRefresh,
      isShowLoading,
      this.kv,
      CommonInterfaceType.MARBLE
    );
  }

  handleSearch(value: string, delay: number = 0): void {
    if (this.searchTimer !== null) {
      clearTimeout(this.searchTimer);
      this.searchTimer = null;
    }

    if (delay > 0) {
      this.searchTimer = setTimeout(() => {
        this.kv = value.trim();
        this.state.pageNo = 1;
        this.getCommonList(true, true)
        this.searchTimer = null;
      }, delay);
    } else {
      // 没有延迟，立即执行
      this.kv = value.trim();
      this.state.pageNo = 1;
      this.getCommonList(true, true)
    }
  }

  @Builder
  BlocksSearchTopBuild() {
    TopComponentView({
      imageHeight: StyleConst.FULL_HEIGHT,
      topBuildHeight: StyleConst.PERCENT_30,
      isShowLeftBackButton: true,
      isShowSearchButton: true,
      changeValue: this.changeValue,
      onChange: (value: string) => {
        this.changeValue = value;
        // 当输入框内容被清空时，立即触发搜索
        if (value === '') {
          this.handleSearch('', 0); // 0 表示无延迟
        }
      },
      onSubmit: (value: string) => {
        this.handleSearch(value, 500); // 500ms 延迟
      }
    })
  }

  @Builder
  GoodsInfoBuilder() {
    Stack() {
      if (this.state.isLoading) {
        LoadingView({ buildHeight: StyleConst.PERCENT_70 })
      } else {
        this.BlocksSearchContentView()
      }
    }
    .width(StyleConst.FULL_WIDTH)
  }

  @Builder
  BlocksSearchContentView() {
    Refresh({ refreshing: $$this.state.isRefreshing }) {
      if (this.state.dataSource.totalCount() > 0) {
        WaterFlow({ footer: this.getFooter(), scroller: this.scroller }) {
          LazyForEach(this.state.dataSource, (model: commonObj) => {
            FlowItem() {
              GoodsInfo({
                blocksModel: model,
                formPageType: CommonFormPageType.BLOCKS_SEARCH,
                clickCallBack: () => {
                  console.log('lucy== model++', JSON.stringify(model))
                  if (model.pictureUrls) {
                    this.imageUrl = model.pictureUrls
                    this.previewCustomDialog.open()
                  }
                }
              })
            }
            .width(StyleConst.FULL_WIDTH)
          }, (item: commonObj, index: number) => {
            return item.sn?.toString() + index.toString()
          })
        }
        .onReachEnd(() => {
          if (this.state.hasMore) {
            this.state.pageNo++; // 页码自增
            this.getCommonList(false, false); // 加载下一页
          }
        })
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
        .height(StyleConst.PERCENT_65)
        .margin({ top: $r('app.float.size_12') })
        .layoutWeight(1)
      } else {
        //空数据页面
        EmptyDataView({ buildHeight: StyleConst.PERCENT_70 })
      }
    }
    .refreshOffset(64)
    .onRefreshing(() => {
      this.state.pageNo = 1
      this.getCommonList(true, false)
    })
  }

  //滑动到底部文描
  @Builder
  getFooter() {
    LoadMoreFooterView({ isBottomLoading: this.state.isBottomLoading })
  }

  //点击图片预览事件
  private previewCustomDialog: CustomDialogController = new CustomDialogController({
    builder: ImagePreviewView({
      imageUrl: this.imageUrl,
    }),
    customStyle: true, //自由设置样式
    alignment: DialogAlignment.Center,
    autoCancel: false,
  })

  build() {
    Column() {
      //顶部部分
      this.BlocksSearchTopBuild()
      // 商品基本信息
      this.GoodsInfoBuilder()
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
  }
}