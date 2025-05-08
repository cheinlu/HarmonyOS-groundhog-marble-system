<template>
  <el-card style="height: 70px">
    <el-form :inline="true" class="form">
      <el-form-item label="家居名称">
        <el-input placeholder="家居名称" v-model="name"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="search" :disabled="name ? false : true">{{ $t('button.search') }}</el-button>
        <el-button type="primary" @click="reset">{{ $t('button.reset') }}</el-button>
      </el-form-item>
    </el-form>
  </el-card>
  <el-card style="margin: 10px 0px">
    <el-button type="primary" size="default" @click="addStation" v-has="'ChargeStationAdd'">添加家居</el-button>
    <!-- table展示家居信息 -->
    <el-table style="margin: 10px 0px" border :data="slabArr">
      <el-table-column label="#" align="center" type="index"></el-table-column>
      <el-table-column label="名称" align="center" prop="name" show-overflow-tooltip></el-table-column>
      <el-table-column label="类别" align="center" prop="sn" show-overflow-tooltip></el-table-column>
      <el-table-column label="价格" align="center" prop="price" show-overflow-tooltip></el-table-column>
      <el-table-column label="描述" align="center" prop="remark" show-overflow-tooltip></el-table-column>
      <el-table-column label="图片"  align="center" show-overflow-tooltip>
        <template #default="scope">
            <el-image :src="scope.row.pictureUrls"></el-image>
        </template>
    </el-table-column>
      
      <el-table-column :label="$t('tabel.operate')" width="180px" align="center">
        <template #="{ row }">
          <el-button type="primary" size="small" icon="Edit" @click="updateStation(row)" v-has="'ChargeStationUpdate'">{{ $t('button.edit') }}</el-button>
          <el-popconfirm :title="`你确定要删除${row.name}?`" @confirm="deleteStation(row.id)" width="260px">
            <template #reference>
              <el-button type="primary" size="small" icon="Delete" v-has="'ChargeStationDel'">{{ $t('button.delete') }}</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页器-->
    <el-pagination v-model:current-page="pageNo" v-model:page-size="pageSize" :page-sizes="[10000]" :background="true" layout="prev, pager, next, jumper,->,sizes,total" :total="total" @current-change="getMarbles" @size-change="handler" />
  </el-card>
  <!-- 抽屉结构:完成添加新的用户账号|更新已有的账号信息 -->
  <el-drawer v-model="drawer" size="50%" @close="handleDrawerClose">
    <!-- 头部标题:将来文字内容应该动态的 -->
    <template #header>
      <h4>{{ $t(chargeForm.id ? '修改家居' : '添加家居') }}</h4>
    </template>
    <!-- 身体部分 -->
    <template #default>
      <el-form :model="chargeForm" ref="chargeFormRef" :rules="chargeRules" label-width="80px">
        <el-form-item label="名称" prop="name">
          <el-input placeholder="名称" v-model="chargeForm.name"></el-input>
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input placeholder="价格" v-model="chargeForm.price"></el-input>
        </el-form-item>
        <el-form-item label="描述" prop="remark">
          <el-input placeholder="描述" v-model="chargeForm.remark"></el-input>
        </el-form-item>
        <el-form-item label="类别" prop="sn">
        <el-select v-model="chargeForm.sn" placeholder="类别">
          <el-option v-for="item in snArr" :key="item.id" :label="item.name" :value="item.name"></el-option>
        </el-select>
      </el-form-item>
        <el-form-item label="图片" prop="pictureUrls">
          <el-upload class="avatar-uploader" :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUploadHouse">
            <img v-if="chargeForm.pictureUrls" :src="chargeForm.pictureUrls" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
          <el-upload class="avatar-uploader" :show-file-list="false" :on-success="handleAvatarSuccess1" :before-upload="beforeAvatarUploadHouse1">
            <img v-if="chargeForm.pictureUrls1" :src="chargeForm.pictureUrls1" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
          <el-upload class="avatar-uploader" :show-file-list="false" :on-success="handleAvatarSuccess2" :before-upload="beforeAvatarUploadHouse2">
            <img v-if="chargeForm.pictureUrls2" :src="chargeForm.pictureUrls2" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
          <el-upload class="avatar-uploader" :show-file-list="false" :on-success="handleAvatarSuccess3" :before-upload="beforeAvatarUploadHouse3">
            <img v-if="chargeForm.pictureUrls3" :src="chargeForm.pictureUrls3" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
        </el-form-item>
      </el-form>
    </template>
    <template #footer>
      <div style="flex: auto">
        <el-button @click="cancel">{{ $t('pop.cancel') }}</el-button>
        <el-button type="primary" @click="openSpecDrawer">{{ '完善更多信息' }}</el-button>
      </div>
    </template>
  </el-drawer>

   <!-- 第二个抽屉（规格信息） -->
   <el-drawer v-model="specDrawer" size="45%" direction="rtl" @close="handleSpecDrawerClose">
    <template #header>
      <h4>完善规格信息</h4>
    </template>
    <template #default>
      <el-form :model="chargeForm.skus" ref="specFormRef" :rules="specRules" label-width="65px">
        <div v-for="(spec, index) in chargeForm.skus" :key="index" class="spec-row">
          <el-form-item 
            label="规格" 
            :prop="`skus[${index}].size`"
          >
            <el-input v-model="spec.size" placeholder="如：60*60" style="width: 200px"></el-input>
          </el-form-item>
          <el-form-item 
            label="价格" 
            :prop="`skus[${index}].price`"
          >
            <el-input v-model="spec.price" placeholder="0.00" style="width: 150px">
              <template #append>元</template>
            </el-input>
          </el-form-item>
          <div class="action-buttons">
            <el-button 
              v-if="index > 0"
              type="danger" 
              icon="Delete" 
              size="small"
              @click="removeSpec(index)"
            />
            <el-button 
              v-if="chargeForm.skus && index === chargeForm.skus.length - 1"
              type="primary" 
              icon="Plus" 
              size="small"
              @click="addSpec"
            />
          </div>
        </div>
      </el-form>
    </template>
    <template #footer>
      <div style="flex: auto">
        <el-button @click="specDrawer = false">返回</el-button>
        <el-button type="primary" @click="saveAll">完成</el-button>
      </div>
    </template>
  </el-drawer>


