import {
  CommonDataSource,
  copyText,
  requestStoreList,
  StyleConst,
  ThirdApp,
  thirdAppManager,
  toast,
  locationManager
} from "@tbs/common"
import { AddressData, mapListItem, storeInfoData, storeInfoItem } from "../model/MineStoreModel"
import { MapDialogCall } from "./MapDialogCall"
import { OpenLinkOptions, common } from "@kit.AbilityKit"
import { BusinessError } from "@kit.BasicServicesKit"
import { geoLocationManager } from "@kit.LocationKit"
import { call } from "@kit.TelephonyKit"


@Extend(Text)
function contactTextStyle(fontSize: ResourceStr, fontColor: ResourceColor) {
  .fontSize(fontSize)
  .fontColor(fontColor)
}

@Extend(Image)
function contactImageStyle() {
  .width($r('app.float.size_20'))
  .height($r('app.float.size_20'))
  .objectFit(ImageFit.Cover)
}

@Extend(ImageSpan)
function contactImageSpanStyle() {
  .width($r('app.float.size_20'))
  .height($r('app.float.size_20'))
  .margin({ right: $r('app.float.size_10') })
}

@Component
export struct ContactList {
  storeDataSource = new CommonDataSource<storeInfoItem>()
  phones?: string[] = []
  private scroller: Scroller = new Scroller();
  @State destinationLongitude: number = 0
  @State destinationLatitude: number = 0
  @State destinationName: string = ''
  @State mapList: mapListItem[] = []
  locationData: AddressData = {}
  private selectMapDialogController?: CustomDialogController

  aboutToAppear(): void {
    this.getStoreList()
  }

  aboutToDisappear(): void {
    this.selectMapDialogController?.close()
    this.selectMapDialogController = undefined
  }

  getStoreList() {
    requestStoreList().then((data: storeInfoData | undefined) => {
      if (data && data.code == 0 && data.data?.store_infos && data.data?.store_infos.length > 0) {
        data.data?.store_infos.map(item => {
          const phoneStr = item.phone ?? '';
          this.phones = phoneStr.split('/').filter(p => p.trim());
        })
        this.storeDataSource.pushData(data.data?.store_infos)
      }
    })
  }

  handleCheckInstallation(model: storeInfoItem) {
    this.isAppInstalled(model)
    if (this.mapList.length === 0) {
      toast($r('app.string.visit_store_install_maps_first'))
    } else {
      this.permissionRequest()
    }
  }

  isAppInstalled(model: storeInfoItem) {
    const mapList = [ThirdApp.Amapuri, ThirdApp.Baidumap, ThirdApp.Maps].map((key: ThirdApp) => {
      let name: Length = ''
      let link: string = ""
      switch (key) {
        case ThirdApp.Amapuri:
          link =
            `amapuri://route/plan?dlat=${model.latitude}&dname=${model.name}&slat=${this.locationData.latitude}&dlon=${model.longitude}&slon=${this.locationData.longitude}&sname=我的位置&t=0&sourceApplication=com.huawei.hmos.maps.app`
          name = $r('app.string.visit_store_map')
          break
        case ThirdApp.Baidumap:
          name = $r('app.string.visit_store_baidu_map')
          link =
            `baidumap://map/direction?destination=latlng:${model.latitude},${model.longitude}|name:${model.name}&mode=driving`
          break
        case ThirdApp.Maps:
          name = $r('app.string.visit_store_petal_map')
          link =
            `https://www.petalmaps.com/routes/?daddr=${model.latitude},${model.longitude}(${model.name})&coordinateType=0&type=drive&utm_source=com.huawei.hmos.maps.app`
          break
        default:
          name = ""
      }
      return {
        name,
        link,
        isAppInstall: thirdAppManager.isAppInstall(key)
      } as mapListItem
    })
    this.mapList = mapList.filter(ele => ele.isAppInstall)
  }

