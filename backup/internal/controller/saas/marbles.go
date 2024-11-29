package controller_saas

import (
	"context"
	"fmt"
	v2 "login-demo/api/saas"
	wx "login-demo/api/wx"
	"login-demo/internal/consts"
	"login-demo/internal/logic"
	"login-demo/internal/model"
	"login-demo/internal/model/do"

	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
)

type MarblesController struct {
}

func (MarblesController) List(ctx context.Context, req *v2.MarbleListReq) (pageRes model.PageRes, err error) {
	// 初始化分页参数，设置默认值
	model.InitPageReq(&req.PageReq, 1, 10)
	query := wx.WXMarblesListReq{
		Name: req.Name,
		Type: req.Type,
	}
	marblesList, count, err := logic.Marbles.MarblesList(ctx, &query)
	res := make([]wx.WXMarblesListRes, len(marblesList))
	for i, v := range marblesList {
		marblesRes := wx.WXMarblesListRes{
			Id:          v.Id,
			Name:        v.Name,
			Sn:          v.Sn,
			Type:        v.Type,
			PictureUrls: v.PictureUrls,
			Price:       v.Price,
			Width:       v.Width,
			Length:      v.Length,
			Height:      v.Height,
			Mass:        v.Mass,
			Area:        float64(v.Area) / 1000000,
			State:       v.State,
		}
		res[i] = marblesRes
	}
	pageRes.List, pageRes.PageNo, pageRes.PageSize, pageRes.TotalCount = res, req.PageNo, req.PageSize, count
	return
}

// 添加大理石
func (MarblesController) Add(ctx context.Context, req *v2.MarbleAddReq) (res *v2.MarbleAddRes, err error) {
	tenantId, ok := ctx.Value(consts.TenantIDKey).(int)
	if !ok {
		err = gerror.NewCode(gcode.New(401, "tenantId 不为空", ""))
	}
	marble := do.Marbles{
		TenantId:    tenantId,
		Type:        req.Type,
		Sn:          req.Sn,
		Name:        req.Name,
		PictureUrls: req.PictureUrls,
		Price:       req.Price,
		Width:       req.Width,
		Length:      req.Length,
		Height:      req.Height,
		Mass:        req.Mass,
		Area:        req.Area,
		State:       "0",
	}
	err = logic.Marbles.Add(ctx, marble)
	if err != nil {
		fmt.Println("err:", err)
	}
	return
}

// 修改大理石
func (MarblesController) Update(ctx context.Context, req *v2.MarbleUpdateReq) (res *v2.MarbleUpdateRes, err error) {
	marble := do.Marbles{
		Id: req.Id,
	}
	if marble.Type == "" {
		marble.Type = req.Type
	}
	if marble.Sn == "" {
		marble.Sn = req.Sn
	}
	if marble.PictureUrls == "" {
		marble.PictureUrls = req.PictureUrls
	}
	if marble.Price == 0 {
		marble.Price = req.Price
	}
	if marble.Width == 0 {
		marble.Width = req.Width
	}
	if marble.Length == 0 {
		marble.Length = req.Length
	}
	if marble.Height == 0 {
		marble.Height = req.Height
	}
	if marble.Mass == 0 {
		marble.Mass = req.Mass
	}
	if marble.Area == 0 {
		marble.Area = req.Area
	}
	if marble.State == "" {
		marble.State = req.State
	}
	err = logic.Marbles.Update(ctx, marble)
	if err != nil {
		fmt.Println("err:", err)
	}
	return
}

// 删除大理石
func (MarblesController) Delete(ctx context.Context, req *v2.MarbleDelReq) (res *v2.MarbleDeleteRes, err error) {
	err = logic.Marbles.Delete(ctx, req.Ids)
	if err != nil {
		fmt.Println("err:", err)
	}
	return
}

// 上传图片
func (MarblesController) Upload(ctx context.Context, req *v2.FileUploadReq) (res *v2.FileUploadRes, err error) {
	err, fileName, fileUrl := logic.File.FileUpload(ctx, req.File)
	if err != nil {
		return
	}
	res = &v2.FileUploadRes{
		Name: fileName,
		Url:  fileUrl,
	}
	return
}
