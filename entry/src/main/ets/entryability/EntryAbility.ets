import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import PreferencesUtils from '../common/utils/PreferencesUtils'
import deviceInfo from '@ohos.deviceInfo';
import { GlobalContext } from '../common/utils/GlobalContext';
import { SystemArea } from '../viewmodel/AppViewModel'

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    PreferencesUtils.createPreferences(this.context)
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');


    let windowClass = null;
    windowStage.getMainWindow((err, data) => {

      if (err.code) {
        console.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
        return;
      }

      windowClass = data;
      console.info('Succeeded in obtaining the main window. Data: ' + JSON.stringify(data));

      let avoidArea: window.AvoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      let vpStatusBarHeight: number = px2vp(avoidArea.topRect.height)
      let vpNavigationBarHeight: number = px2vp(avoidArea.bottomRect.height)

      let targetSystemArea: SystemArea = {
        statusBarHeight: vpStatusBarHeight,
        navigationBarHeight: vpNavigationBarHeight
      }
      // 保存到工具类中
      GlobalContext.getContext().setSystemArea(targetSystemArea)

      let names = ["status"];
      try {
        windowClass.setWindowSystemBarEnable(names, (err) => {
          if (err.code) {
            console.error('Failed to set the system bar to be visible. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in setting the system bar to be visible.');
        });
      } catch (exception) {
        console.error('Failed to set the system bar to be visible. Cause:' + JSON.stringify(exception));
      }

      // let isLayoutFullScreen= true;
      // try {
      //   windowClass.setWindowLayoutFullScreen(isLayoutFullScreen, (err) => {
      //     if (err.code) {
      //       console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
      //       return;
      //     }
      //     console.info('Succeeded in setting the window layout to full-screen mode.');
      //   });
      // } catch (exception) {
      //   console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(exception));
      // }

      let orientation = window.Orientation.PORTRAIT;
      if (deviceInfo.deviceType === 'tablet') {
        orientation = window.Orientation.LANDSCAPE
      }
      windowClass.setPreferredOrientation(orientation, (err) => {
        if (err.code) {
          hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.ERROR);
          hilog.error(0x0000, 'testTag', 'Failed to set window orientation. Cause: ' + JSON.stringify(err));
          return;
        }
        hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
        hilog.info(0x0000, 'testTag', 'Succeeded in setting window orientation.');
      });

      let SystemBarProperties = {
        statusBarColor: '#00ff0000', // 状态栏背景色透明
        //navigationBarColor: '#00ff00',
        // 以下两个属性从API Version7开始支持
        isStatusBarLightIcon: false,
        //isNavigationBarLightIcon: false,
        // 以下两个属性从API Version8开始支持
        statusBarContentColor: '#ffff00',
        //navigationBarContentColor: '#ffffff'
      };
      try {
        windowClass.setWindowSystemBarProperties(SystemBarProperties, (err) => {
          if (err.code) {
            console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in setting the system bar properties.');
        });
      } catch (exception) {
        console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(exception));
      }

      windowClass.on('systemAvoidAreaChange', (data) => {
        console.info('Succeeded in enabling the listener for system avoid area changes. Data: ' + JSON.stringify(data));
      });
    })

    windowStage.loadContent('pages/Main', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
