import display from '@ohos.display'
import { GlobalContext } from './GlobalContext';

export class ScreenUtils {
  //屏幕数据
  private defaultDisplay: display.Display | null = null
  private static instance: ScreenUtils;

  private constructor() {
    this.defaultDisplay = display.getDefaultDisplaySync()
  }

  public static getInstance(): ScreenUtils {
    if (!ScreenUtils.instance) {
      ScreenUtils.instance = new ScreenUtils();
    }
    return ScreenUtils.instance;
  }

  //屏幕宽度--px单位
  getScreenWidthPx(): number {
    return this.defaultDisplay?.width ?? -1
  }

  //屏幕宽度--px单位转换成vp单位，鸿蒙适配vp单位
  getScreenWidthVp(): number {
    return px2vp(this.getScreenWidthPx())
  }

  //屏幕高度--px单位
  getScreenHeightPx(): number {
    return this.defaultDisplay?.height ?? -1
  }

  //屏幕高度--vp单位
  getScreenHeightVp(): number {
    return px2vp(this.getScreenHeightPx())
  }

  /**
   * 获取刘海屏状态栏最大的区域
   * @returns
   */
  getStatusBarHeight(): number {
    const statusBar = GlobalContext.getContext().getObject(GlobalContext.STATUS_BAR_HEIGHT) as number;
    return px2vp(statusBar)
  }

  // 底部安全距离
  getSafeBottomHeight() {
    const navigation = GlobalContext.getContext().getObject(GlobalContext.NAVIGATION_HEIGHT) as number;
    return px2vp(navigation)
  }
}