package controller_wx

import (
	"context"
	v2 "login-demo/api/wx"
	"login-demo/internal/logic"
	"login-demo/internal/model"
)

type WxMarblesNameController struct {
}

// 获取大理石名称列表
func (c WxMarblesNameController) MarblesNameList(ctx context.Context, req *v2.WXMarblesNameListReq) (pageRes model.PageRes, err error) {
	// 初始化分页参数
	model.InitPageReq(&req.PageReq, 1, 1000)
	// 查询大理石名称列表
	marblesNames, count, err := logic.MarblesName.MarblesNameList(ctx, req.PageReq)
	res := make([]v2.WXMarblesNameListRes, len(marblesNames))
	for i, v := range marblesNames {
		res[i] = v2.WXMarblesNameListRes{
			Id:         v.Id,
			Name:       v.Name,
			PictureUrl: v.PictureUrl,
		}
	}
	pageRes.List, pageRes.PageNo, pageRes.PageSize, pageRes.TotalCount = res, req.PageNo, req.PageSize, count
	return
}
