package logic

import (
	"context"
	"login-demo/internal/dao"
	"login-demo/internal/model"
)

// 充电业务

type MarblesNameLogic struct {
}

var MarblesName MarblesNameLogic

func (*MarblesNameLogic) MarblesNameList(ctx context.Context, query model.PageReq) (chargeOrders []model.MarblesNameResult, count int, err error) {
	err = dao.MarblesName.Ctx(ctx).Page(query.PageNo, query.PageSize).OrderAsc("id").ScanAndCount(&chargeOrders, &count, false)
	return
}
