export class furnitureData {
  data?: furnitureBean
  code?: number
  message?: string
}

export class furnitureBean {
  PageNo?: number
  PageSize?: number
  TotalCount?: number
  List?: furnitureObj[]
}

export class furnitureObj {
  area?: number
  description?: string
  height?: number
  id?: number
  length?: number
  mass?: number
  name?: string
  pictureUrls?: string
  pictureUrls1?: string
  pictureUrls2?: string
  pictureUrls3?: string
  pictureUrls4?: string
  pictureUrls5?: string
  price?: number
  remark?: string
  sn?: string
  state?: number
  type?: string
  width?: number
  skus?: skusObj[]
}

export class skusObj {
  sku_id?: number
  size?: string
  price?: number
}


export class CategoryLevelModel {
  id?: number
  title?: string
  titleEn?: string
}

const categoryList: Array<CategoryLevelModel> = [
  { id: 0, title: '全部', titleEn: 'All' },
  { id: 1, title: '餐桌', titleEn: 'Dining Table' },
  { id: 2, title: '边几', titleEn: 'Side Table' },
  { id: 3, title: '茶泡台', titleEn: 'Tea Table' },
  { id: 4, title: '托盘', titleEn: 'Tray' },
];

export { categoryList }