</template>

<script setup lang="ts">
import { ref, onMounted, reactive, nextTick } from 'vue'
import useLayOutSettingStore from '@/store/module/setting'
import { ElMessage } from 'element-plus'
import type { UploadProps } from 'element-plus'

import {reqMarbles,reqAddOrUpdateMarbles,reqRemoveMarbles,reqUploadMarbles} from '@/api/marble/index'
import type {marbleList,marbles,marbleAddOrUpdate} from '@/api/marble/type'

// 新增的状态
const specDrawer = ref(false)
const specFormRef = ref()

// 打开规格抽屉
const openSpecDrawer = async () => {
  try {
    await chargeFormRef.value.validate()
    
    // 确保 skus 存在且至少有一条记录
    if (!chargeForm.skus || chargeForm.skus.length === 0) {
      chargeForm.skus = reactive([{
        size: '', 
        price: 0, 
      }])
    }
    
    specDrawer.value = true
  } catch (error) {
    ElMessage.error('请先填写完整的基本信息')
  }
}

// 添加规格行
const addSpec = () => {
  chargeForm.skus?.push({
    size: '',
    price: 0,
  })

};

// 删除规格行
const removeSpec = (index: number) => {
  if (chargeForm.skus&&chargeForm.skus.length > 1) {
    chargeForm.skus.splice(index, 1)

  }
}

// 保存所有信息
const saveAll = async () => {
  try {
    // 验证规格表单
    await specFormRef.value.validate();
    
    // 检查是否有空数据
    const hasEmptySpec = chargeForm.skus?.some(spec => 
      !spec.size || spec.price === null || spec.price === undefined
    )
    
    if (hasEmptySpec) {
      ElMessage.error('请填写完整的规格信息')
      return
    }
    
    // 合并所有数据
    const formData = {
      ...chargeForm,
    }
    
    // 提交到服务器
    let res: any = await reqAddOrUpdateMarbles(formData)
    
    if (res.code == 0) {
      ElMessage.success(chargeForm.id ? '修改成功' : '添加成功')
      // 关闭所有抽屉
      drawer.value = false
      specDrawer.value = false
      // 刷新数据
      getMarbles()
    }
  } catch (error) {
    ElMessage.error('请填写完整的规格信息')
  }
}

// 规格抽屉关闭时的回调
const handleSpecDrawerClose = () => {
  // 重置规格表单
  chargeForm.skus = [{
    size: '', 
    price: 0, 
  }]
  // 清除验证
  nextTick(() => {
    specFormRef.value?.clearValidate()
  })
}


