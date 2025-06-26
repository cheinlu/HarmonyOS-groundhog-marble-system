export class ButtonInfoModel {
  index: number = 0;
  img: Resource = $r('app.media.app_icon');
  selectImg: Resource = $r('app.media.app_icon');
  title: Resource = $r('app.string.home');
}

const buttonInfo: ButtonInfoModel[] = [
  {
    index: 0,
    img: $r("app.media.home"),
    selectImg: $r("app.media.home_active"),
    title: $r('app.string.home')
  },
  {
    index: 1,
    img: $r("app.media.slabs"),
    selectImg: $r("app.media.slabs_active"),
    title: $r('app.string.slabs')
  },
  {
    index: 2,
    img: $r("app.media.raw"),
    selectImg: $r("app.media.raw_active"),
    title: $r('app.string.blocks')
  },
  {
    index: 3,
    img: $r("app.media.furniture"),
    selectImg: $r("app.media.furniture_active"),
    title: $r('app.string.furniture')
  },
  {
  index: 4,
  img: $r("app.media.my"),
  selectImg: $r("app.media.my_active"),
  title: $r('app.string.mine')
}
]

export { buttonInfo }