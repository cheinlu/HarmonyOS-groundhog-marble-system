import { marblesObj } from "@tbs/common"

export class slabsInfoData{
  data?:slabsBean
  code?:number
  message?:string
}

export class slabsBean{
  PageNo?:number
  PageSize?:number
  TotalCount?:number
  List?:slabsList[]
}

export class slabsList{
  id?:number
  name?:string
  pictureUrl?:string
}

export class slabsMarblesData{
  data?:marblesBean
  code?:number
  message?:string
}

export class marblesBean{
  PageNo?:number
  PageSize?:number
  TotalCount?:number
  List?:marblesObj[]
}

