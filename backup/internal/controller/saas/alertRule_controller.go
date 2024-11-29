package controller_saas

import (
	"context"
	v2 "login-demo/api/saas"
	"login-demo/internal/logic"
	"login-demo/internal/model"
	"login-demo/internal/model/do"
)

type AlertRuleController struct {
}

// 列表
func (AlertRuleController) List(ctx context.Context, req *v2.AlertRuleListReq) (pageRes model.PageRes, err error) {
	model.InitPageReq(&req.PageReq, 1, 10)
	query := do.AlertRule{
		Id: req.Id,
		TenantId: req.TenantId,
		Rulename: req.Rulename,
		Rule: req.Rule,
		RuleType: req.RuleType,
		IsDeleted: req.IsDeleted,
	}
	alertRules, count, err := logic.AlertRule.AlertRuleList(ctx, query, req.PageReq)
	res := make([]*v2.AlertRuleListRes, len(alertRules))
	for i, alertRule := range alertRules {
		res[i] = &v2.AlertRuleListRes{
			Id:          alertRule.Id,
			TenantId:          alertRule.TenantId,
			Rulename:          alertRule.Rulename,
			Rule:          alertRule.Rule,
			RuleType:          alertRule.RuleType,
			IsDeleted:          alertRule.IsDeleted,
		}
	}
	pageRes.List, pageRes.PageNo, pageRes.PageSize, pageRes.TotalCount = res, req.PageNo, req.PageSize, count
	return
}

// 添加
func (AlertRuleController) Add(ctx context.Context, req *v2.AlertRuleAddReq) (res *v2.AlertRuleAddRes, err error) {
	var alertRule do.AlertRule = do.AlertRule{
		TenantId: req.TenantId,
		Rulename: req.Rulename,
		Rule: req.Rule,
		RuleType: req.RuleType,
		IsDeleted: req.IsDeleted,
	}
	err = logic.AlertRule.Add(ctx, alertRule)
	return
}

// 删除
func (AlertRuleController) Del(ctx context.Context, req *v2.AlertRuleDelReq) (res *v2.AlertRuleDelRes, err error) {
	err = logic.AlertRule.Del(ctx, req.Id)
	return
}

// 修改
func (AlertRuleController) Update(ctx context.Context, req *v2.AlertRuleUpdateReq) (res *v2.AlertRuleUpdateRes, err error) {
	alertRule := do.AlertRule{
			Id:          req.Id,
			TenantId:          req.TenantId,
			Rulename:          req.Rulename,
			Rule:          req.Rule,
			RuleType:          req.RuleType,
			IsDeleted:          req.IsDeleted,
	}
	err = logic.AlertRule.Update(ctx, alertRule)
	return
}
