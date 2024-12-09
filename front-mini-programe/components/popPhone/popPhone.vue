<template>
  <!--弹框信息确认-->
  <u-popup :show="show" mode="bottom" closeable @close="confim">
    <view class="pop-contain">
      <view class="phone">
        400-0000-863
		<image class="image" src="/static/images/right_arrow.png" mode=""></image>
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

</script>

<style lang="scss">
	.pop-contain{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		border-top-left-radius: 20rpx;
	}
	.phone{
		width: 100vw;
		height: 260rpx;
		line-height: 300rpx;
		text-align: center;
		display: flex;
		flex-direction: column;
		.image{
			width: 55rpx;
			height: 55rpx;
		}
	}
	.confim{
		width: 600rpx;
		height: 80rpx;
		line-height: 80rpx;
		border-radius: 20rpx;
		text-align: center;
		background-color: #dddddd;
		font-size: 30rpx;
		margin-bottom: 30rpx;
	}
</style>