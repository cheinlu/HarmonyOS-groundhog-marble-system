package logic

import (
	"context"
	"fmt"
	v2 "login-demo/api/wx"
	"login-demo/internal/dao"
	"login-demo/internal/model"
	"login-demo/internal/model/do"
	"strings"
)

// 充电业务

type MarblesLogic struct {
}

var Marbles MarblesLogic

func (*MarblesLogic) MarblesList(ctx context.Context, query *v2.WXMarblesListReq) (data []model.MarblesResult, count int, err error) {
	model := dao.Marbles.Ctx(ctx)
	if query.Name != "" {
		model = model.Where("name like ?", fmt.Sprintf("%%%s%%", query.Name))
	}
	if query.Type != "" {
		model = model.Where("type = ?", query.Type)
	}
	if query.Sn != "" {
		model = model.Where("sn = ?", query.Sn)
	}
	err = model.Where("is_deleted = ?", "0").Page(query.PageNo, query.PageSize).OrderAsc("id").ScanAndCount(&data, &count, false)
	return
}

func (*MarblesLogic) Add(ctx context.Context, marble do.Marbles) (err error) {
	_, err = dao.Marbles.Ctx(ctx).Insert(marble)
	return
}

func (*MarblesLogic) Update(ctx context.Context, marble do.Marbles) (err error) {
	_, err = dao.Marbles.Ctx(ctx).Where("id", marble.Id).Update(marble)
	return
}

func (*MarblesLogic) Delete(ctx context.Context, ids string) (err error) {
	// 切割字符串
	idarr := strings.Split(ids, ",")
	for _, id := range idarr {
		del := do.Marbles{Id: id, IsDeleted: "1"}
		_, err = dao.Marbles.Ctx(ctx).Where("id", id).Update(del)
	}
	return
}
