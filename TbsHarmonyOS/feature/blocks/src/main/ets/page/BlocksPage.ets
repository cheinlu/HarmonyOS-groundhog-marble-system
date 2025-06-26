import { CommonDataSource, requestMarbleList, requestMarblePassword, ScreenUtils, StyleConst } from "@tbs/common";
import { blocksInfoData, blocksList, passwordData } from "../model/BlocksModel";

@Component
export struct BlocksPage {
  blocksInfos: NavPathStack = new NavPathStack() //路由栈
  pageNo: number = 1
  pageSize: number = 1000
  blocksDataSource = new CommonDataSource<blocksList>()
  private scroller: Scroller = new Scroller();
  password: string = '888888'
  @State valueChange: string = ''
  @State isShowBlock: boolean = false

  aboutToAppear(): void {
    this.getMarblePassword()
    this.getBlocksMarbleList()
  }

  getMarblePassword() {
    requestMarblePassword().then((data: passwordData) => {
      console.log('lucy== data', JSON.stringify(data))
      if (data.code == 0 && data.data && data.data.password) {
        this.password = data.data.password
      }
    })
  }

  getBlocksMarbleList() {
    requestMarbleList(this.pageNo, this.pageSize).then((data: blocksInfoData) => {
      if (data.code == 0 && data.data) {
        if (data.data.TotalCount && data.data.TotalCount > 0 && data.data.List) {
          this.blocksDataSource.pushData(data.data.List)
        }
      }
    })
  }

  @Builder
  LoginCardBuild() {
    Column() {
      Blank().height(ScreenUtils.getInstance().getStatusBarHeight())
      // 密码输入框
      TextInput({ placeholder: '请输入密码', text: this.password })
        .type(InputType.Password)// 设置为密码输入框
        .width(StyleConst.FULL_WIDTH)
        .height($r('app.float.size_40'))
        .padding({ left: $r('app.float.size_40') })
        .fontSize($r('app.float.size_text_14'))
        .backgroundColor($r('app.color.color_f9f9f9'))
        .borderRadius($r('app.float.size_4'))
        .border({ width: $r('app.float.size_1'), color: '#ccc' })
        .onChange((value: string) => {
          this.valueChange = value; // 更新密码输入框的值
        })

      // 登录按钮
      Button('登入')
        .width(StyleConst.FULL_WIDTH)
        .height($r('app.float.size_35'))
        .fontSize($r('app.float.size_15'))
        .backgroundColor('#c84921')
        .fontColor(Color.White)
        .borderRadius($r('app.float.size_4'))
        .margin({ top: $r('app.float.size_20') })
        .shadow({
          radius: $r('app.float.size_10'),
          color: '#0000001A',
          offsetX: 0,
          offsetY: $r('app.float.size_4')
        })
        .onClick(() => {
          if (this.valueChange == this.password) {
            this.isShowBlock = true
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
      color: '#0000001A',
      offsetX: 0,
      offsetY: $r('app.float.size_4')
    })
    .visibility(!this.isShowBlock ? Visibility.Visible : Visibility.None)
  }

  @Builder
  BlocksBuild() {
    Column() {
      Image($r('app.media.furniture_topimg'))
        .width(StyleConst.FULL_WIDTH)
        .height(StyleConst.PERCENT_30)
        .objectFit(ImageFit.Cover)
      List({ space: 10, scroller: this.scroller }) {
        LazyForEach(this.blocksDataSource, (model: blocksList) => {
          ListItem() {
            Row() {
              Text(model.name)
                .textAlign(TextAlign.Center)
                .fontSize($r('app.float.size_25'))
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
            this.blocksInfos.pushPath({ name: 'BlocksSearch', param: model })
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
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.FULL_HEIGHT)
    .visibility(this.isShowBlock ? Visibility.Visible : Visibility.None)
  }

  build() {
    Navigation(this.blocksInfos) {
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
}
