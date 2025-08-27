import { CommonDataSource } from "../../model";
import { pullRefreshLoadMoreModel } from "./model/pullRefreshModel";

export function pullRefreshLoadMore<T>(pageSize: number = 8):pullRefreshLoadMoreModel<T>{
  return {
    dataSource: new CommonDataSource<T>(), // 数据源初始化
    hasMore: true, // 默认有更多数据
    isBottomLoading: false, // 默认底部未加载
    isLoading: false, // 默认整体未加载
    totalCount: 0, // 默认总条数为0
    isRefreshing: false, // 默认未刷新
    pageNo: 1, // 默认初始页码1
    pageSize: pageSize, // 接收外部传入或默认8
  };
}