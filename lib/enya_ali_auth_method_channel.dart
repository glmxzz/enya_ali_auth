import 'dart:convert';

import 'package:enya_ali_auth/enya_ali_auth_callback.dart';
import 'package:enya_ali_auth/ui_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'enya_ali_auth_platform_interface.dart';

/// An implementation of [EnyaAliAuthPlatform] that uses method channels.
class MethodChannelEnyaAliAuth extends EnyaAliAuthPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('enya_ali_auth');

  @override
  void init(UIConfig uiConfig) {
    methodChannel.invokeMethod('init', uiConfig.toMap());
  }

  @override
  void quitLoginPage() {
    methodChannel.invokeMethod("quitLoginPage");
  }

  @override
  void dismissLoading() {
    methodChannel.invokeMethod("dismissLoading");
  }

  @override
  void startToLogin() {
    methodChannel.invokeMethod('startToLogin');
  }

  @override
  void setupChannelListener(EnyaAliAuthCallback callback) {
    try {
      methodChannel.setMethodCallHandler((call) async {
        if (call.method == 'onResponseResult' && call.arguments is String) {
          // 将 JSON 字符串转换为 Map
          Map<String, dynamic> resultMap = jsonDecode(call.arguments);
          final code = resultMap["code"] ?? (resultMap["resultCode"] ?? "");
          switch (code) {
            case "500000":
              callback.onPreTokenSuc();
              break;
            case "500012": //预取号失败，自定义的， 不是阿里的code.
              callback.onTokenFail();
              break;
            case "600001": //唤起授权页成功
              break;
            case "600002": //登录页面已经存在，不能重复拉起。
              callback.onLoginExist();
              break;
            case "600000":
              callback.onTokenSuc(resultMap["token"]);
              break;
            case "700000":
              callback.onUserExist();
              break;
            case "700003":
              //只有ios存在这种情况。勾选协议结果会通过onTokenResult返回
              callback.onCheckChange(resultMap["isChecked"] == 1);
              break;
            case "700002": //点击了登录，未勾选
            case "700006": //弹出二次授权弹窗
            case "700007": //关闭二次授权弹窗
            case "700008": //点击了二次授权弹窗的确定并继续按钮
              break;

            case "700004": //点击了协议
            case "700009": //点击了二次弹窗协议
              break;
            default:
              callback.onTokenFail();
              break;
          }

          callback.onResponseResult(call.arguments as String);
          return;
        }

        if (call.method == 'onThirdLogin' && call.arguments is int) {
          int result = call.arguments;
          callback.onThirdLogin(result);
          return;
        }

        if (call.method == 'onCheckChange' && call.arguments is bool) {
          bool result = call.arguments;
          callback.onCheckChange(result);
          return;
        }

        // 如果不是预期的方法，可以返回错误或者不做处理等
        throw PlatformException(
            code: 'UNHANDLED_METHOD',
            message: '未处理的方法调用: ${call.method}',
            details: null);
      });
    } catch (e) {}
  }
}
