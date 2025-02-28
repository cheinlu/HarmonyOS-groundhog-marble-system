<template>
  <view class="">
	<view v-if="isContentVisible" class="home-container">
		<view class="ImageView">
			<image class="bg-image" src="/static/images/furniture-topimg.png"></image>
		</view>
		<scroll-view class="scrollView" scroll-y="true"  @scrolltolower="loadNextPage" :scroll-top="scrollTop"  ref="scrollView">
			<view class="scroll-item" v-for="slabs in slabsList" :key="slabs.id" @click="gotoSearch(slabs.name)">
				<view class="left-title">
					{{slabs.name}}
				</view>
				<view class="right-image-view">
					<image class="right-image" :src="slabs.pictureUrl"></image>
				</view>
			</view>
			</scroll-view>
	
	<!-- 跳转搜索 -->
	</view>
  
  <view v-else class="login_card">
  	<uni-forms class="forms" :model="form" ref="formRole">
  		<uni-forms-item name="password" :rules="[{ required: true, errorMessage: '请输入登入密码' }]">
  		<view class="input-btn">
  			<input prefixIcon="locked-filled" type="password" v-model="form.password" placeholder="请输入密码" />
  		</view>
  		</uni-forms-item>
  		<view @click="submit" class="dr-btn">登入</view>
  	</uni-forms>
  </view>
  </view>
</template>

<script setup>
import { ref, onMounted, reactive } from 'vue'
import {requestMarbleList,requestPassword} from '@/utils/api/marble.js'
import {onLoad,onShow,onHide} from '@dcloudio/uni-app'
let windowHeight = ref(0)
let pageNum = ref(1)
let pageSize = ref(1000)
let slabsList = ref([])
let isContentVisible = ref(false)
const formRole = ref<any>(null);
const form = reactive({
	password: '',
});

const requestPwd = ref('') //接收接口获取的密码


const getRawPassword = async()=>{
	let {data:res} = await requestPassword()
	if(res.code==0){
		requestPwd.value = res.data.password
	}
}

const submit = async () => {
	formRole.value.validate().then(async () => {
	if(form.password === requestPwd.value){
		isContentVisible.value = true
	}else{
		uni.showToast({
			title:'密码错误',
			icon:'none'
		})
	}
	});
};

onLoad(()=>{
	isContentVisible.value = false
})
onShow(()=>{
	isContentVisible.value = false
})
onHide(()=>{
	isContentVisible.value = false
})
//组件挂载
onMounted(() => {
  let sysInfo = uni.getSystemInfoSync()
   windowHeight.value = sysInfo.windowHeight - 50
   
   getMarblesList()
   
   getRawPassword()

})

//获取大理石名称列表数据
const getMarblesList = async()=>{
  let {data:res} = await requestMarbleList(pageNum.value,pageSize.value)
  if(res.code==0){
	 slabsList.value = res.data.List
  }
}

let gotoSearch=(name)=>{
	let url = '/subpkg/slabsSearch/slabsSearch?id=' + 'raw' + '&name=' + name
	uni.navigateTo({
		url
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
<style lang="scss" scoped>
	.login_card {
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  padding: 40rpx 30rpx;
	}
	
	.input-btn {
	  width: 100%;
	  border: 1px solid #ccc;
	  border-radius: 8px; /* 圆角 */
	  height: 80rpx;
	  margin-bottom: 20rpx; /* 输入框和按钮之间的间距 */
	  padding: 0 20rpx; /* 增加左右内边距 */
	}
	
	.input-btn input {
	  width: 100%;
	  height: 100%;
	  padding-left: 40rpx; /* 给输入框的文字添加左边距 */
	  font-size: 28rpx; /* 输入框字体大小 */
	  border: none;
	  outline: none;
	  box-sizing: border-box;
	  background-color: #f9f9f9;
	  border-radius: 8px; /* 圆角 */
	}
	
	.dr-btn {
	  width: 100%;
	  background-color: #c84921; /* 新的按钮背景色 */
	  color: #fff;
	  border-radius: 8px; /* 圆角 */
	  height: 70rpx;
	  line-height: 70rpx;
	  font-size: 30rpx;
	  text-align: center;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  cursor: pointer;
	  margin-top: 20rpx; /* 按钮上边距 */
	  box-shadow: 0 4rpx 10rpx rgba(0, 0, 0, 0.1); /* 按钮阴影 */
	}
	
	.dr-btn:hover {
	  background-color: #a23e17; /* 悬停时按钮颜色稍微加深 */
	}
	
	.dr-btn:active {
	  background-color: #832e12; /* 点击时按钮颜色进一步加深 */
	}
.home-container{
	background-color: #f7f7f7;
	  width: 100vw;
	  height: 100vh;
	.ImageView{
		
		.bg-image{
			width: 100vw;
			height: 140px;
			 margin-bottom: 10rpx;
		}
	}  
	.scroll-item{
		background-color: #ffffff;
		    margin: 10rpx 20rpx ;
		    font-size: 20rpx;
		    border-radius: 15rpx;
			display: flex;
			justify-content: space-between;
			align-items: center;
		.left-title{
			width: 40%;
			height: 100rpx;
			line-height: 100rpx;
			text-align: center;
			font-size: 35rpx;
		}
		.right-image-view{
			width: 70%;
			height: 100%;
			margin-top: 20rpx;
			
			
			.right-image{
				width: 100%;
				height: 180rpx;
				box-shadow:2px 2px 2px 2px rgba(0, 0, 0, 0.1);
			}
		}
	}
}
</style>