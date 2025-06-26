import { CommonDataSource, ScreenUtils, requestCommonList, StyleConst } from "@tbs/common"
import { furnitureObj, furnitureData, categoryList, CategoryLevelModel } from "../model/FurnitureModel"

//家居
@Component
export struct FurniturePage {
  furnitureInfos: NavPathStack = new NavPathStack()
  @State kv: string = ''
  @State changeValue: string = ''
  controller: SearchController = new SearchController()
  private scroll: Scroller = new Scroller()
  @State categoryIndex: number = 0
  @State sn: string = ''
  pageNo: number = 1
  pageSize: number = 1000
  furnitureDataSource = new CommonDataSource<furnitureObj>()
  goodsWidth = ScreenUtils.getInstance().getScreenWidthVp() - 100

  aboutToAppear(): void {
    this.getFurnitureList()
  }

  getFurnitureList() {
    requestCommonList(this.kv, 'shopping', this.pageNo, this.pageSize, this.sn).then((data: furnitureData) => {
      if (data.code == 0 && data.data) {
        if (data.data.TotalCount && data.data.TotalCount > 0 && data.data.List) {
          console.log('lucy== list',JSON.stringify(data.data.List))
          this.furnitureDataSource.resetData(data.data.List)
        }
      }
    })
  }

  build() {
    Navigation(this.furnitureInfos) {
      RelativeContainer() {
        this.SearchViewBuilder() // 顶部搜索

        this.LeftLevelBuilder() //左侧分类

        this.RightGoodsViewBuilder() //右侧商品
      }
      .width(StyleConst.FULL_WIDTH)
      .height(StyleConst.FULL_HEIGHT)
    }
  }

  @Builder
  SearchViewBuilder() {
    Stack({ alignContent: Alignment.Bottom }) {
      Image($r('app.media.furniture_topimg'))
        .width(StyleConst.FULL_WIDTH)
        .height(StyleConst.FULL_HEIGHT)

      Search({ value: this.changeValue, placeholder: '点击快速搜索商品', controller: this.controller })
        .searchButton('搜索')
        .width('95%')
        .height($r('app.float.size_40'))
        .backgroundColor('#F5F5F5')
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: $r('app.float.size_14'), weight: 400 })
        .textFont({ size: $r('app.float.size_14'), weight: 400 })
        .margin({ bottom: $r('app.float.size_20') })
        .onSubmit((value: string) => {
          this.kv = value
          this.getFurnitureList()
        })
    }
    .height(StyleConst.PERCENT_30)
    .id('first_top')
    .alignRules({
      top: { anchor: "__container__", align: VerticalAlign.Top }
    })
  }

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
              Text(item.title)
                .fontSize($r("app.float.size_text_16"))
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
            .height($r("app.float.size_50"))
            .backgroundColor(this.categoryIndex == index ? $r("app.color.color_fff") : $r("app.color.color_f6f6f6"))
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
              this.getFurnitureList()
              this.furnitureDataSource.changeItem(index)
            })
          }
        })
      }
    }
    .width($r("app.float.size_88"))
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

  @Builder
  RightGoodsViewBuilder() {
    Column() {
      WaterFlow() {
        LazyForEach(this.furnitureDataSource, (model: furnitureObj) => {
          FlowItem() {
            this.GoodsItemView(model)
          }
          .width(StyleConst.FULL_WIDTH)
        }, (item: furnitureObj, index: number) => {
          return item.id?.toString() + index.toString()
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
      .width(ScreenUtils.getInstance().getScreenWidthVp() - 90)
      .height(StyleConst.FULL_HEIGHT)
      .margin({ top: $r('app.float.size_12') })
      .layoutWeight(1)

      Blank()
        .height(210)
    }
    .id("goods_list")
    .alignRules({
      top: { anchor: "first_top", align: VerticalAlign.Bottom },
      left: { anchor: "second_left", align: HorizontalAlign.End },
      right: { anchor: "__container__", align: HorizontalAlign.End }
    })
  }

  @Builder
  GoodsItemView(model: furnitureObj) {
    Column({ space: 10 }) {
      Image(model.pictureUrls)
        .width(StyleConst.FULL_WIDTH)
        .height($r('app.float.size_130'))
        .borderRadius($r('app.float.size_6'))
      Text(model.name)
        .fontSize($r('app.float.size_text_16'))
        .fontColor($r('app.color.color_262626'))
        .width(StyleConst.FULL_WIDTH)
        .padding({ left: $r('app.float.size_10') })
      Text() {
        Span(model.description)
        Span(`${this.priceOrDescription(model)}`)
      }
      .height($r('app.float.size_30'))
      .fontSize($r('app.float.size_text_13'))
      .fontColor($r('app.color.color_a0a0a0'))
      .width(StyleConst.FULL_WIDTH)
      .padding({ left: $r('app.float.size_10') })

      Text('详情')
        .fontSize($r('app.float.size_text_15'))
        .fontColor($r('app.color.color_616161'))
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
      this.furnitureInfos.pushPath({ name: 'FurnitureDetail', param: model })
    })
  }
}