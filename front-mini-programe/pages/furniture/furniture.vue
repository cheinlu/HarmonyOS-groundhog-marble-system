<template>
  <view class="viewport">
	  <image class="furniture_img" src="/static/images/furniture-topimg.png" mode=""></image>
    <!-- 搜索框 -->
    <view class="search-box">
	  <uni-search-bar placeholder="点击快速搜索商品" radius="20" bgColor="#fff" @input="handleInput" />
	</view>
    <!-- 分类 -->
    <view class="categories">
      <!-- 左侧：一级分类 -->
      <scroll-view class="primary" scroll-y>
        <view v-for="(item, index) in categoryList" :key="item" class="item" 
		:class="{ active: index === activeIndex }"  @click="indexChange(item, index)">
          <text class="name"> {{item.title}} </text>
        </view>
      </scroll-view>
      <!-- 右侧：二级分类 -->
      <scroll-view class="secondary" scroll-y>
        <!-- 内容区域 -->
          <view class="section">
            <view
              v-for="goods in furnitureList"
              :key="goods"
              class="goods"
			  @click="goDetail(goods)"
            >
              <image
                class="image"
                :src="goods.pictureUrls"
              ></image>
              <view class="name ellipsis">{{goods.name}}</view>
              <view class="price">
                <text class="symbol">{{goods.description}}</text>
				<text v-if="goods.price > 0">￥{{goods.price}}</text>
              </view>
			  <view class="goodsDetail">
			  	详情
			  </view>
            </view>
          </view>
      </scroll-view>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted,reactive } from 'vue'
import {requestCommonList} from '@/utils/api/marble.js'

let kw = ref('')
let sn = ref('')
let pageNum = ref(1)
let pageSize = ref(1000)
let furnitureList = ref([])
let timer = ref(null)

let categoryList = reactive([
	{id:0,title:'全部'},
	{id:1,title:'茶盘'},
	{id:2,title:'餐桌'}
])

const activeIndex = ref(0)
onMounted(()=>{
	getFurnitureList()
})

let indexChange = (item,index)=>{
	activeIndex.value = index
	if(item.title == '全部'){
		sn.value = ''
	}else{
		sn.value = item.title
	}
	getFurnitureList()
}

let getFurnitureList =async ()=>{
	let {data:res} = await requestCommonList(kw.value,'shopping',pageNum.value,pageSize.value,sn.value)
   if(res.code==0){
   	furnitureList.value = res.data.List
   }
}

let goDetail = (goods)=>{
	uni.navigateTo({
		url:'/subpkg/furnitureDetail/furnitureDetail?goods='+ encodeURIComponent(JSON.stringify(goods))
	})
}

//搜索
const handleInput = (keyword) => {
  if (kw.value !== keyword) {
    kw.value = keyword
    //清除timer对应的定时器
    clearTimeout(timer.value)
    //重启一个延时器，并把timerid赋值给timer
    timer.value = setTimeout(() => {
      // 对关键词进行解码
      let decodedKeyword = decodeURIComponent(keyword)
      //根据关键词，查询搜索建议列表
	  getFurnitureList()
      
    }, 600)
  }
}
</script>

<style lang="scss">
page {
  height: 100%;
  overflow: hidden;
}
.viewport {
  height: 100%;
  display: flex;
  flex-direction: column;
}
.furniture_img{
	width: 100vw;
	height: 280rpx;
}
.search-box{
	background-color: #f2f2f2;
}
.search {
  padding: 0 30rpx 20rpx;
  background-color: #fff;
  .input {
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 64rpx;
    padding-left: 26rpx;
    color: #8b8b8b;
    font-size: 28rpx;
    border-radius: 32rpx;
    background-color: #f3f4f4;
  }
}
.icon-search {
  &::before {
    margin-right: 10rpx;
  }
}
/* 分类 */
.categories {
  flex: 1;
  min-height: 400rpx;
  display: flex;
}
/* 一级分类 */
.primary {
  overflow: hidden;
  width: 140rpx;
  flex: none;
  background-color: #f6f6f6;
  .item {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 96rpx;
    font-size: 26rpx;
    color: #595c63;
    position: relative;
    &::after {
      content: '';
      position: absolute;
      bottom: 0;
      width: 100%;
      border-top: 1rpx solid #e3e4e7;
    }
  }
  .active {
    background-color: #fff;
    &::before {
      content: '';
      position: absolute;
      left: 0;
      top: 0;
      width: 8rpx;
      height: 100%;
      background-color: #c84921;
    }
  }
}
.primary .item:last-child::after,
.primary .active::after {
  display: none;
}
/* 二级分类 */
.secondary {
  background-color: #fff;
  .carousel {
    height: 200rpx;
    margin: 0 30rpx 20rpx;
    border-radius: 4rpx;
    overflow: hidden;
  }
  .title {
    height: 60rpx;
    line-height: 60rpx;
    color: #333;
    font-size: 28rpx;
    border-bottom: 1rpx solid #f7f7f8;
    .more {
      float: right;
      padding-left: 20rpx;
      font-size: 24rpx;
      color: #999;
    }
  }
  .more {
    &::after {
      font-family: 'erabbit' !important;
      content: '\e6c2';
    }
  }
  .section {
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    padding: 40rpx 0;
	margin-left: 20rpx;
    .goods {
		text-align: center;
	  margin: 0 25rpx 25rpx 0;
      width: 260rpx;
	  background-color: #f4f4f4;
	  border-radius: 10rpx;
      image {
        width: 260rpx;
        height: 260rpx;
		border-radius: 10rpx;
      }
      .name {
        padding: 10rpx 20rpx;
        font-size: 28rpx;
        color: #333;
		text-align: start;
      }
      .price {
        padding: 10rpx 20rpx;
        font-size: 22rpx;
        color: #a0a0a0;
		text-align: start;
      }
	  .goodsDetail{
		  margin: 10rpx 0 20rpx 20rpx;
		  width: 60rpx;
	  	font-size: 26rpx;
		color: #616161;
	  	border: 1rpx solid #e3e4e7;
		padding: 5rpx;
		text-align: center;
		border-radius: 8rpx;
	  }
      .number {
        font-size: 24rpx;
        margin-left: 2rpx;
      }
    }
  }
}
</style>