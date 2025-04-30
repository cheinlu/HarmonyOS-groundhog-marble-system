<template>
  <!--弹框信息确认-->
  <u-popup :show="show" mode="bottom" closeable @close="confim">
    <view class="pop-contain">
      <view class="phone-container">
        <!-- 第一个电话号码 -->
        <view class="phone-item" @click="makePhoneCall('18060036683')">
          <text>18060036683</text>
		</view>
        
        <!-- 分隔线 -->
        <view class="divider"></view>
        
        <!-- 第二个电话号码 -->
        <view class="phone-item" @click="makePhoneCall('18201995299')">
          <text>18201995299</text>
		</view>
      </view>
      
      <view class="confim" @click="confirmBtn()">
        先再看看
      </view>
    </view>
  </u-popup>
</template>

<script setup>
import {defineProps,ref} from 'vue'
let $emit = defineEmits(['confirm'])
let props = defineProps(['list', 'pricePerHour','show'])

let confim = () => {
  $emit('confirm')
}

let confirmBtn = ()=>{
  $emit('confirm')
}

// 拨打电话方法
const makePhoneCall = (phoneNumber) => {
  uni.makePhoneCall({
    phoneNumber: phoneNumber
  });
};
</script>

<style lang="scss">
.pop-contain{
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-top-left-radius: 20rpx;
}

.phone-container {
  width: 100vw;
  display: flex;
  flex-direction: column;
}

.phone-item {
  height: 130rpx; /* 原高度的一半 */
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
  
  .image {
    width: 55rpx;
    height: 55rpx;
    position: absolute;
    right: 40rpx;
  }
}

.divider {
  height: 1rpx;
  background-color: #eee;
  margin: 0 30rpx;
}

.confim{
  width: 600rpx;
  height: 80rpx;
  line-height: 80rpx;
  border-radius: 20rpx;
  text-align: center;
  background-color: #dddddd;
  font-size: 30rpx;
  margin: 30rpx 0;
}
</style>