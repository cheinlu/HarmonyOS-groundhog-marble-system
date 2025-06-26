import { commonObj } from "@tbs/common"

export class blocksInfoData {
  data?: blocksBean
  code?: number
  message?: string
}

export class blocksBean {
  PageNo?: number
  PageSize?: number
  TotalCount?: number
  List?: blocksList[]
}

export class blocksList {
  id?: number
  name?: string
  pictureUrl?: string
}

export class blocksCommonData {
  data?: commonBean
  code?: number
  message?: string
}

export class commonBean {
  PageNo?: number
  PageSize?: number
  TotalCount?: number
  List?: commonObj[]
}

export class passwordData {
  data?: password
  code?: number
  message?: string
}

export class password {
  password?: string
}

