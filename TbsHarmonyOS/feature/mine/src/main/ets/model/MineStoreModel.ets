export class storeInfoData {
  data?: storeInfos
  code?: number
  message?: string
}

export class storeInfos {
  store_infos?: storeInfoItem[]
}

export class storeInfoItem {
  name?: string //店名
  address?: string //地址
  phone?: string //电话
  latitude?: number
  longitude?: number
}

export class mapListItem {
  name: ResourceStr = ''
  link: string = ''
  isAppInstall: boolean = false
}

export class AddressData {
  latitude?: number = 0.0;
  longitude?: number = 0.0;
}