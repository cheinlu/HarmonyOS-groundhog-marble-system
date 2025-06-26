import { CommonFormPageType } from "."
import { StyleConst } from "../common"
import { commonObj, layers, marblesObj, slices } from "../model"

@Component
export struct GoodsInfo {
  @Prop goodsModel: marblesObj
  @Prop slabsDetailModel: layers
  @Prop slabsSizeModel: slices
  @Prop blocksModel: commonObj
  @Prop formPageType: number = CommonFormPageType.SLABS_SEARCH
  clickCallBack: () => void = () => {
  }

  build() {
    Column({ space: 15 }) {
      Stack({ alignContent: Alignment.Bottom }) {
        Image(this.goodsBgImg())
          .width(StyleConst.FULL_WIDTH)
          .height($r('app.float.size_130'))

        Row() {
          Text(this.goodsText())
            .fontSize(12)
            .fontColor($r('app.color.color_fff'))
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Clip })
        }
        .justifyContent(FlexAlign.Center)
        .width(StyleConst.FULL_WIDTH)
        .height($r('app.float.size_30'))
        .borderRadius({
          topLeft: $r('app.float.size_15'),
          topRight: $r('app.float.size_15')
        })
        .backgroundColor($r('app.color.color_8a8884'))
      }

      if (this.formPageType == CommonFormPageType.SLABS_SEARCH) {
        Text(this.goodsModel.name)
          .fontSize($r('app.float.size_text_18'))
          .fontColor($r('app.color.color_262626'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
        Text(`${this.goodsModel.layers?.length}匝/${this.goodsModel.slices_total}片/${this.goodsModel.area}㎡`)
          .fontSize($r('app.float.size_text_15'))
          .fontColor($r('app.color.color_cf4444'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
          .height($r('app.float.size_35'))
      } else if (this.formPageType == CommonFormPageType.SLABS_DETAIL) {
        Text(`${this.slabsDetailModel.width}x${this.slabsDetailModel.height}x${this.slabsDetailModel.length}mm`)
          .fontSize($r('app.float.size_text_14'))
          .fontColor($r('app.color.color_a0a0a0'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
        Row() {
          Text(`${this.slabsDetailModel.slices?.length}片`)
            .fontSize($r('app.float.size_text_15'))
            .fontColor($r('app.color.color_cf4444'))

          Text(`${this.slabsDetailModel.area}㎡`)
            .fontSize($r('app.float.size_text_15'))
            .fontColor($r('app.color.color_cf4444'))
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(StyleConst.FULL_WIDTH)
        .padding({ left: $r('app.float.size_10'), right: $r('app.float.size_10') })
      } else if (this.formPageType == CommonFormPageType.SLABS_SIZE) {
        Text(`${this.slabsSizeModel.width} x ${this.slabsSizeModel.height} x ${this.slabsSizeModel.length}mm`)
          .fontSize($r('app.float.size_text_15'))
          .fontColor($r('app.color.color_a0a0a0'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
        Text(`${this.slabsSizeModel.area}㎡`)
          .fontSize($r('app.float.size_text_15'))
          .width(StyleConst.FULL_WIDTH)
          .fontColor($r('app.color.color_cf4444'))
          .padding({ left: $r('app.float.size_10') })
      } else if (this.formPageType == CommonFormPageType.BLOCKS_SEARCH) {
        Text(this.blocksModel.name)
          .fontSize($r('app.float.size_text_18'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
        Text(`${this.blocksModel.width}mm x ${this.blocksModel.height}mm x ${this.blocksModel.length}mm x ${this.blocksModel.area}t x ${this.blocksModel.mass}m³`)
          .fontSize($r('app.float.size_text_15'))
          .fontColor($r('app.color.color_cf4444'))
          .width(StyleConst.FULL_WIDTH)
          .height($r('app.float.size_55'))
          .padding({ left: $r('app.float.size_10') })
      }
    }
    .padding({ bottom: $r('app.float.size_15') })
    .width(StyleConst.FULL_WIDTH)
    .backgroundColor('#f4f4f4')
    .borderRadius($r('app.float.size_12'))
    .onClick(() => {
      this.clickCallBack()
    })
  }

  goodsBgImg() {
    switch (this.formPageType) {
      case CommonFormPageType.SLABS_SEARCH:
        return this.goodsModel.pictureUrls;
      case CommonFormPageType.SLABS_DETAIL:
        return this.slabsDetailModel.pictureUrls
      case CommonFormPageType.SLABS_SIZE:
        return this.slabsSizeModel.pictureUrls
      case CommonFormPageType.BLOCKS_SEARCH:
        return this.blocksModel.pictureUrls
      default:
        return ''
    }
  }

  goodsText() {
    switch (this.formPageType) {
      case CommonFormPageType.SLABS_SEARCH:
        return this.goodsModel.sn;
      case CommonFormPageType.SLABS_DETAIL:
        return this.slabsDetailModel.sn;
      case CommonFormPageType.SLABS_SIZE:
        return this.slabsSizeModel.sn;
      case CommonFormPageType.BLOCKS_SEARCH:
        return this.blocksModel.sn;
      default:
        return ''
    }
  }
}