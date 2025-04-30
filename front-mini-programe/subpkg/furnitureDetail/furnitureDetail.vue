<template>
  <view class="">
  	<scroll-view scroll-y class="viewport">
  	  <!-- 基本信息 -->
  	  <view class="goods">
  	    <!-- 商品主图 -->
  	    <swiper class="swiper" :circular="true" :autoplay="true" :interval="3000" :indicator-dots="true" :indicator-color="'#767471'">
  	    	<swiper-item v-if="goods.pictureUrls">
  	    		<image class="swiper-item"  :src="goods.pictureUrls" mode="" ></image>
  	    	</swiper-item>
  	    	<swiper-item v-if="goods.pictureUrls1">
  	    		<image class="swiper-item"  :src="goods.pictureUrls1" mode=""></image>
  	    	</swiper-item>
			<swiper-item v-if="goods.pictureUrls2">
				<image class="swiper-item"  :src="goods.pictureUrls2" mode=""></image>
			</swiper-item>
			<swiper-item v-if="goods.pictureUrls3">
				<image class="swiper-item"  :src="goods.pictureUrls3" mode=""></image>
			</swiper-item>
  	    </swiper>
  	
  	    <!-- 商品简介 -->
  	    <view class="meta">
  	      <view class="meta_name">
  	      	<view class="name ellipsis">{{goods.name}} </view>
  	      </view>
		  <view class="price" v-if="goods.description">
		  	{{goods.description}}
		  </view>
  			<view class="sku_list" v-for="spec in goods.skus" :key="index">
  				<view class="price">
  					<view class="lable">
  						规格：
  					</view>
  					<view class="spec">
  						{{spec.size}} 
  					</view>
  				</view>
  				<view class="price price1">
  					<view class="lable">
  						价格：
  					</view>
					<view class="spec">
						￥{{spec.price}}
					</view>
  				</view>
  			</view>
  	    </view>
  	
  	    <!-- 操作面板 -->
  	    <view class="action">
  	      <view class="item arrow">
  	        <text class="label">系列1</text>
  	        <text class="text ellipsis"> 家居 - {{goods.sn}} </text>
  	      </view>
  	    </view>
  	  </view>
  	
  	  <!-- 商品详情 -->
  	  <view class="detail panel">
  	    <view class="title">
  	      <text>产品详情</text>
  	    </view>
  	    <view class="content">
  	      <!-- 图片详情 -->
  	      <image
  			class="detail_img"
  	        mode="widthFix"
  	        :src="goods.pictureUrls"
  	      ></image>
  			<image
  			class="detail_img"
  			  mode="widthFix"
  			  :src="goods.pictureUrls1"
  			></image>
			<image
			class="detail_img"
			  mode="widthFix"
			  :src="goods.pictureUrls2"
			></image>
			<image
			class="detail_img"
			  mode="widthFix"
			  :src="goods.pictureUrls3"
			></image>
  	    </view>
  	  </view>
  	</scroll-view>
  	
  	<!-- 用户操作 -->
  	<view class="toolbar" :style="{ paddingBottom: safeAreaInsets?.bottom + 'px' }">
  	  <view class="buttons">
  			<view class="home" @click="switchHome()"> 
  			<image class="homg_img" src="./images/home.png" mode=""></image>
  			 </view>
  	    <view class="buynow" @click="clickPhone()"> 电话联系 </view>
  	  </view>
  	</view>
	
	<popPhone :show="show" @confirm="confimCharge"></popPhone>
  </view>
</template>

<script setup >
import {onLoad} from '@dcloudio/uni-app'
import {ref} from 'vue'

let goods = ref()
let show = ref(false)

onLoad((options)=>{
  goods.value = JSON.parse(decodeURIComponent(options.goods));
})

let switchHome = ()=>{
	uni.switchTab({
		url:'/pages/home/home'
	})
}

let clickPhone = ()=>{
	show.value = !show.value
}

let confimCharge = ()=>{
	show.value = false
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
.viewport {
  background-color: #f4f4f4;
  
}
		/* 轮播图 */
		.swiper {
			width: 100vw;
				height: 830rpx;
			}
			.swiper-item {
				display: block;
				width: 100%;
				height: 830rpx;
				line-height: 500rpx;
				text-align: center;
			}
.panel {
  margin-top: 20rpx;
  background-color: #fff;
  .title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 90rpx;
    line-height: 1;
    padding: 30rpx 60rpx 30rpx 6rpx;
    position: relative;
    text {
      padding-left: 10rpx;
      font-size: 28rpx;
      color: #333;
      font-weight: 600;
      border-left: 4rpx solid #c84921;
    }
    navigator {
      font-size: 24rpx;
      color: #666;
    }
  }
}

