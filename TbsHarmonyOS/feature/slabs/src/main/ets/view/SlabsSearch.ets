import {
  CommonDataSource,
  marblesObj,
  requestMarblesList,
  StyleConst,
  GoodsInfo,
  CommonFormPageType,
  ScreenUtils,
  LoadingView,
  LoadMoreFooterView,
  EmptyDataView,
  handleRefreshLoadMore,
  TopComponentView
} from "@tbs/common"
import { router } from "@kit.ArkUI"
import './SlabsDetail'
import {
  pullRefreshLoadMoreModel,
  pullRefreshResponse
} from "@tbs/common/src/main/ets/widgets/pullRefresh/model/pullRefreshModel"

@Entry({ routeName: 'SlabsSearch' })
@Component
export struct SlabsSearch {
  @State state: pullRefreshLoadMoreModel<marblesObj> = {
    dataSource: new CommonDataSource<marblesObj>(),
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
  private scroller = new ListScroller()
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
    const SlabsSearchParams = router.getParams() as Record<string, Object>
    if (SlabsSearchParams) {
      this.kv = SlabsSearchParams.searchKey as string
      this.getMarbleList(true, true)
    } else {
      this.kv = ''
      this.getMarbleList(true, true)
    }
  }

  //获取名称列表
  getMarbleList(isRefresh: boolean = true, isShowLoading: boolean = true): Promise<void> {
    return handleRefreshLoadMore<marblesObj>(
      // 断言 requestMarblesList 的返回类型符合要求
      (pageNo, pageSize, searchKey) => requestMarblesList(pageNo, pageSize,
        searchKey) as Promise<pullRefreshResponse<marblesObj>>,
      this.state,
      isRefresh,
      isShowLoading,
      this.kv
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
        this.getMarbleList(true, true)
        this.searchTimer = null;
      }, delay);
    } else {
      // 没有延迟，立即执行
      this.kv = value.trim();
      this.state.pageNo = 1;
      this.getMarbleList(true, true)
    }
  }

  //顶部搜索
  @Builder
  SlabsSearchTopBuild() {
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

  //内容区域
  @Builder
  SlabsSearchContentBuild() {
    Stack() {
      if (this.state.isLoading) {
        LoadingView({ buildHeight: StyleConst.PERCENT_70 })
      } else {
        this.SlabsSearchContentView()
      }
    }
    .width(StyleConst.FULL_WIDTH)
  }

  //内容区域列表展示
  @Builder
  SlabsSearchContentView() {
    Refresh({ refreshing: $$this.state.isRefreshing }) {
      if (this.state.dataSource.totalCount() > 0) {
        WaterFlow({ footer: this.getFooter(), scroller: this.scroller }) {
          LazyForEach(this.state.dataSource, (model: marblesObj) => {
            FlowItem() {
              GoodsInfo({
                goodsModel: model,
                formPageType: CommonFormPageType.SLABS_SEARCH,
                clickCallBack: () => {
                  router.pushNamedRoute({
                    name: 'SlabsDetail',
                    params: model
                  })
                }
              })
            }
            .width(StyleConst.FULL_WIDTH)
          }, (item: marblesObj, index: number) => {
            return item.sn?.toString() + index.toString()
          })
        }
        .onReachEnd(() => {
          if (this.state.hasMore) {
            this.state.pageNo++; // 页码自增
            this.getMarbleList(false, false); // 加载下一页
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
      this.getMarbleList(true, false)
    })
  }

  //滑动到底部文描
  @Builder
  getFooter() {
    LoadMoreFooterView({ isBottomLoading: this.state.isBottomLoading })
  }

  build() {
    Column() {
      //顶部搜索
      this.SlabsSearchTopBuild()
      //内容区域
      this.SlabsSearchContentBuild()
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
  }
}