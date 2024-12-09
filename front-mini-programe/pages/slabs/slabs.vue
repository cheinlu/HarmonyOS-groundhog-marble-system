<template>
  <view class="home-container">
	<view class="ImageView">
		<image class="bg-image" src="/static/images/furniture-topimg.png"></image>
	</view>
	<scroll-view class="scrollView" scroll-y="true"  @scrolltolower="loadNextPage" :scroll-top="scrollTop"  ref="scrollView">
		<view class="scroll-item" v-for="slabs in slabsList" :key="slabs.id" @click="gotoSearch(slabs.name)">
			<view class="left-title">
				{{slabs.name}}
			</view>
			<view class="right-image-view">
				<image class="right-image" :src="slabs.pictureUrl"></image>
			</view>
		</view>
		</scroll-view>
  
  <!-- 跳转搜索 -->
  </view>
</template>

<script setup>
import { ref, onMounted, reactive } from 'vue'
import {requestMarbleList} from '@/utils/api/marble.js'
let windowHeight = ref(0)
let pageNum = ref(1)
let pageSize = ref(1000)
let slabsList = ref([])

//组件挂载
onMounted(() => {
  let sysInfo = uni.getSystemInfoSync()
   windowHeight.value = sysInfo.windowHeight - 50
   
   getMarblesList()

})

//获取大理石名称列表数据
const getMarblesList = async()=>{
  let {data:res} = await requestMarbleList(pageNum.value,pageSize.value)
  if(res.code==0){
	 slabsList.value = res.data.List
  }
}

let gotoSearch=(name)=>{
	let url = '/subpkg/slabsSearch/slabsSearch?id=' + 'slab' + '&name=' + name
	uni.navigateTo({
		url
	})
}
</script>

<style lang="scss" scoped>
.home-container{
	background-color: #f7f7f7;
	  width: 100vw;
	  height: 100vh;
	.ImageView{
		
		.bg-image{
			width: 100vw;
			height: 140px;
			 margin-bottom: 10rpx;
		}
	}  
	.scroll-item{
		background-color: #ffffff;
		    margin: 10rpx 20rpx ;
		    font-size: 20rpx;
		    border-radius: 15rpx;
			display: flex;
			justify-content: space-between;
			align-items: center;
		.left-title{
			width: 40%;
			height: 100rpx;
			line-height: 100rpx;
			text-align: center;
			font-size: 35rpx;
		}
		.right-image-view{
			width: 70%;
			height: 100%;
			margin-top: 20rpx;
			
			
			.right-image{
				width: 100%;
				height: 180rpx;
				box-shadow:2px 2px 2px 2px rgba(0, 0, 0, 0.1);
			}
		}
	}
}
</style>