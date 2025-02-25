<template>
  <view class="myContent">
  <view class="my_swiper">
  	<swiper class="swiper" :circular="true" :autoplay="true" :interval="3000" :indicator-dots="true" :indicator-color="'#767471'">
		<swiper-item>
			<image class="swiper-item" src="https://static.lusson.xyz/wx-miniprogram-image/home_bg.png" mode="" ></image>
		</swiper-item>
		<swiper-item>
			<image class="swiper-item" src="https://static.lusson.xyz/wx-miniprogram-image/home_bg.png" mode=""></image>
		</swiper-item>
	</swiper>
  </view>
  <view class="enterpriseDetail">
	<scroll-view class="scrollView" scroll-y="true"  :scroll-top="scrollTop"  ref="scrollView">
		<view class="scroll-item" v-for="address in storeList" :key="address.name">
			<view class="name">
				{{address.name}}
			</view>
			<view class="address">
				<image class="address_img" src="./images/adress.png" mode=""></image>
				<view class="address_text">
					<text selectable="true">{{address.address}}</text>
				</view>
				<image class="right_arrow_img" src="/static/images/right_arrow.png" mode=""></image>
			</view>
			<view class="phone">
			  <image class="phone_img" src="./images/phone.png" mode=""></image>
			  <view class="phone_text">
			    <a :href="'tel:' + address.phone">{{address.phone}}</a>
			  </view>
			  <image class="right_arrow_img" src="/static/images/right_arrow.png" mode=""></image>
			</view>
		</view>
		</scroll-view>
  </view>
  </view>
</template>

<script setup>
import { ref, onMounted, reactive } from 'vue'
import {requestStoreList} from '@/utils/api/marble.js'

onMounted(()=>{
	getStoreList()
})

const storeList = ref([])

const getStoreList = async()=>{
	let {data:res} = await requestStoreList()
	if(res.code==0){
		storeList.value = res.data.store_infos
	}
}
</script>

<style lang="scss">
.swiper {
  width: 100%;
  height: 40vh; /* 根据屏幕高度自适应 */
}
.swiper-item {
  display: block;
  width: 100%;
  height: 100%;
}
.swiper-item img {
  border-radius: 10px; /* 圆角 */
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2); /* 阴影 */
}
.swiper {
  position: relative;
}
.swiper .swiper-indicators {
  bottom: 20rpx; /* 调整指示点位置 */
}

.enterpriseDetail {
  padding: 20rpx;
}
.scroll-item {
  background-color: #fff;
  border-radius: 10px; /* 卡片圆角 */
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 卡片阴影 */
  margin-bottom: 30rpx; /* 项目间距 */
  padding: 20rpx;
}
.name {
  font-size: 36rpx;
  font-weight: bold;
  color: #c84921;
  margin-bottom: 10rpx;
}
.address, .phone {
  display: flex;
  align-items: center;
  margin-bottom: 15rpx;
  font-size: 28rpx;
  color: #737373;
}
.address_img, .phone_img {
  width: 40rpx;
  height: 40rpx;
  margin-right: 20rpx;
}
.address_text, .phone_text {
  flex: 1;
}
.right_arrow_img {
  width: 40rpx;
  height: 40rpx;
}

.phone_text a {
  color: #c84921;
  text-decoration: none; /* 去掉下划线 */
}
.scroll-item:hover {
  background-color: #f9f9f9; /* 悬停时背景色 */
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1); /* 悬停时加大阴影 */
}

.address, .phone {
  color: #555; /* 更深的灰色，增加对比度 */
}
.scroll-item {
  background-color: #f9f9f9; /* 淡背景 */
}
.name {
  color: #c84921;
}

</style>
