package v2_saas

import (
	"login-demo/internal/model"

	"github.com/gogf/gf/v2/frame/g"
)

type AlertRuleListReq struct {
	g.Meta    `path:"alertRule/list" tags:"告警规则管理" method:"get" summary:"告警规则列表"`
	Id        interface{} `json:"id"`
	TenantId  interface{} `json:"tenant_id"`
	Rulename  interface{} `json:"rulename"`
	Rule      interface{} `json:"rule"`
	RuleType  interface{} `json:"rule_type"`
	IsDeleted interface{} `json:"is_deleted"`
	model.PageReq
}

type AlertRuleListRes struct {
	g.Meta    `mime:"application/json" example:"string"`
	Id        int    `json:"id"`
	TenantId  int    `json:"tenant_id"`
	Rulename  string `json:"rulename"`
	Rule      string `json:"rule"`
	RuleType  string `json:"rule_type"`
	IsDeleted int    `json:"is_deleted"`
}

type AlertRuleAddReq struct {
	g.Meta    `path:"alertRule/add" tags:"告警规则管理" method:"POST" summary:"添加告警规则"`
	TenantId  int    `json:"tenant_id"`
	Rulename  string `json:"rulename"`
	Rule      string `json:"rule"`
	RuleType  string `json:"rule_type"`
	IsDeleted int    `json:"is_deleted"`
}

type AlertRuleAddRes struct {
	g.Meta `mime:"application/json" `
}

type AlertRuleDelReq struct {
	g.Meta `path:"alertRule/delete" tags:"告警规则管理" method:"DELETE" summary:"删除告警规则"`
	Id     int `json:"id"`
}

type AlertRuleDelRes struct {
	g.Meta `mime:"application/json" `
}

type AlertRuleUpdateReq struct {
	g.Meta    `path:"alertRule/update" tags:"告警规则管理" method:"post" summary:"修改告警规则"`
	Id        int    `json:"id"`
	TenantId  int    `json:"tenant_id"`
	Rulename  string `json:"rulename"`
	Rule      string `json:"rule"`
	RuleType  string `json:"rule_type"`
	IsDeleted int    `json:"is_deleted"`
}

type AlertRuleUpdateRes struct {
	g.Meta `mime:"application/json" `
}
