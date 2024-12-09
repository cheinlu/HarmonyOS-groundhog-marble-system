//引入二次封装的axios
import request from "@/utils/request";
//数据类型
import type {marbleList,marbleAddOrUpdate} from './type'

enum API {
    //获取列表的数据 http://127.0.0.1:8000/saas-api/marble/list
    STATION_URL = '/saas-api/marble/list?',
    //添加 http://127.0.0.1:8000/saas-api/marble/add
    ADDSTATION_URL = '/saas-api/marble/add',
    //修改 http://127.0.0.1:8000/saas-api/marble/update 
    UPDATESTATION_URL = '/saas-api/marble/update ',
    //删除充电站  http://127.0.0.1:8000/saas-api/marble/del
    DELETESTATION_URL = '/saas-api/marble/del?',
     //上传图片 单张
    UPLOAD_URL = '/saas-api/file/upload',
    //多张图片上传 http://127.0.0.1:8000/saas-api/multi/file/upload
    UPLOAD_MORE_URL = '/saas-api/multi/file/upload'
  }

  //列表的数据接口
export const reqMarbles = (pageNo:number,pageSize:number,name:string,type:string)=>request.get<any,marbleList>(API.STATION_URL+`pageNo=${pageNo}&pageSize=${pageSize}&name=${name}&type=${type}`)
//添加|修改接口
export const reqAddOrUpdateMarbles = (data:marbleAddOrUpdate)=>{
  if(data.id){
    return request.post<any,any>(API.UPDATESTATION_URL,data)
  }else{
    return request.post<any,any>(API.ADDSTATION_URL,data)
  }
}
//删除充电站的接口
export const reqRemoveMarbles = (ids:number)=>request.post(API.DELETESTATION_URL+`ids=${ids}`)
// 上传图片
export const reqUploadMarbles = (file:any) => {
  // 创建了一个新的 FormData 对象，用于构建表单数据,并将file添加到FormData对象中
  const formData = new FormData();
  formData.append('file', file);

  return request.post(API.UPLOAD_URL, formData);
};

// 上传图片
export const reqUpload = (file:any) => {
  // 创建了一个新的 FormData 对象，用于构建表单数据,并将file添加到FormData对象中
  const formData = new FormData();
  formData.append('file', file);

  return request.post(API.UPLOAD_URL, formData);
};

// 上传多张图片
export const reqUploadMore = (files: FileList) => request.post(API.UPLOAD_MORE_URL+`files=${files}`)


