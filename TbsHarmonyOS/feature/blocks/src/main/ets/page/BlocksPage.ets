import {
  CommonDataSource,
  EmptyDataView,
  handleRefreshLoadMore,
  LoadingView,
  LoadMoreFooterView,
  requestMarbleList,
  requestMarblePassword,
  ScreenUtils,
  StyleConst,
  toast,
  TopComponentView
} from "@tbs/common";
import { blocksInfoData, blocksList, passwordData } from "../model/BlocksModel";
import '../view/BlocksSearch'
import { router } from "@kit.ArkUI";
import {
  pullRefreshLoadMoreModel,
  pullRefreshResponse
} from "@tbs/common/src/main/ets/widgets/pullRefresh/model/pullRefreshModel";

@Extend(Image)
function imageStyles(width: ResourceStr | string, height: ResourceStr | string) {
  .width(width)
  .height(height)
  .objectFit(ImageFit.Cover)
}

@Component
export struct BlocksPage {
  @State state: pullRefreshLoadMoreModel<blocksList> = {
    dataSource: new CommonDataSource<blocksList>(),
    hasMore: true,
    isBottomLoading: false,
    isLoading: false,
    totalCount: 0,
    isRefreshing: false,
    pageNo: 1,
    pageSize: 10
  }
  private scroller: Scroller = new Scroller();
  password: string = ''
  @State valueChange: string = ''
  @State isShowBlock: boolean = false

  aboutToAppear(): void {
    this.getMarblePassword()
    this.getBlocksMarbleList(true, true)
  }

  getMarblePassword() {
    requestMarblePassword().then((data: passwordData) => {
      if (data.code == 0 && data.data && data.data.password) {
        this.password = data.data.password
      } else {
        this.password = ''
        console.error('lucy== BlocksPage-接口返回密码错误')
      }
    })
  }

  getBlocksMarbleList(isRefresh: boolean = true, isShowLoading: boolean = true): Promise<void> {
    return handleRefreshLoadMore<blocksList>(
      // 断言 requestMarbleList 的返回类型符合要求
      (pageNo, pageSize) => requestMarbleList(pageNo, pageSize) as Promise<pullRefreshResponse<blocksList>>,
      this.state,
      isRefresh,
      isShowLoading
    );
  }

  @Builder
  LoginCardBuild() {
    Column() {
      Blank().height(ScreenUtils.getInstance().getStatusBarHeight())
      // 密码输入框
      TextInput({ placeholder: '请输入密码', text: this.valueChange })
        .type(InputType.Password)// 设置为密码输入框
        .width(StyleConst.FULL_WIDTH)
        .height($r('app.float.size_40'))
        .padding({ left: $r('app.float.size_40') })
        .fontSize($r('app.float.size_text_14'))
        .backgroundColor($r('app.color.color_f9f9f9'))
        .borderRadius($r('app.float.size_4'))
        .border({ width: $r('app.float.size_1'), color: $r('app.color.color_ccc') })
        .onChange((value: string) => {
          this.valueChange = value; // 更新密码输入框的值
        })

      // 登录按钮
      Button('登入')
        .width(StyleConst.FULL_WIDTH)
        .height($r('app.float.size_35'))
        .fontSize($r('app.float.size_15'))
        .backgroundColor($r('app.color.color_c84921'))
        .fontColor(Color.White)
        .borderRadius($r('app.float.size_4'))
        .margin({ top: $r('app.float.size_20') })
        .shadow({
          radius: $r('app.float.size_10'),
          color: $r('app.color.color_0000001A'),
          offsetX: 0,
          offsetY: $r('app.float.size_4')
        })
        .onClick(() => {
          if (this.valueChange === this.password) {
            this.isShowBlock = true
          } else {
            toast('密码错误，请重新输入')
          }
        })
    }
    .width(StyleConst.FULL_WIDTH)
    .padding($r('app.float.size_20'))
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius($r('app.float.size_8'))
    .shadow({
      radius: $r('app.float.size_10'),
      color: $r('app.color.color_0000001A'),
      offsetX: 0,
      offsetY: $r('app.float.size_4')
    })
    .visibility(!this.isShowBlock ? Visibility.Visible : Visibility.None)
  }

  @Builder
  BlocksBuild() {
    Column() {
      TopComponentView({ imageHeight: StyleConst.PERCENT_30 })
      Stack() {
        if (this.state.isLoading) {
          LoadingView({ buildHeight: StyleConst.PERCENT_70 })
        } else {
          this.BlocksListView()
        }
      }
      .width(StyleConst.FULL_WIDTH)
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .visibility(this.isShowBlock ? Visibility.Visible : Visibility.None)
  }

  @Builder
  BlocksListView() {
    Refresh({ refreshing: $$this.state.isRefreshing }) {
      if (this.state.dataSource.totalCount() > 0) {
        List({ space: 10, scroller: this.scroller }) {
          LazyForEach(this.state.dataSource, (model: blocksList) => {
            ListItem() {
              Row() {
                Text(model.name)
                  .textAlign(TextAlign.Center)
                  .fontSize($r('app.float.size_25'))
                  .width(StyleConst.PERCENT_40)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                Image(model.pictureUrl)
                  .alt($r('app.media.home_bg'))
                  .imageStyles(StyleConst.PERCENT_60, StyleConst.FULL_HEIGHT)
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
                name: 'BlocksSearch',
                params: {
                  searchKey: model.name ?? ''
                }
              })
            })
          }, (model: blocksList) => model.id?.toString())

          ListItem() {
            LoadMoreFooterView({ isBottomLoading: this.state.isBottomLoading })
          }
          .width(StyleConst.FULL_WIDTH);
        }
        .onReachEnd(() => {
          if (this.state.hasMore) {
            this.state.pageNo++; // 页码自增
            this.getBlocksMarbleList(false, false); // 加载下一页
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
      this.getBlocksMarbleList(true, false)
    })
  }

  build() {
    Column() {
      // 登录卡片容器
      this.LoginCardBuild()
      //内容区域
      this.BlocksBuild()
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
  }
}