let settingStore = useLayOutSettingStore()

let chargeFormRef = ref()
//默认页码
let pageNo = ref<number>(1)
//一页展示几条数据
let pageSize = ref<number>(1000)
//type类型
let type = ref<string>('shopping')
//存储大板数据
let slabArr = ref<marbles>([])
//用户总个数
let total = ref<number>(0)
//抽屉默认关闭
let drawer = ref<boolean>(false)
//家居名
let name = ref('')

let snArr = reactive([
  {name:'餐桌',id:1},
  {name:'茶几',id:2},
  {name:'茶泡台',id:3},
  {name:'托盘',id:4}
])

//抽屉关闭的回调函数
let handleDrawerClose = ()=>{
  
  // 重置表单数据
  Object.assign(chargeForm, {
    sn: '',
    name: '',
    pictureUrls: '',
    pictureUrls1: '',
    pictureUrls2: '',
    pictureUrls3: '',
    price: null,
    width: null,
    length: null,
    height: null,
    area: null,
    remark: '',
    id: 0, // 确保 id 被重置为 0
    type: 'shopping',
  });
}

//站点信息的收集
let chargeForm = reactive<marbleAddOrUpdate>({
  type:'shopping',
  sn: '',
    name: '',
    pictureUrls:'',
    pictureUrls1:'',
    pictureUrls2:'',
    pictureUrls3:'',
    price:0,
    width:0,
    length:0,
    height:0,
    area:0,
  id: 0,
  remark:'',
  skus:[]
})
onMounted(() => {
  getMarbles()
})

//获取大板列表数据

let getMarbles = async (pager = 1) => {
  pageNo.value = pager
  let res: marbleList = await reqMarbles(pageNo.value, pageSize.value, name.value,type.value)
  
  if (res.code == 0) {
    slabArr.value = res.data.List
    pageNo.value = res.data.PageNo
    pageSize.value = res.data.PageSize
    total.value = res.data.TotalCount
  }
}


//分页器下拉菜单的自定义事件的回调
let handler = () => {
  
  getMarbles(pageNo.value)
}

//搜索按钮的回调
let search = () => {
  getMarbles()
  name.value = ''
}

//重置按钮的回调
let reset = () => {
  settingStore.refsh = !settingStore.refsh
}

//添加家居按钮
let addStation = () => {
  //打开抽屉
  drawer.value = true

  //清空上一次表单校验错误提示
  nextTick(() => {
    chargeFormRef.value.clearValidate('sn')
    chargeFormRef.value.clearValidate('name')
    chargeFormRef.value.clearValidate('pictureUrls')
    chargeFormRef.value.clearValidate('pictureUrls1')
    chargeFormRef.value.clearValidate('pictureUrls2')
    chargeFormRef.value.clearValidate('pictureUrls3')
    chargeFormRef.value.clearValidate('price')
    chargeFormRef.value.clearValidate('width')
    chargeFormRef.value.clearValidate('length')
    chargeFormRef.value.clearValidate('height')
    chargeFormRef.value.clearValidate('area')
    chargeFormRef.value.clearValidate('remark')
  })
}
//修改家居按钮
let updateStation = (row: any) => {
  //打开抽屉
  drawer.value = true
  //合并参数
  Object.assign(chargeForm, row)
 
   //清空上一次表单校验错误结果
   nextTick(() => {
    chargeFormRef.value.clearValidate('sn')
    chargeFormRef.value.clearValidate('name')
    chargeFormRef.value.clearValidate('pictureUrls')
    chargeFormRef.value.clearValidate('pictureUrls1')
    chargeFormRef.value.clearValidate('pictureUrls2')
    chargeFormRef.value.clearValidate('pictureUrls3')
    chargeFormRef.value.clearValidate('price')
    chargeFormRef.value.clearValidate('width')
    chargeFormRef.value.clearValidate('length')
    chargeFormRef.value.clearValidate('height')
    chargeFormRef.value.clearValidate('area')
    chargeFormRef.value.clearValidate('remark')
  })
}
//删除家居按钮
let deleteStation = async (id: number) => {
  let res: any = await reqRemoveMarbles(id)
  if (res.code == 0) {
    ElMessage({ type: 'success', message: '删除站点成功' })
    getMarbles(slabArr.value.length > 1 ? pageNo.value : pageNo.value - 1)
  }
}
//点击添加|修改家居抽屉的取消按钮
let cancel = () => {
  //重新刷新，清空表单数据
  settingStore.refsh = !settingStore.refsh
  //关闭抽屉
  drawer.value = false
}

