import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { GlobalContext } from '@tbs/common';
import WindowModel from '@tbs/common/src/main/ets/widgets/WindowModel';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    // 绑定上下文信息
    GlobalContext.getContext().setObject(GlobalContext.CONTEXT, this.context);
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    this.setMainWindowImmersive(windowStage)

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  /*
   * 设置沉浸式状态栏
   * */
  setMainWindowImmersive(windowStage: window.WindowStage) {
    // 初始化windowModel中的windowStage实例
    WindowModel.getInstance().setWindowStage(windowStage);
    WindowModel.getInstance().setMainWindowImmersive(true)
    let type = window.AvoidAreaType.TYPE_SYSTEM;
    try {
      let mainWindow = windowStage.getMainWindowSync()
      let avoidArea = mainWindow.getWindowAvoidArea(type)
      GlobalContext.getContext().setObject(GlobalContext.STATUS_BAR_HEIGHT, avoidArea.topRect.height);


      //获取导航条避让遮挡的区域
      let t = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR
      let avoidAreaIndicator = mainWindow.getWindowAvoidArea(t);
      let bottomRectHeight = avoidAreaIndicator.bottomRect.height; // 获取到导航条区域的高度
      GlobalContext.getContext().setObject(GlobalContext.NAVIGATION_HEIGHT, bottomRectHeight);
    } catch (e) {
      console.error('EntryAbility getMainWindowSync error:' + e.message)
    }
  }
}
