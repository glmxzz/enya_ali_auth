import 'package:enya_ali_auth/enya_ali_auth_callback.dart';
import 'package:enya_ali_auth/ui_config.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'enya_ali_auth_method_channel.dart';

abstract class EnyaAliAuthPlatform extends PlatformInterface {
  /// Constructs a EnyaAliAuthPlatform.
  EnyaAliAuthPlatform() : super(token: _token);

  static final Object _token = Object();

  static EnyaAliAuthPlatform _instance = MethodChannelEnyaAliAuth();

  /// The default instance of [EnyaAliAuthPlatform] to use.
  ///
  /// Defaults to [MethodChannelEnyaAliAuth].
  static EnyaAliAuthPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EnyaAliAuthPlatform] when
  /// they register themselves.
  static set instance(EnyaAliAuthPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void init(UIConfig uiConfig) {
    throw UnimplementedError('init() has not been implemented.');
  }

  void startToLogin() {
    throw UnimplementedError('startToLogin() has not been implemented.');
  }

  void quitLoginPage() {
    throw UnimplementedError('quitLoginPage() has not been implemented.');
  }

  void dismissLoading() {
    throw UnimplementedError('dismissLoading() has not been implemented.');
  }

  void setupChannelListener(EnyaAliAuthCallback callback) {
    throw UnimplementedError(
        'setupChannelListener() has not been implemented.');
  }
}
