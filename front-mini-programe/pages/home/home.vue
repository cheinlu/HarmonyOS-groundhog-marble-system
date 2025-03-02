<template>
	<view class="home-container">
		<image class="homeBg-img" src="https://static.lusson.xyz/wx-miniprogram-image/home_bg.png" mode="">
		<view class="title-ract">
			<image class="logo-img" src="/static/images/logo.jpg" mode=""></image>
			<view class="title-img">
				科石云仓
			</view>
		</view>
		<video class="video" 
		src="https://static.lusson.xyz/video/home.mp4" 
		poster="/static/images/videoImg"
		show-center-play-btn="false" 
		object-fit="cover" 
		controls></video>
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
			margin-top: 180rpx;
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
				color: #393431;
				font-weight: bold;
				text-align: center;
				margin-left: 20rpx;
			}
			
		}
		.video{
			width: 100%;
			height: 500rpx;
			position: absolute;
			top: 400rpx;
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