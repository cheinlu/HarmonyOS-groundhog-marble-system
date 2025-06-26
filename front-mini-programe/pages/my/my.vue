<template>
  <view class="myContent">
    <view class="my_swiper">
      <swiper class="swiper" :circular="true" :autoplay="true" :interval="3000" :indicator-dots="true" :indicator-color="'#767471'">
        <swiper-item>
          <image class="swiper-item" src="https://static.lusson.xyz/wx-miniprogram-image/home_bg.png" mode=""></image>
        </swiper-item>
        <swiper-item>
          <image class="swiper-item" src="https://static.lusson.xyz/wx-miniprogram-image/home_bg.png" mode=""></image>
        </swiper-item>
      </swiper>
    </view>
    <view class="enterpriseDetail">
      <scroll-view class="scrollView" scroll-y="true" :scroll-top="scrollTop" ref="scrollView">
        <view class="scroll-item" v-for="address in storeList" :key="address.name">
          <view class="name">
            {{address.name}}
          </view>
          <view class="address" @click="navigateToAddress(address)">
            <image class="address_img" src="./images/adress.png" mode=""></image>
            <view class="address_text">
              <text selectable="true">{{address.address}}</text>
            </view>
            <image class="right_arrow_img" src="/static/images/right_arrow.png" mode=""></image>
          </view>
          <view class="phone">
            <image class="phone_img" src="./images/phone.png" mode=""></image>
            <view class="phone_numbers">
              <view 
                v-for="(phone, index) in address.phones" 
                :key="index" 
                class="phone_text" 
                @click="makePhoneCall(phone)"
              >
                <text>{{ phone }}</text>
                <image 
                  v-if="index < address.phones.length - 1" 
                  class="phone_separator" 
                  src="/static/images/phone_separator.png" 
                  mode="widthFix"
                ></image>
              </view>
            </view>
            <image class="right_arrow_img" src="/static/images/right_arrow.png" mode=""></image>
          </view>
        </view>
      </scroll-view>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { requestStoreList } from '@/utils/api/marble.js'
import { useLocationStore } from '../../store/location';

const storeList = ref([])
const scrollTop = ref(0)

// 初始化Store
const studioStore = useLocationStore()

onMounted(() => {
  getStoreList()
})

const getStoreList = async() => {
  let {data: res} = await requestStoreList();
  if (res.code == 0) {
    storeList.value = res.data.store_infos.map(item => {
      const phones = item.phone.split('/').filter(p => p.trim());
      return {
        ...item,
        phones: phones.length > 0 ? phones : ['暂无号码']
      };
    });
  }
};

// 拨打电话
const makePhoneCall = (phoneNumber) => {
  if (!phoneNumber || phoneNumber === '暂无号码') {
    uni.showToast({
      title: '无效的电话号码',
      icon: 'none'
    });
    return;
  }
  uni.makePhoneCall({
    phoneNumber: phoneNumber
  });
};

const navigateToAddress = (address) => {
  uni.authorize({
    scope: 'scope.userLocation',
    success: () => {
      uni.getLocation({
        type: 'gcj02',
        success: (res) => {
          // 成功获取位置后设置坐标
          studioStore.setCoordinate({
            latitude: Number(address.latitude),
            longitude: Number(address.longitude)
          });
          
          // 使用完整导航（起点+终点）
         navigateWithoutLocation(address)
        },
        fail: (err) => {
          console.error('获取位置失败:', err);
          uni.showToast({
            title: '获取位置失败，将使用默认导航',
            icon: 'none'
          });
          navigateWithoutLocation(address);
        }
      });
    },
    fail: () => {
      uni.showModal({
        title: '提示',
        content: '需要地理位置权限才能导航，请前往设置开启权限',
        confirmText: '去设置',
        success: (res) => {
          if (res.confirm) {
            uni.openSetting();
          }
        }
      });
      navigateWithoutLocation(address);
    }
  });
}

const navigateWithoutLocation = (address) => {
  // 直接使用目标地址坐标导航（不包含用户当前位置）
  uni.openLocation({
    latitude: Number(address.latitude),
    longitude: Number(address.longitude),
    name: address.name,
    address: address.address,
    fail: (err) => {
      console.error('打开地图失败:', err);
      uni.showToast({
        title: '打开地图失败',
        icon: 'none'
      });
    }
  });
  
  // 更新store中的坐标（只设置目标位置）
  studioStore.setCoordinate({
    latitude: Number(address.latitude),
    longitude: Number(address.longitude)
  });
}
</script>

<script>
export default {
  onShareAppMessage() {
    return {
      title: '科石',
      path: "/pages/home/home"
    }
  },
  onShareTimeline() {
    return {
      title: '科石',
    }
  }
}
</script>

<style lang="scss">
/* 原有样式保持不变 */
.swiper {
  width: 100%;
  height: 40vh;
}
.swiper-item {
  display: block;
  width: 100%;
  height: 100%;
}
.swiper-item img {
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}
.swiper {
  position: relative;
}
.swiper .swiper-indicators {
  bottom: 20rpx;
}

.enterpriseDetail {
  padding: 20rpx;
}
.scroll-item {
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  margin-bottom: 30rpx;
  padding: 20rpx;
}
.name {
  font-size: 36rpx;
  font-weight: bold;
  color: #c84921;
  margin-bottom: 10rpx;
}
.address, .phone {
  display: flex;
  align-items: center;
  margin-bottom: 15rpx;
  font-size: 28rpx;
  color: #737373;
}
.address_img, .phone_img {
  width: 40rpx;
  height: 40rpx;
  margin-right: 20rpx;
}
.address_text, .phone_text {
  flex: 1;
}
.right_arrow_img {
  width: 40rpx;
  height: 40rpx;
}

.phone_text a {
  color: #c84921;
  text-decoration: none;
}
.scroll-item:hover {
  background-color: #f9f9f9;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
}

.address, .phone {
  color: #555;
}
.scroll-item {
  background-color: #f9f9f9;
}
.name {
  color: #c84921;
}

.phone_numbers {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  flex: 1;
}

.phone_text {
  display: flex;
  align-items: center;
  margin-right: 10rpx;
}

.phone_separator {
  width: 20rpx;
  height: 20rpx;
  margin: 0 10rpx;
}

/* 新增地址点击效果 */
.address {
  cursor: pointer;
  &:active {
    opacity: 0.7;
  }
}
</style>