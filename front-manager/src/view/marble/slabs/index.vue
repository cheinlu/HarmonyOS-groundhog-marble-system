<template>
  <el-card style="height: 70px">
    <el-form :inline="true" class="form">
      <el-form-item label="大板名称">
        <el-input placeholder="大板名称" v-model="name"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="search" :disabled="name ? false : true">{{ $t('button.search') }}</el-button>
        <el-button type="primary" @click="reset">{{ $t('button.reset') }}</el-button>
      </el-form-item>
    </el-form>
  </el-card>
  <el-card style="margin: 10px 0px">
    <el-button type="primary" size="default" @click="addStation" v-has="'ChargeStationAdd'">添加大板(入库)</el-button>
    <!-- table展示充电站信息 -->
    <el-table style="margin: 10px 0px" border :data="slabArr">
      <el-table-column label="#" align="center" type="index"></el-table-column>
      <el-table-column label="名称" align="center" prop="name" show-overflow-tooltip></el-table-column>
      <el-table-column label="编号" align="center" prop="sn" show-overflow-tooltip></el-table-column>
      <el-table-column label="宽度(mm)" align="center" prop="width" show-overflow-tooltip></el-table-column>
      <el-table-column label="高度(mm)" align="center" prop="height" show-overflow-tooltip></el-table-column>
      <el-table-column label="长度(mm)" align="center" prop="length" show-overflow-tooltip></el-table-column>
      <el-table-column label="面积(㎡)" align="center" prop="area" show-overflow-tooltip></el-table-column>
      <el-table-column label="出库状态" align="center" prop="description" show-overflow-tooltip></el-table-column>
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
    <el-pagination v-model:current-page="pageNo" v-model:page-size="pageSize" :page-sizes="[1000]" :background="true" layout="prev, pager, next, jumper,->,sizes,total" :total="total" @current-change="getMarbles" @size-change="handler" />
  </el-card>
  <!-- 抽屉结构:完成添加新的用户账号|更新已有的账号信息 -->
  <el-drawer v-model="drawer" size="50%">
    <!-- 头部标题:将来文字内容应该动态的 -->
    <template #header>
      <h4>{{ $t(chargeForm.id ? 'equip.editStation' : 'equip.addStation') }}</h4>
    </template>
    <!-- 身体部分 -->
    <template #default>
      <el-form :model="chargeForm" ref="chargeFormRef" :rules="chargeRules" label-width="90px">
        <el-form-item label="名称" prop="name">
          <el-input placeholder="名称" v-model="chargeForm.name"></el-input>
        </el-form-item>
        <el-form-item label="编号" prop="sn">
          <el-input placeholder="编号" v-model="chargeForm.sn"></el-input>
        </el-form-item>
        <el-form-item label="宽度(mm)" prop="width">
          <el-input placeholder="宽度" v-model="chargeForm.width"></el-input>
        </el-form-item>
        <el-form-item label="高度(mm)" prop="height">
          <el-input placeholder="高度" v-model="chargeForm.height"></el-input>
        </el-form-item>
        <el-form-item label="长度(mm)" prop="length">
          <el-input placeholder="长度" v-model="chargeForm.length"></el-input>
        </el-form-item>
        <el-form-item label="面积(㎡)" prop="area">
          <el-input placeholder="面积" v-model="chargeForm.area"></el-input>
        </el-form-item>
        <el-form-item label="出库状态" prop="description">
        <el-select v-model="chargeForm.description" placeholder="出库状态">
          <el-option v-for="item in descriptionArr" :key="item.id" :label="item.name" :value="item.name"></el-option>
        </el-select>
      </el-form-item>
        <el-form-item label="图片" prop="pictureUrls">
          <el-upload class="avatar-uploader" :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload">
            <img v-if="chargeForm.pictureUrls" :src="chargeForm.pictureUrls" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
        </el-form-item>
      </el-form>
    </template>
    <template #footer>
      <div style="flex: auto">
        <el-button @click="cancel">{{ $t('pop.cancel') }}</el-button>
        <el-button type="primary" @click="save">{{ $t('pop.confirm') }}</el-button>
      </div>
    </template>
  </el-drawer>

  <el-dialog v-model="dialogVisible">
    <img w-full :src="dialogImageUrl" alt="Preview Image" />
  </el-dialog>

</template>

<script setup lang="ts">
import { ref, onMounted, reactive, nextTick } from 'vue'
import { Delete, Download, Plus, ZoomIn } from '@element-plus/icons-vue'

import useLayOutSettingStore from '@/store/module/setting'
import { ElMessage } from 'element-plus'
import type { UploadProps } from 'element-plus'

import {reqMarbles,reqAddOrUpdateMarbles,reqRemoveMarbles,reqUploadMarbles} from '@/api/marble/index.ts'
import type {marbleList,marbles,marbleAddOrUpdate} from '@/api/marble/type'

