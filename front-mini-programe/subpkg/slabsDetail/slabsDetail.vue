<template>
	<view class="slabsDetail">
		<image class="slabs_detail_img" :src="layers.pictureUrls"  @click="previewImage"></image>
		
		<view class="slabsDetailName-ract">
			<view class="slabsDetailName">
				{{layers.name}}
			</view>
			<view class="slabsDetailSize">
				{{layers.sn}}
			</view>
			
		</view>
		<view class="slabsDetaiContent">
			<view class="circleNum">
				{{layers.layers.length}}匝
			</view>
			<view class="sliceNum">
				{{layers.slices_total}}片
			</view>
			<view class="squarNum">
				{{layers.area}}㎡
			</view>
		</view>
		<view class="guess">
		  <view
		    class="guess-item"
		    v-for="item in layers.layers"
		    :key="item"
			@click="goSize(item)"
		  >
		    <image
		      class="image"
		      mode="aspectFill"
		      :src="item.pictureUrls"
		    ></image>
		    <view class="name"> {{item.width}} x {{item.height}} x {{item.length}}mm </view>
		    <view class="price">
		      <text class="small">{{item.slices.length}}片</text>
				<text class="small">{{item.area}} ㎡</text>
		    </view>
			  <view class="nameInfo">{{item.sn}}</view>
		  </view>
		</view>
	 
	</view>
 
</template>

<script setup>
import {onLoad} from '@dcloudio/uni-app'
import {ref} from 'vue'

let layers = ref([])

onLoad((options)=>{
  layers.value = JSON.parse(decodeURIComponent(options.item));
})

const goSize = (item)=>{
	uni.navigateTo({
		 url: '/subpkg/slabsSize/slabsSize?item=' + encodeURIComponent(JSON.stringify(item))
	})
}

const previewImage = () => {
  uni.previewImage({
	  current:layers.value.pictureUrls,
	  urls:[layers.value.pictureUrls],
});
};
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
	.slabs_detail_img {
  width: 100%;
  height: 600px; /* 可根据需求调整 */
}
.slabsDetail{
	width: 100vw;
	background-color: #fff;
	
.slabs_detail_img{
	width: 100%;
	height: 620rpx;
}

.slabsDetailName-ract{
	width: 100%;
	padding: 20rpx;
	margin: 20rpx 0 20rpx 20rpx;
	.slabsDetailName{
		font-size: 40rpx;
	}
	.slabsDetailSize{
		margin-top: 10rpx;
		font-size: 30rpx;
		color: #666666;
	}
}
.slabsDetaiContent{
		width: 95%;
		border-radius: 0 0 20rpx 20rpx ;
		background-color: #888888;
		height: 200rpx;
		display: flex;
		justify-content: space-around;
		align-items: center;
		margin-bottom: 30rpx;
		margin-left: 18rpx ;
		.circleNum{
			width: 160rpx;
			height:80rpx ;
			line-height: 80rpx;
			text-align: center;
			border-radius: 70rpx;
			color: #e7e7e7;
			border: 1rpx solid white;
			background-color: #5eafc2;
		}
		.sliceNum{
			width: 200rpx;
			height:80rpx ;
			line-height: 80rpx;
			text-align: center;
			border-radius: 70rpx;
			color: #e7e7e7;
			border: 1rpx solid white;
			background-color: #5ea0da;
		}
		.squarNum{
			width: 260rpx;
			height:80rpx ;
			line-height: 80rpx;
			text-align: center;
			border-radius: 70rpx;
			color: #e7e7e7;
			border: 1rpx solid white;
			background-color: #bb5636;
		}
	}

}

/* 猜你喜欢 */
.guess {
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
