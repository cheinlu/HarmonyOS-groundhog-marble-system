import {
  CommonDataSource,
  ScreenUtils,
  requestCommonList,
  StyleConst,
  StorageConst,
  CommonInterfaceType,
  LoadingView,
  LoadMoreFooterView,
  toast,
  EmptyDataView,
  handleRefreshLoadMore,
  TopComponentView
} from "@tbs/common"
import { furnitureObj, furnitureData, categoryList, CategoryLevelModel } from "../model/FurnitureModel"
import '../view/FurnitureDetail'
import { router } from "@kit.ArkUI"
import {
  pullRefreshLoadMoreModel,
  pullRefreshResponse
} from "@tbs/common/src/main/ets/widgets/pullRefresh/model/pullRefreshModel"

@Extend(Image)
function imageStyles(width: ResourceStr | string, height: ResourceStr | string) {
  .width(width)
  .height(height)
  .objectFit(ImageFit.Cover)
}

@Extend(Text)
function textStyles(fontSize: Resource, fontColor: ResourceColor = Color.Black) {
  .fontSize(fontSize)
  .fontColor(fontColor)
}

//家居
@Component
export struct FurniturePage {
  @State state: pullRefreshLoadMoreModel<furnitureObj> = {
    dataSource: new CommonDataSource<furnitureObj>(),
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
  controller: SearchController = new SearchController()
  private scroll: Scroller = new Scroller()
  @State categoryIndex: number = 0
  @State sn: string = ''
  private scroller = new ListScroller()
  @StorageProp(StorageConst.SCREEN_WIDTH_VP) screenWidth: number =
    ScreenUtils.getInstance().getScreenWidthVp()
  searchTimer: number | null = null

  aboutToAppear(): void {
    this.getFurnitureList(true, true)
  }

  aboutToDisappear(): void {
    // 组件销毁时清理定时器
    if (this.searchTimer !== null) {
      clearTimeout(this.searchTimer);
      this.searchTimer = null;
    }
  }

  getFurnitureList(isRefresh: boolean = true, isShowLoading: boolean = true): Promise<void> {
    return handleRefreshLoadMore<furnitureObj>(
      (pageNo, pageSize, searchKey, type, sn) =>
      requestCommonList(pageNo, pageSize, searchKey, type, sn) as Promise<pullRefreshResponse<furnitureObj>>,
      this.state,
      isRefresh,
      isShowLoading,
      this.kv,  // 传递 searchKey
      CommonInterfaceType.SHOPPING,  // 传递 type
      this.sn   // 传递 sn
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
        this.getFurnitureList(true, true)
        this.searchTimer = null;
      }, delay);
    } else {
      // 没有延迟，立即执行
      this.kv = value.trim();
      this.state.pageNo = 1;
      this.getFurnitureList(true, true)
    }
  }

  // 顶部搜索
  @Builder
  SearchViewBuilder() {
    TopComponentView({
      imageHeight: StyleConst.FULL_HEIGHT,
      topBuildHeight: StyleConst.PERCENT_30,
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
      .id('first_top')
      .alignRules({
        top: { anchor: "__container__", align: VerticalAlign.Top }
      })
  }

  //左侧分类
  @Builder
  LeftLevelBuilder() {
    Column() {
      List({ scroller: this.scroll }) {
        ForEach(categoryList, (item: CategoryLevelModel, index: number) => {
          ListItem() {
            Row() {
              Blank()
                .width($r("app.float.size_4"))
                .height($r("app.float.size_48"))
                .backgroundColor(this.categoryIndex == index ? $r("app.color.color_c84921") :
                $r("app.color.color_f6f6f6"))
              Column() {
                Text(item.title)
                  .textStyles($r("app.float.size_text_16"))
                  .textAlign(TextAlign.Center)
                  .height(StyleConst.FULL_HEIGHT)
                  .layoutWeight(1)
                  .maxLines(2)
                  .margin({
                    left: $r("app.float.size_5"),
                    right: $r("app.float.size_5")
                  })
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                Text(item.titleEn)
                  .textStyles($r("app.float.size_text_16"))
                  .textAlign(TextAlign.Center)
                  .height(StyleConst.FULL_HEIGHT)
                  .layoutWeight(1)
                  .maxLines(2)
                  .margin({
                    left: $r("app.float.size_5"),
                    right: $r("app.float.size_5")
                  })
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width(StyleConst.FULL_WIDTH)
              .justifyContent(FlexAlign.Center)
            }
            .width(StyleConst.FULL_WIDTH)
            .height($r("app.float.size_65"))
            .backgroundColor(this.categoryIndex == index ? $r("app.color.color_fff") : $r("app.color.color_f0f2f4"))
            .onClick(() => {
              if (this.categoryIndex != index) {
                this.categoryIndex = index
              }
              if (item.title) {
                if (item.title == '全部') {
                  this.sn = ''
                } else {
                  this.sn = item.title
                }
              }
              this.getFurnitureList(true,true)
              this.state.dataSource.changeItem(index)
            })
          }
        })
      }
    }
    .width($r("app.float.size_110"))
    .height(StyleConst.FULL_HEIGHT)
    .backgroundColor($r("app.color.color_f6f6f6"))
    .alignRules({
      top: { anchor: "first_top", align: VerticalAlign.Bottom }
    })
    .id("second_left")
  }

  priceOrDescription(model: furnitureObj) {
    if (model.price) {
      return model.price > 0 ? `￥${model.price}` : ''
    } else {
      return ''
    }
  }

  //右侧商品
  @Builder
  RightGoodsViewBuilder() {
    Stack() {
      if (this.state.isLoading) {
        LoadingView({ buildHeight: StyleConst.PERCENT_70 })
      } else {
        this.RightGoodsView()
      }
    }
    .id("goods_list")
    .alignRules({
      top: { anchor: "first_top", align: VerticalAlign.Bottom },
      left: { anchor: "second_left", align: HorizontalAlign.End },
      right: { anchor: "__container__", align: HorizontalAlign.End }
    })
    .width(this.screenWidth - 110)
  }

  //右侧商品列表
  @Builder
  RightGoodsView() {
    Refresh({ refreshing: $$this.state.isRefreshing }) {
      if (this.state.dataSource.totalCount() > 0) {
        WaterFlow({ footer: this.getFooter(), scroller: this.scroller }) {
          LazyForEach(this.state.dataSource, (model: furnitureObj) => {
            FlowItem() {
              this.GoodsItemView(model)
            }
            .width(StyleConst.FULL_WIDTH)
          }, (item: furnitureObj, index: number) => {
            return item.id?.toString() + index.toString()
          })
        }
        .onReachEnd(() => {
          if (this.state.hasMore) {
            this.state.pageNo++; // 页码自增
            this.getFurnitureList(false, false); // 加载下一页
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
        .width(this.screenWidth - 110)
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
      this.getFurnitureList(true, false)
    })
  }

  //滑动到底部文描
  @Builder
  getFooter() {
    LoadMoreFooterView({ isBottomLoading: this.state.isBottomLoading })
  }

  //右侧商品item
  @Builder
  GoodsItemView(model: furnitureObj) {
    Column({ space: 10 }) {
      Image(model.pictureUrls)
        .alt($r('app.media.default_img'))
        .imageStyles(StyleConst.FULL_WIDTH, $r('app.float.size_130'))
        .borderRadius($r('app.float.size_6'))
      Text(model.name)
        .textStyles($r("app.float.size_text_16"), $r('app.color.color_262626'))
        .width(StyleConst.FULL_WIDTH)
        .padding({ left: $r('app.float.size_10') })
      Text() {
        Span(model.description || '')
        Span(`${this.priceOrDescription(model)}`)
      }
      .textStyles($r('app.float.size_text_13'), $r('app.color.color_a0a0a0'))
      .height($r('app.float.size_30'))
      .width(StyleConst.FULL_WIDTH)
      .padding({ left: $r('app.float.size_10') })

      Text('详情')
        .textStyles($r('app.float.size_text_15'), $r('app.color.color_616161'))
        .borderWidth($r('app.float.size_1'))
        .borderColor($r('app.color.color_e3e4e7'))
        .borderRadius($r('app.float.size_4'))
        .padding({
          top: $r('app.float.size_2'),
          bottom: $r('app.float.size_2'),
          left: $r('app.float.size_4'),
          right: $r('app.float.size_4')
        })
        .margin({ left: $r('app.float.size_10') })
    }
    .alignItems(HorizontalAlign.Start)
    .padding({ bottom: $r('app.float.size_15') })
    .width(StyleConst.FULL_WIDTH)
    .borderRadius($r('app.float.size_6'))
    .backgroundColor($r('app.color.color_f6f6f6'))
    .onClick(() => {
      router.pushNamedRoute({
        name: 'FurnitureDetail',
        params: model
      })
    })
  }

  build() {
    RelativeContainer() {
      this.SearchViewBuilder() // 顶部搜索

      this.LeftLevelBuilder() //左侧分类

      this.RightGoodsViewBuilder() //右侧商品
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
  }
}