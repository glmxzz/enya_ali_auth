import 'package:enya_ali_auth/enya_ali_auth_callback.dart';
import 'package:enya_ali_auth/ui_config.dart';

import 'enya_ali_auth_platform_interface.dart';

class EnyaAliAuth {
  EnyaAliAuthCallback callback;

  EnyaAliAuth(this.callback) {
    EnyaAliAuthPlatform.instance.setupChannelListener(callback);
  }

  ///设置密钥时，android没有回调，ios有回调
  void init(UIConfig uiConfig) {
    EnyaAliAuthPlatform.instance.init(uiConfig);
  }

  void accelerateLoginPage() {
    EnyaAliAuthPlatform.instance.accelerateLoginPage();
  }

  void startToLogin() {
    EnyaAliAuthPlatform.instance.startToLogin();
  }

  void quitLoginPage() {
    EnyaAliAuthPlatform.instance.quitLoginPage();
  }

  void dismissLoading() {
    EnyaAliAuthPlatform.instance.dismissLoading();
  }
}
