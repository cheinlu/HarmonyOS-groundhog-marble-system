<template>
  <view class="slabsSizeContent">
   <view class="slabsSizeTop">
   	<view class="title">{{sizes.name}}</view>
   	<view class="service">A级大板、现货直供、项目深化、效果制作、可咨询客服</view>
   	<view class="slabsSizeGg">
   		<view>规格</view>
   		<view>{{sizes.width}} x {{sizes.height}} x {{sizes.length}}mm</view>
   	</view>
   	<view class="slabsSizePfs">
   		<view>平方数</view>
   		<view style="color:#c84921 ;">{{sizes.slices.length}}片 / {{sizes.area}}㎡</view>
   	</view>
   </view>
   <view class="guess">
     <navigator
       class="guess-item"
       v-for="item in sizes.slices"
       :key="item"
     >
       <image
         class="image"
         mode="aspectFill"
         :src="item.pictureUrls"
		 @click="previewImage(item.pictureUrls)"
       ></image>
       <view class="name"> {{item.width}} x {{item.height}} x {{item.length}}mm </view>
       <view class="price">
   		<text class="small">{{item.area}} ㎡</text>
       </view>
   	  <view class="nameInfo">{{item.sn}}</view>
     </navigator>
   </view>
  </view>
</template>

<script setup>
import {onLoad} from '@dcloudio/uni-app'
import {ref} from 'vue'
let sizes = ref([])
onLoad((options)=>{
  sizes.value = JSON.parse(decodeURIComponent(options.item));
})

const previewImage = (pictureUrls) => {
	  uni.previewImage({
		  current:pictureUrls,
		  urls:[pictureUrls],
	});
};
</script>

<style lang="scss">
	.slabsSizeContent{
		width: 100%;
		padding: 40rpx 0 0;
		.slabsSizeTop{
			line-height: 85rpx;
			font-size: 32rpx;
			margin-bottom: 30rpx;
			position: sticky;
			    top: 0;
			    z-index: 999;
				  background-color: #fff;
			.title{
				padding: 0 20rpx;
			}
			.service{
				color: #666666;
				font-size: 28rpx;
				padding: 0 20rpx;
				border-bottom: 1px solid #666666;
			}
			.slabsSizeGg{
				padding: 0 20rpx;
				width: 700rpx;
				display: flex;
				justify-content: space-between;
				color: #666666;
				font-size: 28rpx;
				border-bottom: 1px solid #666666;
			}
			.slabsSizePfs{
				padding: 0 20rpx;
				width: 700rpx;
				display: flex;
				justify-content: space-between;
				color: #666666;
				font-size: 28rpx;
				box-shadow: 1px 0px 2px 2px rgba(0, 0, 0, 0.1);;
			}
		}
	}
	:host {
	  display: block;
	}
	
	/* 猜你喜欢 */
	.guess {
	  display: flex;
	 display: flex;
	 flex-wrap: wrap;
	 justify-content: space-between;
	 padding: 0 35rpx;
	  .guess-item {
	    width: 330rpx;
	    margin-bottom: 20rpx;
	    border-radius: 10rpx;
	    overflow: hidden;
	    background-color: #f4f4f4;
	    position: relative;
	  }
	  .image {
	    width: 330rpx;
	    height: 260rpx;
	  }
	  .name {
	    height: 35rpx;
	    margin: 15rpx ;
	    font-size: 26rpx;
	    color: #a0a0a0;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    display: -webkit-box;
	    -webkit-line-clamp: 2;
	    -webkit-box-orient: vertical;
	  }
	  .price {
	    line-height: 1;
	    padding-top: 4rpx;
		margin: 15rpx ;
		margin-bottom: 25rpx;
	    color: #cf4444;
	    font-size: 32rpx;
		display: flex;
		justify-content: space-between;
	  }
	  .small {
	    font-size: 80%;
	  }
	  .nameInfo {
	    position: absolute;
	    top: 220rpx;
	    left: 0;
	    font-size: 20rpx;
	    color: #fff;
	    padding-left: 20rpx;
	    width: 310rpx;
	    height: 40rpx;
	    line-height: 40rpx;
	    background-color: #8a8884;
	    opacity: 0.9;
	    border-top-left-radius: 15rpx;
	    border-top-right-radius: 15rpx;
	    overflow: hidden;
		word-break: break-all;  
		text-overflow: ellipsis;  
		display: -webkit-box; 
		-webkit-box-orient: vertical; 
		-webkit-line-clamp: 1; 
	  }
	}
</style>