  async permissionRequest() {
    try {
      let isGranted = await locationManager.checkAndApplyPermissions(getContext(this))
      if (!isGranted) {
        isGranted = await locationManager.requestPermissionAgain()
      }

      if (isGranted) {
        this.selectMapDialogController = new CustomDialogController({
          builder: MapDialogCall({
            title: '请选择地图',
            titleFontSize: $r('app.float.size_13'),
            titleTextColor: '#acb1b6',
            mapList: this.mapList,
            propBackgroundColor: Color.Transparent,
            propBorderRadius: $r('app.float.size_8'),
            propHeight: $r('app.float.size_50'),
            propSpace: 0,
            titleHeight: $r('app.float.size_42'),
            propContentPadding: {
              top: $r('app.float.size_12'),
              bottom: 0
            },
            propPadding: {
              left: $r('app.float.size_12'),
              right: $r('app.float.size_12'),
              bottom: $r('app.float.size_31'),
            },
            onClickCallBack: (item) => {
              this.handleStartNavigation(item)
            }
          }),
          customStyle: true,
          autoCancel: true,
          alignment: DialogAlignment.Bottom,
          keyboardAvoidMode: KeyboardAvoidMode.NONE
        })
        this.selectMapDialogController.open()
        const request: geoLocationManager.SingleLocationRequest = {
          locatingPriority: geoLocationManager.LocatingPriority.PRIORITY_LOCATING_SPEED,
          locatingTimeoutMs: 10000
        };
        await geoLocationManager.getCurrentLocation(request).then((location) => {
          // 获取到的经纬度
          this.locationData.latitude = location.latitude;
          this.locationData.longitude = location.longitude;
        }).catch((err: object) => {
          console.error("lucy== 获取位置失败:", JSON.stringify(err));
        });

      }
    } catch (e) {
      console.log('lucy== Address request location Permission fail' + e.message)
    }
  }

  handleStartNavigation(item: mapListItem) {
    this.selectMapDialogController?.close()
    this.jumpToMapApp(item.link)
  }

  jumpToMapApp(link: string) {
    try {
      const openLinkOptions: OpenLinkOptions = {
        appLinkingOnly: false
      };
      const context = getContext(this) as common.UIAbilityContext
      context.openLink(link, openLinkOptions)
        .then(() => {
          console.log('open link success.');
        }).catch((err: BusinessError) => {
        console.log(`open link failed. Code is ${err.code}, message is ${err.message}`);
      });
    } catch (paramError) {
      console.log(`Failed to start link. Code is ${paramError.code}, message is ${paramError.message}`);
    }
  }

  // 拨打电话
  call(phoneNumber: string) {
    call.makeCall(phoneNumber, (err: BusinessError) => {
      if (err) {
        console.error('lucy== err',err)
      }
    })
  }

  @Builder
  MineContactItem(model: storeInfoItem) {
    Column() {
      Text(model.name)
        .contactTextStyle($r('app.float.size_text_20'), $r('app.color.color_c84921'))
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: $r('app.float.size_10') })
      Row() {
        Text() {
          ImageSpan($r("app.media.address"))
            .contactImageSpanStyle()
          Span(model.address)
            .onClick(() => {
              this.handleCheckInstallation(model)
            })
        }
        .contactTextStyle($r('app.float.size_text_16'), $r('app.color.color_737373'))

        Image($r('app.media.right_arrow'))
          .contactImageStyle()
      }
      .width(StyleConst.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: $r('app.float.size_15') })

      Row() {
        Row() {
          Image($r("app.media.phone"))
            .width($r('app.float.size_20'))
            .height($r('app.float.size_20'))
            .margin({ right: $r('app.float.size_10') })
          ForEach(this.phones, (item: string) => {
            Text(item)
              .contactTextStyle($r('app.float.size_text_16'), $r('app.color.color_737373'))
              .margin({right:$r('app.float.size_25')})
              .onClick(()=>{
                this.call(item)
              })
          })
        }
        Image($r('app.media.right_arrow'))
          .contactImageStyle()
      }
      .width(StyleConst.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width(StyleConst.FULL_WIDTH)
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    List({ space: 10, scroller: this.scroller }) {
      LazyForEach(this.storeDataSource, (model: storeInfoItem) => {
        ListItem() {
          this.MineContactItem(model)
        }
        .width(StyleConst.FULL_WIDTH)
        .padding($r('app.float.size_15'))
        .backgroundColor($r('app.color.color_f9f9f9'))
        .borderRadius($r('app.float.size_10'))
        .shadow({
          radius: $r('app.float.size_12'),
          color: $r('app.color.color_1A000000'),
          offsetX: 0,
          offsetY: $r('app.float.size_4')
        })
      })
    }
    .width(StyleConst.FULL_WIDTH)
    .height(StyleConst.PERCENT_60)
    .padding($r('app.float.size_10'))
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
    .listDirection(Axis.Vertical)
    .backgroundColor($r('app.color.color_fff'))
  }
}

