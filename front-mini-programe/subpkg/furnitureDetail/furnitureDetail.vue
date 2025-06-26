<template>
  <view class="">
    <scroll-view scroll-y class="viewport">
      <!-- 基本信息 -->
      <view class="goods">
        <!-- 商品主图 -->
        <swiper class="swiper" :circular="true" :autoplay="true" :interval="3000" :indicator-dots="true" :indicator-color="'#767471'">
          <swiper-item v-if="goods.pictureUrls">
            <image class="swiper-item" :src="goods.pictureUrls" mode=""></image>
          </swiper-item>
          <swiper-item v-if="goods.pictureUrls1">
            <image class="swiper-item" :src="goods.pictureUrls1" mode=""></image>
          </swiper-item>
          <swiper-item v-if="goods.pictureUrls2">
            <image class="swiper-item" :src="goods.pictureUrls2" mode=""></image>
          </swiper-item>
          <swiper-item v-if="goods.pictureUrls3">
            <image class="swiper-item" :src="goods.pictureUrls3" mode=""></image>
          </swiper-item>
        </swiper>
    
        <!-- 商品简介 -->
        <view class="meta">
         <view class="meta_name">
           <view class="name ellipsis">{{goods.name}}</view>
         </view>
        <!-- 价格显示 -->
        <view class="price-row" v-if="goods.skus && goods.skus.length > 0">
          <text class="price-label">价格：</text>
          <text class="price-value">￥{{goods.skus[selectedSpecIndex].price}}</text>
        </view>
        
        <view class="price" v-if="goods.description">
          {{goods.description}}
        </view>
          
          <!-- 规格选择 -->
          <view class="spec-container" v-if="goods.skus">
            <text class="spec-label">尺寸：</text>
            <view class="spec-options">
              <view 
                v-for="(spec, index) in goods.skus" 
                :key="index" 
                class="spec-option"
                :class="{active: selectedSpecIndex === index}"
                @click="selectSpec(index)"
              >
                {{spec.size}}
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
          <image class="detail_img" mode="widthFix" :src="goods.pictureUrls"></image>
          <image class="detail_img" mode="widthFix" :src="goods.pictureUrls1"></image>
          <image class="detail_img" mode="widthFix" :src="goods.pictureUrls2"></image>
          <image class="detail_img" mode="widthFix" :src="goods.pictureUrls3"></image>
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

<script setup>
import {onLoad} from '@dcloudio/uni-app'
import {ref} from 'vue'

let goods = ref({})
let show = ref(false)
let selectedSpecIndex = ref(0)
let selectedFabricIndex = ref(0)

onLoad((options)=>{
  goods.value = JSON.parse(decodeURIComponent(options.goods));
})

const selectSpec = (index) => {
  selectedSpecIndex.value = index
}

const selectFabric = (index) => {
  selectedFabricIndex.value = index
}

const switchHome = () => {
  uni.switchTab({
    url:'/pages/home/home'
  })
}

const clickPhone = () => {
  show.value = !show.value
}

const confimCharge = () => {
  show.value = false
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
    padding: 30rpx 70rpx 15rpx 30rpx;
    .meta_name {
     margin-bottom: 20rpx;
	   .name {
		 max-height: 88rpx;
		 line-height: 1.4;
		 font-size: 50rpx;
		 color: #333;
	   }
    }
    .price-row {
      display: flex;
      align-items: center;
      margin-bottom: 20rpx;
      .price-label {
        font-size: 30rpx;
        color: #cf4444;
        margin-right: 5rpx;
      }
      .price-value {
        font-size: 26rpx;
        color: #cf4444;
      }
    }
    
    .price {
      color: #a0a0a0;
      font-size: 28rpx;
      margin-bottom: 30rpx;
    }
    
    .spec-container {
      margin-bottom: 10rpx;
      .spec-label {
        display: block;
        color: #cf4444;
        font-size: 30rpx;
        margin-bottom: 15rpx;
      }
      .spec-options {
        display: flex;
        flex-wrap: wrap;
        gap: 15rpx;
        .spec-option {
          padding: 10rpx 20rpx;
          border: 1rpx solid #eaeaea;
          border-radius: 8rpx;
          font-size: 26rpx;
          color: #333;
          &.active {
            border-color: #c84921;
            color: #c84921;
            background-color: rgba(200, 73, 33, 0.1);
          }
        }
      }
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
    .home {
      background-color: #dddddd;
      width: 180rpx;
      height:80rpx;
      line-height: 80rpx;
      border-radius: 70rpx;
      text-align: center;
      .homg_img {
        width: 40rpx;
        height: 40rpx;
        margin-top: 20rpx;
      }
    }
    .buynow {
      background-color: #c84921;
      margin-left: 20rpx;
      width: 280rpx;
      text-align: center;
      height:80rpx;
      line-height: 80rpx;
      color: #fff;
      border-radius: 70rpx;
    }
  }
}
</style>