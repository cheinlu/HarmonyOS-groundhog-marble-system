export class marblesObj {
  area?: number
  layers?: layers[]
  length?: number
  name?: string
  pictureUrls?: string
  slices_total?: number
  sn?: string
  type?: string
  width?: number
}

export class layers {
  length?: number
  name?: string
  pictureUrls?: string
  slices_total?: number
  sn?: string
  type?: string
  width?: number
  height?: number
  area?: number
  slices?: slices[]
}

export class slices {
  id?: number
  sn?: string
  name?: string
  type?: string
  pictureUrls?: string
  price?: number
  width?: number
  length?: number
  height?: number
  mass?: number
  area?: number
  state?: number
  remark?: string
  description?: string
}

export class commonObj {
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
}
