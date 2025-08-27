import { toast } from ".."
import { pullRefreshLoadMoreModel, pullRefreshResponse } from "./model/pullRefreshModel"

export async function handleRefreshLoadMore<T>(
  requestFunc: (pageNo: number, pageSize: number, searchKey?: string, type?: string,
    sn?: string) => Promise<pullRefreshResponse<T>>,
  state: pullRefreshLoadMoreModel<T>,
  isRefresh: boolean = true,
  isShowLoading: boolean = true,
  searchKey?: string,
  type?: string,
  sn?: string
): Promise<void> {
  // 更新加载状态
  if (isShowLoading) {
    state.isLoading = true
  }
  if (!isRefresh) {
    state.isBottomLoading = true
  }

  try {
    const data = await requestFunc(state.pageNo, state.pageSize, searchKey, type, sn)
    state.isLoading = false
    state.isRefreshing = false

    if (data.code === 0 && data.data) {
      state.totalCount = data.data.TotalCount ?? 0
      const listData = Array.isArray(data.data.List) ? data.data.List : []

      if (listData.length > 0) {
        if (isRefresh) {
          state.dataSource.resetData(listData)
        } else {
          state.dataSource.pushData(listData)
        }

        state.hasMore = state.dataSource.totalCount() < state.totalCount
        state.isBottomLoading = state.hasMore
      } else {
        // 处理空列表情况
        if (isRefresh) {
          // 如果是刷新操作，清空数据源
          state.dataSource.resetData([])
        }
        // 无论刷新还是加载更多，都没有更多数据了
        state.hasMore = false
        state.isBottomLoading = false

        // 如果是搜索操作且结果为空，提示"暂无搜索结果"
        if (searchKey && searchKey.trim() !== '') {
          // 这是一个搜索操作且有搜索关键词
          toast('暂无搜索结果')
        } else if (isRefresh) {
          // 这是一个刷新操作且没有数据
          toast('暂无数据!!!')
        }
      }
    } else {
      // API返回错误码
      if (isRefresh) {
        // 如果是刷新操作，清空数据源
        state.dataSource.resetData([])
      }
      state.hasMore = false
      state.isBottomLoading = false
      toast('数据加载失败')
    }
  } catch (err) {
    // 错误时重置所有状态
    state.isLoading = false
    state.isRefreshing = false
    state.isBottomLoading = false

    if (isRefresh) {
      // 如果是刷新操作，清空数据源
      state.dataSource.resetData([])
    }
    state.hasMore = false

    toast('网络异常，请稍后重试')
    console.error('接口请求失败', err)
  }
}