//校验规则
let chargeRules = {
  name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
  sn: [{ required: true, message: '请选择类别', trigger: 'change' }],
  width: [{ required: true, message: '请输入宽度', trigger: 'blur' }],
  height: [{ required: true, message: '请输入高度', trigger: 'blur' }],
  length: [{ required: true, message: '请输入长度', trigger: 'blur' }],
  price: [{ required: true, message: '请输入价格', trigger: 'blur' }],
  area: [{ required: true, message: '请输入面积', trigger: 'blur' }],
  pictureUrls: [{ required: true, message: '请上传图片', trigger: 'blur' }],
  remark: [{ required: true, message: '请输入描述', trigger: 'blur' }],
}

let specRules = {
  'skus': [
    { type: 'array', required: true, message: '请至少添加一个规格', trigger: 'blur' }
  ],
  'skus.size': [
    { type: 'array', defaultField: { required: true, message: '请输入规格' }, trigger: 'blur' }
  ],
  'skus.price': [
    { type: 'array', defaultField: { required: true, message: '请输入价格' }, trigger: 'blur' }
  ]
};

//图片上传成功的钩子
const handleAvatarSuccess: UploadProps['onSuccess'] = () => {
  chargeFormRef.value.clearValidate('pictureUrls')
}
//上传图片组件->上传图片之前触发的钩子函数
const beforeAvatarUploadHouse: UploadProps['beforeUpload'] = async (rawFile: any) => {
    // 通过校验后执行上传
    const res:any = await reqUploadMarbles(rawFile);
    if(res.code == 0){
      chargeForm.pictureUrls = res.data.url;
    }else{
      ElMessage.error(res.message)
    }
    return false; // 阻止默认上传行为
}

//图片上传成功的钩子
const handleAvatarSuccess1: UploadProps['onSuccess'] = () => {
  chargeFormRef.value.clearValidate('pictureUrls1')
}
//上传图片组件->上传图片之前触发的钩子函数
const beforeAvatarUploadHouse1: UploadProps['beforeUpload'] = async (rawFile: any) => {
    // 通过校验后执行上传
    const res:any = await reqUploadMarbles(rawFile);
    if(res.code == 0){
      chargeForm.pictureUrls1 = res.data.url;
    }else{
      ElMessage.error(res.message)
    }
    return false; // 阻止默认上传行为
}

//图片上传成功的钩子
const handleAvatarSuccess2: UploadProps['onSuccess'] = () => {
  chargeFormRef.value.clearValidate('pictureUrls2')
}
//上传图片组件->上传图片之前触发的钩子函数
const beforeAvatarUploadHouse2: UploadProps['beforeUpload'] = async (rawFile: any) => {
    // 通过校验后执行上传
    const res:any = await reqUploadMarbles(rawFile);
    if(res.code == 0){
      chargeForm.pictureUrls2 = res.data.url;
    }else{
      ElMessage.error(res.message)
    }
    return false; // 阻止默认上传行为
}

//图片上传成功的钩子
const handleAvatarSuccess3: UploadProps['onSuccess'] = () => {
  chargeFormRef.value.clearValidate('pictureUrls3')
}
//上传图片组件->上传图片之前触发的钩子函数
const beforeAvatarUploadHouse3: UploadProps['beforeUpload'] = async (rawFile: any) => {
    // 通过校验后执行上传
    const res:any = await reqUploadMarbles(rawFile);
    if(res.code == 0){
      chargeForm.pictureUrls3 = res.data.url;
    }else{
      ElMessage.error(res.message)
    }
    return false; // 阻止默认上传行为
}

</script>
<script lang="ts">
export default {
  name: '家居'
}
</script>
<style scoped>
.spec-row {
  display: flex;
  align-items: flex-start;
  margin-bottom: 18px;
}

.spec-row :deep(.el-form-item) {
  margin-bottom: 0;
  margin-right: 10px;
}

.action-buttons {
  display: flex;
  align-items: center;
  height: 32px;
  margin-top: 4px;
}

.action-buttons .el-button {
  margin-left: 8px;
}



.form {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
/* 地图容器必须设置宽和高属性 */
.map {
  width: 600px;
  height: 400px;
}
.avatar-uploader .avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
<style>
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  text-align: center;
}
</style>

