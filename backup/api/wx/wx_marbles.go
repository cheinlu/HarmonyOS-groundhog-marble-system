package v2_wx

import (
	"login-demo/internal/model"

	"github.com/gogf/gf/v2/frame/g"
)

type WXMarblesListReq struct {
	g.Meta `path:"/wx-api/marbles/list" tags:"微信小程序业务接口" method:"GET" summary:"小程序：荒料和商品列表"`
	Name   string `json:"name"        ` //
	Type   string `json:"type"        ` //
	Sn     string `json:"sn"          ` //
	model.PageReq
}
type WXMarblesListRes struct {
	Id          int     `json:"id"          ` //
	Sn          string  `json:"sn"          ` //
	Name        string  `json:"name"        ` //
	Type        string  `json:"type"        ` //
	PictureUrls string  `json:"pictureUrls" ` //
	Price       int     `json:"price"       ` //
	Width       int     `json:"width"       ` //
	Length      int     `json:"length"      ` //
	Height      int     `json:"height"      ` //
	Mass        int     `json:"mass"        ` //
	Area        float64 `json:"area"        ` //
	State       int     `json:"state"       ` //
	Description string  `json:"description" ` //
}

type WXMarblesMarbleListReq struct {
	g.Meta `path:"/wx-api/marbles/marble/list" tags:"微信小程序业务接口" method:"GET" summary:"小程序：大理石(大板)列表"`
	Name   string `json:"name"        ` //
	model.PageReq
}

type WXMarblesMarbleListRes struct {
	Sn          string                 `json:"sn"          `  //
	Name        string                 `json:"name"        `  //
	Type        string                 `json:"type"        `  //
	PictureUrls string                 `json:"pictureUrls" `  //
	SlicesTotal int                    `json:"slices_total" ` //
	Area        float64                `json:"area"        `  //
	Width       int                    `json:"width"       `  //
	Length      int                    `json:"length"      `  //
	Layers      []WXMarbleLayerListRes `json:"layers"      `  //
}

type WXMarbleLayerListRes struct {
	Sn          string             `json:"sn"          ` //
	Name        string             `json:"name"        ` //
	Type        string             `json:"type"        ` //
	PictureUrls string             `json:"pictureUrls" ` //
	Price       int                `json:"price"       ` //
	Width       int                `json:"width"       ` //
	Length      int                `json:"length"      ` //
	Height      int                `json:"height"      ` //
	Area        float64            `json:"area"        ` //
	Slices      []WXMarblesListRes `json:"slices"      ` //
}
