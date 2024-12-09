export interface ResponseData{
    code :number
    message:string
    }

    //已有的充电站列表数据类型
export interface marble {
    id?: number
    sn: string
    name: string
    type: string
    price: string
    pictureUrls:string
    
  }
  //保存全部充电站列表数据类型
  export type marbles = marble[]

    export interface marbleList extends ResponseData {
        data:{
          List:marbles
          PageNo:number
          PageSize: number
          TotalCount: number
        }
      }
  //添加|修改充电桩参数的类型
export interface marbleAddOrUpdate { 
  type?:string,
  sn: string
  name: string
pictureUrls:string
pictureUrls1?:string
pictureUrls2?:string
pictureUrls3?:string
pictureUrls4?:string
pictureUrls5?:string
  id?:number
  price:number
  width:number
  length:number
  height:number
  area:number
  mass?:number
  description?:string
  remark?:string
}