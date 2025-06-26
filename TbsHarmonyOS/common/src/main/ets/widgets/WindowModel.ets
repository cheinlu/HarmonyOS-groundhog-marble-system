import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 窗口管理模型
 */
class WindowModel {
  private constructor() {
  }

  /**
   * 默认样式
   */
  private readonly DEFAULT: window.SystemBarProperties = {
    statusBarColor: '#00000000',
    navigationBarColor: '#00000000',
    // 以下两个属性从API Version 8开始支持
    statusBarContentColor: '#000000',
    navigationBarContentColor: '#00000000'
  };
  /**
   * WindowModel 单例
   */
  private static instance?: WindowModel;

  /**
   * 获取WindowModel单例实例
   * @returns {WindowModel} WindowModel
   */
  static getInstance(): WindowModel {
    if (!WindowModel.instance) {
      WindowModel.instance = new WindowModel();
    }

    return WindowModel.instance;
  }

  /**
   * 缓存的当前WindowStage实例
   */
  private windowStage?: window.WindowStage;
  /**
   * 缓存的主窗口实例
   */
  private mainWindow?: window.Window;

  /**
   * 缓存windowStage
   * @param windowStage 当前WindowStage实例
   * @returns {void}
   */
  setWindowStage(windowStage: window.WindowStage): void {
    this.windowStage = windowStage;
  }

  getWindowStage():window.WindowStage | undefined {
    return this.windowStage
  }

  /**
   * 获取当前主窗口的尺寸
   * @returns
   */
  async getWindowRect(): Promise<window.Rect | undefined> {
    if (this.windowStage === undefined) {
      console.error('windowStage is undefined.');
      return;
    }

    if (!this.mainWindow) {
      this.mainWindow = await this.windowStage.getMainWindow();
    }

    const mainWinProp = this.mainWindow.getWindowProperties();
    return mainWinProp.windowRect;
  }

  /**
   * 参考：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/application-window-stage-0000001820999885#ZH-CN_TOPIC_0000001811156966__%E6%8E%A5%E5%8F%A3%E8%AF%B4%E6%98%8E
   * 当前主窗口是否开启沉浸模式
   * @param enable 是否开启
   * @returns {void}
   */
  setMainWindowImmersive(enable: boolean, properties?: window.SystemBarProperties): void {
    if (this.windowStage === undefined) {
      console.error('windowStage is undefined.');
      return;
    }
    // 1.获取应用主窗口。
    let windowClass: window.Window | null = null;
    this.windowStage.getMainWindow((err: BusinessError, data) => {
      let errCode: number = err.code;
      if (errCode) {
        console.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
        return;
      }
      windowClass = data;
      console.info('Succeeded in obtaining the main window data.');

      // 2.实现沉浸式效果。方式一：设置导航栏、状态栏不显示。
      // let names: Array<'status' | 'navigation'> = [];
      // windowClass.setWindowSystemBarEnable(names, (err: BusinessError) => {
      //   let errCode: number = err.code;
      //   if (errCode) {
      //     logger.error('Failed to set the system bar to be visible. Cause:' + JSON.stringify(err));
      //     return;
      //   }
      //   logger.info('Succeeded in setting the system bar to be visible.');
      // });
      // 2.实现沉浸式效果。方式二：设置窗口为全屏布局，配合设置导航栏、状态栏的透明度、背景/文字颜色及高亮图标等属性，与主窗口显示保持协调一致。
      windowClass.setWindowLayoutFullScreen(enable, (err: BusinessError) => {
        let errCode: number = err.code;
        if (errCode) {
          console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded in setting the window layout to full-screen mode.');
      });
      const p = properties ? properties : this.DEFAULT
      windowClass.setWindowSystemBarProperties(p, (err: BusinessError) => {
        let errCode: number = err.code;
        if (errCode) {
          console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded in setting the system bar properties.');
      });
    })
  }

}

export default WindowModel