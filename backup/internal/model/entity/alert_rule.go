// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// AlertRule is the golang structure for table alert_rule.
type AlertRule struct {
	Id        int         `json:"id"        ` //
	TenantId  int         `json:"tenantId"  ` //
	Rulename  string      `json:"rulename"  ` //
	Rule      string      `json:"rule"      ` //
	RuleType  string      `json:"ruleType"  ` //
	IsDeleted int         `json:"isDeleted" ` //
	CreateAt  *gtime.Time `json:"createAt"  ` //
	UpdateAt  *gtime.Time `json:"updateAt"  ` //
}