const dialogImageUrl = ref('')
const dialogVisible = ref(false)
const disabled = ref(false)


let settingStore = useLayOutSettingStore()

let chargeFormRef = ref()
//默认页码
let pageNo = ref<number>(1)
//一页展示几条数据
let pageSize = ref<number>(1000)
//type类型
let type = ref<string>('slice')
//存储大板数据
let slabArr = ref<marbles>([])
//用户总个数
let total = ref<number>(0)
//抽屉默认关闭
let drawer = ref<boolean>(false)
//充电站名
let name = ref('')
let descriptionArr = reactive([
  {name:'销售出库',id:1},
  {name:'未出库',id:2}
])


//站点信息的收集
let chargeForm = reactive<marbleAddOrUpdate>({
  type:'slice',
  sn: '',
    name: '',
    pictureUrls:'',
    price:0,
    width:0,
    length:0,
    height:0,
    area:0,
  id: 0,
  description:''
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

//添加充电站按钮
let addStation = () => {
  //打开抽屉
  drawer.value = true

  //清空表单数据
  Object.assign(chargeForm, {
    sn: '',
    name: '',
    pictureUrls:'',
    price:null,
    width:null,
    length:null,
    height:null,
    area:null,
    description:''
  })
  //清空上一次表单校验错误提示
  nextTick(() => {
    chargeFormRef.value.clearValidate('sn')
    chargeFormRef.value.clearValidate('name')
    chargeFormRef.value.clearValidate('pictureUrls')
    chargeFormRef.value.clearValidate('price')
    chargeFormRef.value.clearValidate('width')
    chargeFormRef.value.clearValidate('length')
    chargeFormRef.value.clearValidate('height')
    chargeFormRef.value.clearValidate('area')
    chargeFormRef.value.clearValidate('description')
  })
}
//修改充电站按钮
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
    chargeFormRef.value.clearValidate('price')
    chargeFormRef.value.clearValidate('width')
    chargeFormRef.value.clearValidate('length')
    chargeFormRef.value.clearValidate('height')
    chargeFormRef.value.clearValidate('area')
    chargeFormRef.value.clearValidate('description')
  })
}
//删除充电站按钮
let deleteStation = async (id: number) => {
  let res: any = await reqRemoveMarbles(id)
  if (res.code == 0) {
    ElMessage({ type: 'success', message: '删除站点成功' })
    getMarbles(slabArr.value.length > 1 ? pageNo.value : pageNo.value - 1)
  }
}
//点击添加|修改充电站抽屉的取消按钮
let cancel = () => {
  //重新刷新，清空表单数据
  settingStore.refsh = !settingStore.refsh
  //关闭抽屉
  drawer.value = false
}
//点击添加|修改充电站抽屉的确定按钮
let save = async () => {
  //表单校验合格再发请求
  await chargeFormRef.value.validate()
  let res: any = await reqAddOrUpdateMarbles(chargeForm)
  
  if (res.code == 0) {
    //抽屉关闭
    drawer.value = false
    //提示添加成功
    ElMessage({ type: 'success', message: chargeForm.id ? '修改充电站成功' : '添加充电站成功' })
    //获取数据
    getMarbles()
  } else {
    //抽屉关闭
    drawer.value = false
    ElMessage({ type: 'error', message: chargeForm.id ? '修改充电站失败' : '添加充电站失败' })
  }
}

//校验规则
let chargeRules = {
  name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
  sn: [{ required: true, message: '请输入编号', trigger: 'blur' }],
  width: [{ required: true, message: '请输入宽度', trigger: 'blur' }],
  height: [{ required: true, message: '请输入高度', trigger: 'blur' }],
  length: [{ required: true, message: '请输入长度', trigger: 'blur' }],
  price: [{ required: true, message: '请输入价格', trigger: 'blur' }],
  area: [{ required: true, message: '请输入面积', trigger: 'blur' }],
  pictureUrls: [{ required: true, message: '请上传图片', trigger: 'blur' }],
  description:[{ required: true, message: '请选择入库状态', trigger: 'change' }],
}

//图片上传成功的钩子
const handleAvatarSuccess: UploadProps['onSuccess'] = () => {
  chargeFormRef.value.clearValidate('pictureUrls')
}
//上传图片组件->上传图片之前触发的钩子函数
const beforeAvatarUpload: UploadProps['beforeUpload'] = async (rawFile: any) => {
  
  //请求上传文件的接口
  let res = await reqUploadMarbles(rawFile)
  
  //将接口的地址赋值给表单并呈现
  chargeForm.pictureUrls = res.data.url
 
  return true
}

</script>
<script lang="ts">
export default {
  name: '大板'
}
</script>
<style scoped>
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

