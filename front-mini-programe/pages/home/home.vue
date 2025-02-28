<template>
	<view class="home-container">
		<image class="homeBg-img" src="https://static.lusson.xyz/wx-miniprogram-image/home_bg.png" mode="">
			<!-- <image class="title-img" src="/static/images/title.png" mode=""></image> -->
		<view class="title-ract">
			<image class="logo-img" src="/static/images/logo.jpg" mode=""></image>
			<view class="title-img">
				科石云仓
			</view>
		</view>
		<video class="video" src="https://static.lusson.xyz/video/home.mp4" show-center-play-btn="false" object-fit="cover" controls></video>
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

<script>
	export default{
		onShareAppMessage() {
			return {
				title:'科石',
				path:"/pages/home/home"
			}
		},
		onShareTimeline(){
			return{
				title:'科石',
			}
		}
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
		.title-ract{
			position: absolute;
			top: 0;
			width: 100%;
			margin-top: 80rpx;
			display: flex;
			align-items: center;
			justify-content: center;
			background-color: #fff;
			border-radius: 20rpx;
			.logo-img{
				width: 80rpx;
				height: 80rpx;
			}
			.title-img{
				font-size: 80rpx;
				color: #bb9b61;
				font-weight: bold;
				text-align: center;
				margin-left: 20rpx;
			}
			
		}
		.video{
			width: 100%;
			height: 500rpx;
			position: absolute;
			top: 240rpx;
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