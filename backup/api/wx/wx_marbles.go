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
	Id           int     `json:"id"          ` //
	Sn           string  `json:"sn"          ` //
	Name         string  `json:"name"        ` //
	Type         string  `json:"type"        ` //
	PictureUrls  string  `json:"pictureUrls" ` //
	Price        int     `json:"price"       ` //
	Width        int     `json:"width"       ` //
	Length       int     `json:"length"      ` //
	Height       int     `json:"height"      ` //
	Mass         int     `json:"mass"        ` //
	Area         float64 `json:"area"        ` //
	State        int     `json:"state"       ` //
	Remark       string  `json:"remark"       `
	Description  string  `json:"description" `  //
	PictureUrls1 string  `json:"pictureUrls1" ` //
	PictureUrls2 string  `json:"pictureUrls2" ` //
	PictureUrls3 string  `json:"pictureUrls3" ` //
	PictureUrls4 string  `json:"pictureUrls4" ` //
	PictureUrls5 string  `json:"pictureUrls5" ` //
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

type WXMarblesNameListReq struct {
	g.Meta `path:"/wx-api/marble/name/list" tags:"微信小程序业务接口" method:"GET" summary:"小程序：大理石名称列表"`
	model.PageReq
}
type WXMarblesNameListRes struct {
	Id         int    `json:"id"         ` //
	Name       string `json:"name"       ` //
	PictureUrl string `json:"pictureUrl" ` //
}

type WXStoreListReq struct {
	g.Meta `path:"/wx-api/marble/store/list" tags:"微信小程序业务接口" method:"GET" summary:"小程序：商铺地址列表"`
}

type WXStoreListRes struct {
	StoreInfos []StoreInfo `json:"store_infos"`
}

type StoreInfo struct {
	Name    string `json:"name"`
	Address string `json:"address"`
	Phone   string `json:"phone"`
}

type WXSharedPassworadReq struct {
	g.Meta `path:"/wx-api/marble/password" tags:"微信小程序业务接口" method:"GET" summary:"小程序：展示密码"`
}

type WXSharedPassworadRes struct {
	Password string `json:"password"`
}