.arrow {
  &::after {
    position: absolute;
    top: 50%;
    right: 30rpx;
    content: '\e6c2';
    color: #ccc;
    font-family: 'erabbit' !important;
    font-size: 32rpx;
    transform: translateY(-50%);
  }
}

/* 商品信息 */
.goods {
  background-color: #fff;
  .preview {
    height: 300rpx;
    position: relative;
  }
  .meta {
    border-bottom: 1rpx solid #eaeaea;
	padding: 30rpx 70rpx 40rpx 30rpx;
	.meta_name{
		display: flex;
		align-items: center;
		justify-content: space-between;
		
		.name {
		  max-height: 88rpx;
		  line-height: 1.4;
		  font-size: 50rpx;
		  color: #333;
		}
		.forward{
			width: 50rpx;
			height: 50rpx;
		}
	}
	.sku_list{
		display: flex;
	}
    .price{
		color: #a0a0a0;
		font-size: 28rpx;
		margin-top: 20rpx;
		display: flex;
		.lable{
			color: #cf4444;
		}
		.spec{
			width: 150rpx;
		}
	}
	.price1{
		margin-left: 15rpx;
	}
  }
  .action {
    padding-left: 20rpx;
    .item {
      height: 90rpx;
      padding-right: 60rpx;
      border-bottom: 1rpx solid #eaeaea;
      font-size: 26rpx;
      color: #333;
      position: relative;
      display: flex;
      align-items: center;
      &:last-child {
        border-bottom: 0 none;
      }
    }
    .label {
		font-size: 30rpx;
      width: 80rpx;
      color: #898b94;
      margin: 0 16rpx 0 10rpx;
    }
    .text {
      flex: 1;
	  font-size: 30rpx;
      -webkit-line-clamp: 1;
    }
  }
}

/* 商品详情 */
.detail {
  padding: 0 20rpx;
  .content {
	  width: 700rpx;
    .detail_img {
      width: 700rpx;
    }
  }
}

/* 同类推荐 */
.similar {
  .content {
    padding: 0 20rpx 200rpx;
    background-color: #f4f4f4;
    display: flex;
    flex-wrap: wrap;
    .goods {
      width: 340rpx;
      padding: 24rpx 20rpx 20rpx;
      margin: 20rpx 7rpx;
      border-radius: 10rpx;
      background-color: #fff;
    }
    .image {
      width: 300rpx;
      height: 260rpx;
    }
    .name {
      height: 80rpx;
      margin: 10rpx 0;
      font-size: 26rpx;
      color: #262626;
    }
    .price {
      line-height: 1;
      font-size: 20rpx;
      color: #cf4444;
    }
    .number {
      font-size: 26rpx;
      margin-left: 2rpx;
    }
  }
  navigator {
    &:nth-child(even) {
      margin-right: 0;
    }
  }
}

/* 底部工具栏 */
.toolbar {
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 1;
  background-color: #fff;
  height: 100rpx;
  padding: 0 20rpx var(--window-bottom);
  border-top: 1rpx solid #eaeaea;
  display: flex;
  justify-content: flex-end;
  align-items: center;
  box-sizing: content-box;
  .buttons {
    display: flex;
	.home{
		background-color: #dddddd;
		width: 180rpx;
		height:80rpx ;
		line-height: 80rpx;
		border-radius: 70rpx;
		text-align: center;
		.homg_img{
			width: 40rpx;
			height: 40rpx;
			margin-top: 20rpx;
		}
	}
    .addcart {
		margin-left: 20rpx;
      background-color: #54b9d1;
	  width: 220rpx;
	  text-align: center;
	  height:80rpx ;
	  line-height: 80rpx;
	  color: #fff;
	  border-radius: 70rpx;
    }
    .buynow,
    .payment {
      background-color: #c84921;
      margin-left: 20rpx;
	  width: 280rpx;
	  text-align: center;
	  height:80rpx ;
	  line-height: 80rpx;
	  color: #fff;
	  border-radius: 70rpx;
    }
  }
  .icons {
    padding-right: 10rpx;
    display: flex;
    align-items: center;
    flex: 1;
    .icons-button {
      flex: 1;
      text-align: center;
      line-height: 1.4;
      padding: 0;
      margin: 0;
      border-radius: 0;
      font-size: 20rpx;
      color: #333;
      background-color: #fff;
      &::after {
        border: none;
      }
    }
    text {
      display: block;
      font-size: 34rpx;
    }
  }
}
</style>