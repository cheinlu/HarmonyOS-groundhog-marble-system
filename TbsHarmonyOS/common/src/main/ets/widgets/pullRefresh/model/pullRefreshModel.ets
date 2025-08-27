import { CommonDataSource } from "../../../model";

export interface pullRefreshLoadMoreModel<T> {
  dataSource: CommonDataSource<T>;
  hasMore: boolean;
  isBottomLoading: boolean;
  isLoading: boolean;
  totalCount: number;
  isRefreshing: boolean;
  pageNo: number;
  pageSize: number;
}

export interface pullRefreshResponse<T> {
  code: number
  data: responseData<T>
}

export interface responseData<T> {
  TotalCount: number
  List: T[]
}