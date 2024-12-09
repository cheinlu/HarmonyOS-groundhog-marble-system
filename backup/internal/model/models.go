package model

import (
	"time"

	"github.com/gogf/gf/v2/os/gtime"
)

type MarbleQuery struct {
	Sn     string `json:"sn"          ` //
	Name   string `json:"name"        ` //
	Type   string `json:"type"        ` //
	Price  int    `json:"price"       ` //
	Width  int    `json:"width"       ` //
	Length int    `json:"length"      ` //
	Height int    `json:"height"      ` //
	Mass   int    `json:"mass"        ` //
	Area   int    `json:"area"        ` //
	State  int    `json:"state"       ` //
}

type MarblesResult struct {
	Id           int    `json:"id"          ` //
	Sn           string `json:"sn"          ` //
	Name         string `json:"name"        ` //
	Type         string `json:"type"        ` //
	PictureUrls  string `json:"pictureUrls" ` //
	Price        int    `json:"price"       ` //
	Width        int    `json:"width"       ` //
	Length       int    `json:"length"      ` //
	Height       int    `json:"height"      ` //
	Mass         int    `json:"mass"        ` //
	Area         int    `json:"area"        ` //
	State        int    `json:"state"       ` //
	Remark       string `json:"remark"`
	Description  string `json:"description" `  //
	PictureUrls1 string `json:"pictureUrls1" ` //
	PictureUrls2 string `json:"pictureUrls2" ` //
	PictureUrls3 string `json:"pictureUrls3" ` //
	PictureUrls4 string `json:"pictureUrls4" ` //
	PictureUrls5 string `json:"pictureUrls5" ` //
}

// 充电订单聚合查询
type MarblesNameResult struct {
	Id         int    `json:"id"         ` //
	Name       string `json:"name"       ` //
	PictureUrl string `json:"pictureUrl" ` //
}

// 充电相关
type ChargeOrderQuery struct {
	OrderCode string    `json:"qrderCode"`
	UserId    int       `json:"userId"`
	StationId int       `json:"stationId"`
	PileId    int       `json:"pileId"`
	BeforeAt  time.Time `json:"beforeAt"` // 订单开始时间（起始）
	AfterAt   time.Time `json:"afterAt"`  // 订单开始时间（结束）
	State     int       `json:"state"`    //0:充电中,1:已完成,2:未付账
	PageReq
}

// 充电订单聚合查询
type ChargeOrderResult struct {
	Id          int       `json:"id"`
	OrderCode   string    `json:"orderCode" `   //
	UserId      int       `json:"userId"    `   //
	Nickname    string    `json:"nickname"    ` //
	StationId   int       `json:"stationId" `   //
	StationName string    `json:"stationName" ` //
	PileId      int       `json:"pileId"    `   //
	PileCode    string    `json:"pileCode"    ` //
	StartAt     time.Time `json:"startAt"   `   //
	StopAt      time.Time `json:"stopAt"    `   //
	State       int       `json:"state"     `   //
	Price       float64   `json:"price"     `   //
	CreateAt    time.Time `json:"createAt"  `   //
	UpdateAt    time.Time `json:"updateAt"  `   //
}

// Pile is the golang structure for table pile.
type Pile struct {
	Id        int         `json:"id"        ` //
	Code      string      `json:"code"      ` //
	Name      string      `json:"name"      ` //
	StationId int         `json:"stationId" ` //
	State     int         `json:"state"     ` //
	CreateAt  *gtime.Time `json:"createAt"  ` //
	UpdateAt  *gtime.Time `json:"updateAt"  ` //
}

// user 聚合信息，聚合余额
type UserMore struct {
	Id        int       `json:"id"       `    //
	Passport  string    `json:"passport" `    //
	Password  string    `json:"password" `    //
	Nickname  string    `json:"nickname" `    //
	Balance   float64   `json:"balance"  `    //
	AvatarUrl string    `json:"avatar_url"  ` //
	RoleId    int       `json:"role_id"  `    //
	RoleName  string    `json:"role_name"  `  //
	CreateAt  time.Time `json:"createAt" `    //
	UpdateAt  time.Time `json:"updateAt" `    //
}

// payRecord 聚合信息，聚合用户名
type PayRecordInfo struct {
	Id       int       `json:"id"       `   //
	PayCode  string    `json:"payCode"  `   //
	UserId   int       `json:"userId"   `   //
	State    int       `json:"state"    `   //
	Price    float64   `json:"price"    `   //
	Username string    `json:"userName"   ` //
	PayAt    time.Time `json:"payAt"    `   //
	CreateAt time.Time `json:"createAt" `   //
	UpdateAt time.Time `json:"updateAt" `   //
}

type Station struct {
	Id         int         `json:"id"         `   //
	TenantId   int         `json:"tenantId"   `   //
	TenantName string      `json:"tenantName"   ` //
	Name       string      `json:"name"       `   //
	Address    string      `json:"address"    `   //
	Coordinate string      `json:"coordinate" `   //
	ImageUrl   string      `json:"imageUrl"   `   //
	CreateAt   *gtime.Time `json:"createAt"   `   //
	UpdateAt   *gtime.Time `json:"updateAt"   `   //
}

type UserContext struct {
	Username string
}
