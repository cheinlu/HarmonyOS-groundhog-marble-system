// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// AlertRule is the golang structure of table alert_rule for DAO operations like Where/Data.
type AlertRule struct {
	g.Meta    `orm:"table:alert_rule, do:true"`
	Id        interface{} //
	TenantId  interface{} //
	Rulename  interface{} //
	Rule      interface{} //
	RuleType  interface{} //
	IsDeleted interface{} //
	CreateAt  *gtime.Time //
	UpdateAt  *gtime.Time //
}
