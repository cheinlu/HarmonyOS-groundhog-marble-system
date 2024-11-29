package v2_saas

import (
	"login-demo/internal/model"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"

	wx "login-demo/api/wx"
)

// （大理石切片和荒料和商品）查询列表
type MarbleListReq struct {
	g.Meta `path:"marble/list" tags:"大理石" method:"GET" summary:"列表"`
	Name   string `string:"name"  dc:"大理石名, 鱼肚灰，伯爵白"`
	Type   string `string:"type"  dc:"类型，slices 切片，marble 荒料，shopping 商品"`
	model.PageReq
}

type MarbleListRes struct {
	g.Meta `mime:"application/json" example:"string"`
	Data   []wx.WXMarblesListRes `json:"data"`
}

// （大理石切片和荒料和商品）入库和添加
type MarbleAddReq struct {
	g.Meta      `path:"marble/add" tags:"大理石" method:"POST" summary:"大理石添加和入库"`
	Type        string `string:"type"  dc:"类型，slices 切片，marble 荒料，shopping 商品"`
	Sn          string `json:"sn"          ` //
	Name        string `json:"name"        ` //
	PictureUrls string `json:"pictureUrls" ` //
	Price       int    `json:"price"       ` //
	Width       int    `json:"width"       ` //
	Length      int    `json:"length"      ` //
	Height      int    `json:"height"      ` //
	Mass        int    `json:"mass"        ` //
	Area        int    `json:"area"        ` //
}

type MarbleAddRes struct {
	g.Meta  `mime:"application/json" example:"string"`
	Message string `json:"message"`
}

// 修改｜出库（大理石切片和荒料和商品）
type MarbleUpdateReq struct {
	g.Meta      `path:"marble/update" tags:"大理石" method:"POST" summary:"修改｜出库（大理石切片和荒料和商品）"`
	Type        string `string:"type"  dc:"类型，slices 切片，marble 荒料，shopping 商品"`
	Id          int    `json:"id"          ` //
	Sn          string `json:"sn"          ` //
	Name        string `json:"name"        ` //
	PictureUrls string `json:"pictureUrls" ` //
	Price       int    `json:"price"       ` //
	Width       int    `json:"width"       ` //
	Length      int    `json:"length"      ` //
	Height      int    `json:"height"      ` //
	Mass        int    `json:"mass"        ` //
	Area        int    `json:"area"        ` //
	State       string `json:"state"       ` //
}

type MarbleUpdateRes struct {
	g.Meta  `mime:"application/json" example:"string"`
	Message string `json:"message"`
}

// （大理石切片和荒料和商品）删除
type MarbleDelReq struct {
	g.Meta `path:"marble/del" tags:"大理石" method:"POST" summary:"修改｜出库（大理石切片和荒料和商品）"`
	Ids    string `json:"ids"          ` //
}

type MarbleDeleteRes struct {
	g.Meta  `mime:"application/json" example:"string"`
	Message string `json:"message"`
}

// 上传图片
type FileUploadReq struct {
	g.Meta `path:"file/upload" tags:"公用" method:"post" summary:"图片上传"`
	File   *ghttp.UploadFile `json:"file" type:"json" dc:"选择上传文件"`
}

type FileUploadRes struct {
	g.Meta `mime:"application/json" `
	Name   string `json:"name" dc:"文件名称"`
	Url    string `json:"url" dc:"访问URL"`
}
