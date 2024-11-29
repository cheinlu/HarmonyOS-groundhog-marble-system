package logic

import (
	"context"
	"login-demo/internal/dao"
	"login-demo/internal/model"
	"login-demo/internal/model/do"
	"login-demo/internal/model/entity"

	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/os/gtime"
)

var AlertRule AlertRuleLogic

type AlertRuleLogic struct {
}

func (*AlertRuleLogic) AlertRuleList(ctx context.Context, query do.AlertRule, page model.PageReq) (alertRules []entity.AlertRule, count int, err error) {
	model := dao.AlertRule.Ctx(ctx)
	if query.Id != nil {
		model = model.Where("alert_rule.id = ?", query.Id)
	}
	if query.TenantId != nil {
		model = model.Where("alert_rule.tenantId = ?", query.TenantId)
	}
	if query.Rulename != nil {
		model = model.Where("alert_rule.rulename = ?", query.Rulename)
	}
	if query.Rule != nil {
		model = model.Where("alert_rule.rule = ?", query.Rule)
	}
	if query.RuleType != nil {
		model = model.Where("alert_rule.ruleType = ?", query.RuleType)
	}
	if query.IsDeleted != nil {
		model = model.Where("alert_rule.isDeleted = ?", query.IsDeleted)
	}
	model.Fields("alert_rule.*").OrderDesc("alert_rule.update_at").Page(page.PageNo, page.PageSize).ScanAndCount(&alertRules, &count, false)
	return
}

func (*AlertRuleLogic) Add(ctx context.Context, alertRule do.AlertRule) (err error) {
	alertRule.CreateAt, alertRule.UpdateAt = gtime.Now(), gtime.Now()
	err = SetCurrentTenantId(ctx, &alertRule.TenantId)
	if err != nil {
		return
	}
	_, err = dao.AlertRule.Ctx(ctx).Insert(alertRule)
	return
}

func (*AlertRuleLogic) Del(ctx context.Context, id int) (err error) {
	rs, err := dao.AlertRule.Ctx(ctx).Delete("id = ?", id)
	if err != nil {
		return gerror.WrapCode(gcode.New(1, "系统异常，删除失败", ""), err)
	}
	rowsAffected, err := rs.RowsAffected()
	if err != nil {
		return gerror.WrapCode(gcode.New(1, "系统异常，删除失败", ""), err)
	}
	if rowsAffected == 0 {
		err = gerror.NewCode(gcode.New(1, "删除失败，未找到原数据，可能已被其他人删除", ""))
		return err
	}
	return
}

func (*AlertRuleLogic) Update(ctx context.Context, alertRule do.AlertRule) (err error) {
	alertRule.UpdateAt = gtime.Now()
	rs, err := dao.AlertRule.Ctx(ctx).Update(alertRule, "id = ?", alertRule.Id)
	if err != nil {
		return gerror.WrapCode(gcode.New(1, "系统异常，修改失败", ""), err)
	}
	rowsAffected, err := rs.RowsAffected()
	if err != nil {
		return gerror.WrapCode(gcode.New(1, "系统异常，修改失败", ""), err)
	}
	if rowsAffected == 0 {
		err = gerror.NewCode(gcode.New(1, "修改失败，未找到原数据，可能已被其他人删除", ""))
		return err
	}
	return
}
