package controller_wx

import (
	"context"
	"fmt"
	v2 "login-demo/api/wx"
	"login-demo/internal/logic"
	"login-demo/internal/model"
	"strings"

	"github.com/gogf/gf/v2/os/gcfg"
)

type WxMarblesController struct {
}

// 获取大理石名称列表
func (c WxMarblesController) MarblesList(ctx context.Context, req *v2.WXMarblesListReq) (pageRes model.PageRes, err error) {
	// 初始化分页参数
	model.InitPageReq(&req.PageReq, 1, 1000)
	// 查询大理石名称列表
	marbles, count, err := logic.Marbles.MarblesList(ctx, req)
	res := make([]v2.WXMarblesListRes, len(marbles))
	for i, v := range marbles {
		res[i] = v2.WXMarblesListRes{
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
			Description: v.Description,
		}
	}
	pageRes.List, pageRes.PageNo, pageRes.PageSize, pageRes.TotalCount = res, req.PageNo, req.PageSize, count
	return
}

// 获取大理石名称列表
func (c WxMarblesController) MarblesMarbleList(ctx context.Context, req *v2.WXMarblesMarbleListReq) (pageRes model.PageRes, err error) {
	// 初始化分页参数
	model.InitPageReq(&req.PageReq, 1, 1000)

	// 查询大理石切片名称列表
	marbles, count, err := logic.Marbles.MarblesList(ctx, &v2.WXMarblesListReq{
		Name:    req.Name,
		Type:    "slice",
		PageReq: req.PageReq,
	})
	if err != nil {
		return pageRes, err
	}

	// 创建一个 map 来存储大理石信息
	marbleMap := make(map[string]v2.WXMarblesMarbleListRes)
	layerMap := make(map[string]v2.WXMarbleLayerListRes)
	for _, marble := range marbles {
		marbleSn := marble.Sn[:strings.Index(marble.Sn, "#")]
		layerSn := marble.Sn[:strings.LastIndex(marble.Sn, "#")]
		if marble.Type == "slice" {
			updateMarbleMap(marbleMap, layerMap, marble, marbleSn, layerSn)
		}
	}

	// 将 map 转换为切片
	res := make([]v2.WXMarblesMarbleListRes, 0, len(marbleMap))
	for _, marble := range marbleMap {
		res = append(res, marble)
	}

	// 设置分页响应
	pageRes.List = res
	pageRes.PageNo = req.PageNo
	pageRes.PageSize = req.PageSize
	pageRes.TotalCount = count

	return pageRes, nil
}

// 更新 marbleMap 和 layerMap
func updateMarbleMap(marbleMap map[string]v2.WXMarblesMarbleListRes, layerMap map[string]v2.WXMarbleLayerListRes, marbleModel model.MarblesResult, marbleSn, layerSn string) {
	marble := v2.WXMarblesListRes{
		Id:          marbleModel.Id,
		Sn:          marbleModel.Sn,
		Name:        marbleModel.Name,
		Type:        marbleModel.Type,
		PictureUrls: marbleModel.PictureUrls,
		Price:       marbleModel.Price,
		Width:       marbleModel.Width,
		Length:      marbleModel.Length,
		Height:      marbleModel.Height,
		Mass:        marbleModel.Mass,
		Area:        float64(marbleModel.Area) / 1000000,
		State:       marbleModel.State,
	}

	if existingMarble, ok := marbleMap[marbleSn]; ok {
		existingMarble.SlicesTotal++
		existingMarble.Area += marble.Area
		if existingLayer, ok := layerMap[layerSn]; ok {
			fmt.Println("add slice 1.1", marble.Sn)
			existingLayer.Area += marble.Area
			existingLayer.Slices = append(existingLayer.Slices, marble)
			existingMarble.Layers = []v2.WXMarbleLayerListRes{existingLayer}
		} else {
			fmt.Println("add slice 1.2", marble.Sn)
			layerMap[layerSn] = createNewLayer(marble, layerSn)
			existingMarble.Layers = []v2.WXMarbleLayerListRes{layerMap[layerSn]}
		}
		marbleMap[marbleSn] = existingMarble
	} else {
		fmt.Println("add slice 1.3", marble.Sn)
		layerMap[layerSn] = createNewLayer(marble, layerSn)
		marbleMap[marbleSn] = v2.WXMarblesMarbleListRes{
			Sn:          marbleSn,
			Name:        marble.Name,
			Type:        marble.Type,
			PictureUrls: marble.PictureUrls,
			SlicesTotal: 1,
			Area:        marble.Area,
			Width:       marble.Width,
			Length:      marble.Length,
			Layers:      []v2.WXMarbleLayerListRes{layerMap[layerSn]},
		}
	}
}

// 创建新的层
func createNewLayer(marble v2.WXMarblesListRes, layerSn string) v2.WXMarbleLayerListRes {
	return v2.WXMarbleLayerListRes{
		Sn:          layerSn,
		Name:        marble.Name,
		Type:        marble.Type,
		PictureUrls: marble.PictureUrls,
		Area:        marble.Area,
		Width:       marble.Width,
		Length:      marble.Length,
		Slices:      []v2.WXMarblesListRes{marble},
	}
}

// 获取大理石名称列表
func (c WxMarblesController) StoreList(ctx context.Context, req *v2.WXStoreListReq) (rep v2.WXStoreListRes, err error) {
	Config, _ := gcfg.New()
	err = Config.MustGet(ctx, "storeList").Scan(&rep.StoreInfos)
	return
}

// 获取大理石名称列表
func (c WxMarblesController) SharedPassward(ctx context.Context, req *v2.WXSharedPassworadReq) (rep v2.WXSharedPassworadRes, err error) {
	Config, _ := gcfg.New()
	err = Config.MustGet(ctx, "marble").Scan(&rep)
	return
}

// 获取大理石名称列表
func (c WxMarblesController) MarblesNameList(ctx context.Context, req *v2.WXMarblesNameListReq) (pageRes model.PageRes, err error) {
	// 初始化分页参数
	model.InitPageReq(&req.PageReq, 1, 1000)
	// 查询大理石名称列表
	marblesNames, count, err := logic.MarblesName.MarblesNameList(ctx, req.PageReq)
	res := make([]v2.WXMarblesNameListRes, len(marblesNames))
	for i, v := range marblesNames {
		res[i] = v2.WXMarblesNameListRes{
			Id:         v.Id,
			Name:       v.Name,
			PictureUrl: v.PictureUrl,
		}
	}
	pageRes.List, pageRes.PageNo, pageRes.PageSize, pageRes.TotalCount = res, req.PageNo, req.PageSize, count
	return
}
