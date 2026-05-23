import {
  CommonDataSource,
  EmptyDataView,
  handleRefreshLoadMore,
  LoadingView,
  LoadMoreFooterView,
  requestMarbleList,
  StyleConst,
  TopComponentView,
} from "@tbs/common"
import { slabsList } from "../model/SlabsModel"
import { router } from "@kit.ArkUI"
import '../view/SlabsSearch'
import {
  pullRefreshLoadMoreModel,
  pullRefreshResponse
} from "@tbs/common/src/main/ets/widgets/pullRefresh/model/pullRefreshModel"

@Component
export struct SlabsPage {
  @State state: pullRefreshLoadMoreModel<slabsList> = {
    dataSource: new CommonDataSource<slabsList>(),
    hasMore: true,
    isBottomLoading: false,
    isLoading: false,
    totalCount: 0,
    isRefreshing: false,
    pageNo: 1,
    pageSize: 10
  }
  private scroller: Scroller = new Scroller();

  aboutToAppear(): void {
    this.getSlabsMarbleList(true, true)
  }

  getSlabsMarbleList(isRefresh: boolean = true, isShowLoading: boolean = true): Promise<void> {
    return handleRefreshLoadMore<slabsList>(
      // 断言 requestMarbleList 的返回类型符合要求
      (pageNo, pageSize) => requestMarbleList(pageNo, pageSize) as Promise<pullRefreshResponse<slabsList>>,
      this.state,
      isRefresh,
      isShowLoading
    );
  }

  //内容区域
  @Builder
  SlabsListBuild() {
    Stack() {
      if (this.state.isLoading) {
        LoadingView({ buildHeight: StyleConst.PERCENT_70 })
      } else {
        this.SlabsListView()
      }
    }
    .width(StyleConst.FULL_WIDTH)
  }

  //内容区域列表展示
  @Builder
  SlabsListView() {
    Refresh({ refreshing: $$this.state.isRefreshing }) {
      if (this.state.dataSource.totalCount() > 0) {
        List({ space: 10, scroller: this.scroller }) {
          LazyForEach(this.state.dataSource, (model: slabsList) => {
            ListItem() {
              Row() {
                Text(model.name)
                  .textAlign(TextAlign.Center)
                  .fontSize($r('app.float.size_text_25'))
                  .width(StyleConst.PERCENT_40)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                Image(model.pictureUrl)
                  .alt($r('app.media.default_img'))
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
              router.pushNamedRoute({
                name: 'SlabsSearch',
                params: {
                  searchKey: model.name
                }
              })
            })
          }, (model: slabsList) => model.id?.toString())

          ListItem() {
            LoadMoreFooterView({ isBottomLoading: this.state.isBottomLoading })
          }
          .width(StyleConst.FULL_WIDTH);
        }
        .onReachEnd(() => {
          if (this.state.hasMore) {
            this.state.pageNo++; // 页码自增
            this.getSlabsMarbleList(false, false); // 加载下一页
          }
        })
        .width(StyleConst.FULL_WIDTH)
        .padding({ left: $r('app.float.size_10'), right: $r('app.float.size_10'), top: $r('app.float.size_15') })
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
        .listDirection(Axis.Vertical)
        .height(StyleConst.PERCENT_70)
        .backgroundColor($r('app.color.color_f9f9f9'))
      } else {
        //空数据页面
        EmptyDataView({ buildHeight: StyleConst.PERCENT_70 })
      }
    }
    .refreshOffset(64)
    .onRefreshing(() => {
      this.state.pageNo = 1
      this.getSlabsMarbleList(true, false)
    })
  }

  build() {
    Column() {
      //顶部区域
      TopComponentView({ imageHeight: StyleConst.PERCENT_30 })
      //内容区域
      this.SlabsListBuild()
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
  }
}