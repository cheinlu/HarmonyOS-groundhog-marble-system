<template>
	<view class="home-container">
		<image class="homeBg-img" src="https://static.lusson.xyz/wx-miniprogram-image/home_bg.png" mode="">
		<video class="video" 
		src="https://static.lusson.xyz/video/home.mp4" 
		poster="https://static.lusson.xyz/video/home_video.jpg"
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
		.video{
			width: 100%;
			height: 500rpx;
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