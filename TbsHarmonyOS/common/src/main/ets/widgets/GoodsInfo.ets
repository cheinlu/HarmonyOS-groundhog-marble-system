import { CommonFormPageType } from "."
import { StyleConst } from "../common"
import { commonObj, layers, marblesObj, slices } from "../model"

@Extend(Text)
function textStyles(fontSize: Resource = $r('app.float.size_text_15'), fontColor: ResourceColor = Color.Black) {
  .fontSize(fontSize)
  .fontColor(fontColor)
}

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
            .textStyles($r('app.float.size_text_12'), $r('app.color.color_fff'))
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
          .textStyles($r('app.float.size_text_18'), $r('app.color.color_262626'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
        Text(`${this.goodsModel.layers?.length}匝/${this.goodsModel.slices_total}片/${this.goodsModel.area}㎡`)
          .textStyles($r('app.color.color_cf4444'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
          .height($r('app.float.size_35'))
      } else if (this.formPageType == CommonFormPageType.SLABS_DETAIL) {
        Text(`${this.slabsDetailModel.width}x${this.slabsDetailModel.height}x${this.slabsDetailModel.length}mm`)
          .textStyles($r('app.float.size_text_14'), $r('app.color.color_a0a0a0'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
        Row() {
          Text(`${this.slabsDetailModel.slices?.length}片`)
            .textStyles($r('app.color.color_cf4444'))

          Text(`${this.slabsDetailModel.area}㎡`)
            .textStyles($r('app.color.color_cf4444'))
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(StyleConst.FULL_WIDTH)
        .padding({ left: $r('app.float.size_10'), right: $r('app.float.size_10') })
      } else if (this.formPageType == CommonFormPageType.SLABS_SIZE) {
        Text(`${this.slabsSizeModel.width} x ${this.slabsSizeModel.height} x ${this.slabsSizeModel.length}mm`)
          .textStyles($r('app.color.color_a0a0a0'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
        Text(`${this.slabsSizeModel.area}㎡`)
          .textStyles($r('app.color.color_cf4444'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
      } else if (this.formPageType == CommonFormPageType.BLOCKS_SEARCH) {
        Text(this.blocksModel.name)
          .textStyles($r('app.float.size_text_18'))
          .fontSize($r('app.float.size_text_18'))
          .width(StyleConst.FULL_WIDTH)
          .padding({ left: $r('app.float.size_10') })
        Text(`${this.blocksModel.width}mm x ${this.blocksModel.height}mm x ${this.blocksModel.length}mm x ${this.blocksModel.area}t x ${this.blocksModel.mass}m³`)
          .textStyles($r('app.color.color_cf4444'))
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