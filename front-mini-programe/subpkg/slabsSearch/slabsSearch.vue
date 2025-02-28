<template>
	<view class="box">
		<view>
		<!-- 搜索区域 -->
		   <view class="search-box">
		   			 <image class="raw-img" src="/static/images/furniture-topimg.png" mode=""></image>
		        <uni-search-bar class="raw-bar" placeholder="点击快速搜索商品" @input="handleInput" radius="20" bgColor="#fff"  cancelButton="none"></uni-search-bar>
		      </view>
			<!-- 产品区域 -->
			<view class="guess">
			  <view
			    class="guess-item"
			    v-for="item in (propId == 'slab' ? slabSearchList : rawSearchList)"
			    :key="item.sn"
				@click="goDetail(item)"
			  >
			    <image
			      class="image"
			      mode="aspectFill"
			      :src="item.pictureUrls"
				  @click="previewImage(item.pictureUrls)"
			    ></image>
				  <view class="nameInfo">{{item.sn}}</view>
			    <view class="name"> {{item.name}} </view>
			    <view class="price">
					
				<text class="small" v-if="propId == 'slab'">{{item.layers.length}}匝/{{item.slices_total}}片/{{item.area}}㎡</text>
		
				<text class="small" v-else>{{item.width}}mm x {{item.height}}mm x {{item.length}}mm x {{item.area}}t x {{item.mass}}m³</text>
				
			    </view>
				  
			  </view>
			</view>
		</view>
	</view>
</template>
   
<script setup>
import { reactive, ref ,onMounted} from 'vue';
import {onLoad} from '@dcloudio/uni-app'
import {requestMarblesList,requestCommonList} from '@/utils/api/marble.js'
let pageNum = ref(1)
let pageSize = ref(1000)
let kw = ref('')
let timer = ref(null)
let slabSearchList = ref([]) //大板数据
let rawSearchList = ref([])
let propId = ref('0')

const previewImage = (pictureUrls)=>{
	if(propId.value == 'raw'){
		uni.previewImage({
			  current:pictureUrls,
			  urls:[pictureUrls],
		});
	}
}

onLoad((option)=>{
	//接收一级页面传递过来的数据
	propId.value = option.id
	kw.value = option.name
})

onMounted(()=>{
	getMarbleList()
	getRawList()
})
//获取名称列表
const getMarbleList = async()=>{
	let {data:res} = await requestMarblesList(kw.value,pageNum.value,pageSize.value)
	if(res.code==0){
		slabSearchList.value = res.data.List
	}
}

const getRawList = async()=>{
	let {data:res} = await requestCommonList(kw.value,'marble',pageNum.value,pageSize.value)
	if(res.code==0){
		rawSearchList.value = res.data.List
	}
}

//点击去详情页
const goDetail = (item)=>{
	//如果是大板页点击才去详情
	if(propId.value == 'slab'){
		uni.navigateTo({
			 url: '/subpkg/slabsDetail/slabsDetail?item=' + encodeURIComponent(JSON.stringify(item))
		})
	}
}

const handleInput = (keyword) => {
  if (kw.value !== keyword) {
    kw.value = keyword
    //清除timer对应的定时器
    clearTimeout(timer.value)
    //重启一个延时器，并把timerid赋值给timer
    timer.value = setTimeout(() => {
      // 对关键词进行解码
      let decodedKeyword = decodeURIComponent(keyword)
      //根据关键词，查询搜索建议列表
	  if(propId.value == 'slab'){
		  getMarbleList({ params: { name: decodedKeyword } })
	  }else{
		  getRawList({params: { name: decodedKeyword }})
	  }
      
    }, 600)
  }
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
	.search-box {
	    position: sticky;
	    top: 0;
	    z-index: 999;
		height: 300rpx;
		.raw-img{
			width: 100vw;
		height: 300rpx;	
		position: relative;
		}
		.raw-bar{
			width: 100%;
			 position: absolute; 
			 bottom: 20rpx;
			 left: 0;
		}
	  }
	  .guess {
	  	margin-top: 50rpx;
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
	      margin: 20rpx;
	      font-size: 30rpx;
	      color: #262626;
	      overflow: hidden;
	      text-overflow: ellipsis;
	      display: -webkit-box;
	      -webkit-line-clamp: 2;
	      -webkit-box-orient: vertical;
	    }
	    .price {
	      line-height: 1;
	      padding-top: 4rpx;
	      color: #cf4444;
	      font-size: 30rpx;
	  	margin: 20rpx;
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
