<template>
	<view class="home-container">
		<image class="homeBg-img" src="https://static.lusson.xyz/wx-miniprogram-image/home_bg.png" mode="">
			<!-- <image class="title-img" src="/static/images/title.png" mode=""></image> -->
		<view class="title-img">
			科石云仓
		</view>
		<!-- <video class="video" src="https://aim6.oss-cn-beijing.aliyuncs.com/test_file/null/E01/S01/Fodder/2/20231025141435916gf6vmD.mp4"
		                    :danmu-list="danmuList" enable-danmu danmu-btn controls></video> -->
		<view class="home-btn">
			<view class="btn-row" @click="goSwitch('slabs')">
				<view class="btn-row-zh">大板</view>
				<view class="btn-row-cn">SLICE</view>
			</view>
			<view class="btn-row" @click="goSwitch('raw')">
				<view class="btn-row-zh">荒料</view>
				<view class="btn-row-cn">MARBRE</view>
			</view>
			<view class="btn-row" @click="goSwitch('furniture')">
				<view class="btn-row-zh">家居</view>
				<view class="btn-row-cn">HOUSE</view>
			</view>
			<view class="btn-row" @click="goSwitch('my')">
				<view class="btn-row-zh">联系方式</view>
				<view class="btn-row-cn">ABOUT</view>
			</view>
		</view>
		</image>
	</view>
</template>

<script setup>
import {ref} from 'vue'
let switchUrl = ref('')
let goSwitch = (name)=>{
	if(name == 'slabs'){
		switchUrl.value = '/pages/slabs/slabs'
	}else if(name == 'raw'){
		switchUrl.value = '/pages/rawStone/rawStone'
	}else if(name == 'furniture'){
		switchUrl.value = '/pages/furniture/furniture'
	}else if(name == 'my'){
		switchUrl.value = '/pages/my/my'
	}
	uni.switchTab({
		url:switchUrl.value
	})
}
</script>

<style lang="scss">
.home-container{
	width: 100vw;
	height: 100vh;
	.homeBg-img{
		width: 100%;
		height: 100%;
		position: relative;
		.title-img{
			position: absolute;
			top: 0;
			left: 0rpx;
			height: 300rpx;
			line-height: 300rpx;
			font-size: 80rpx;
			color: #fff;
			width: 100%;
			text-align: center;
			// display: flex;
			// justify-content: center;
		}
		.video{
			width: 100%;
			height: 400rpx;
			position: absolute;
			top: 300rpx;
			left: 0
		}
		.home-btn{
			width: 100%;
			position: absolute;
			top: 700rpx;
			left: 0;
			padding: 100rpx 50rpx 0 50rpx;
			display: flex;
			flex-wrap: wrap;
			.btn-row{
				width: 300rpx;
				height: 100rpx;
				margin-right: 40rpx;
				margin-bottom: 40rpx;
				display: flex;
				flex-direction: column;
				align-items: center;
				justify-content: center;
				background-color: #fff;
				border-radius: 20rpx;
				.btn-row-zh{
					font-size: 40rpx;
					color: #bb9b61;
					font-weight: bold;
				}
				.btn-row-cn{
					font-size: 14rpx;
					color: #bb9b61;
				}
			}
			
		}
	}
}
</style>