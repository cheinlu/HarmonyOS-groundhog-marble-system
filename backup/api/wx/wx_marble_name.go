package v2_wx

import (
	"login-demo/internal/model"

	"github.com/gogf/gf/v2/frame/g"
)

// 小程序：开始充电
type WXMarblesNameListReq struct {
	g.Meta `path:"/wx-api/marble/name/list" tags:"微信小程序业务接口" method:"GET" summary:"小程序：大理石名称列表"`
	model.PageReq
}
type WXMarblesNameListRes struct {
	Id         int    `json:"id"         ` //
	Name       string `json:"name"       ` //
	PictureUrl string `json:"pictureUrl" ` //
}
