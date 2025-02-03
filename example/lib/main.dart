import 'dart:io';

import 'package:enya_ali_auth/enya_ali_auth_callback.dart';
import 'package:enya_ali_auth/ui_config.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:enya_ali_auth/enya_ali_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class MyCallback implements EnyaAliAuthCallback {
  @override
  void onThirdLogin(int type) {
    print('onThirdLogin: $type');
  }

  @override
  void onCheckChange(bool isCheck) {
    print('onCheckChange: $isCheck');
  }

  @override
  void onLoginExist() {
    print('onLoginExist');
  }

  @override
  void onResponseResult(String result) {
    print('onResponseResult： $result');
  }

  @override
  void onTokenSuc(String token) {
    print('onTokenSuc： $token');
  }

  @override
  void onUserExist() {
    // TODO: implement onUserExist
  }

  @override
  void onTokenFail() {
    // TODO: implement onTokenFail
  }
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  final _enyaAliAuthPlugin = EnyaAliAuth(MyCallback());

  @override
  void initState() {
    super.initState();
    final ONE_KEY_LOGIN_IOS = "";
    _enyaAliAuthPlugin.init(UIConfig(
      apiKey: ONE_KEY_LOGIN_IOS,
      isDebug: true,
      isWxInstalled: false,
      backgroundColor: "#161518",
      autoHideLoginLoading: false,
      changeBtnIsHidden: true,
      navIsHidden: true,

      logoIsHidden: false,
      logoImage: "assets/images/ic_launcher.png",
      logoWidth: 80,
      logoHeight: 80,
      logoOffsetY: Platform.isIOS ? 180 : 140,

      numberColor: "#FFFFFF",
      numberFontSize: Platform.isIOS ? 24 : 18,
      numberOffsetY: Platform.isIOS ? 320 : 240,

      sloganIsHidden: false,
      sloganOffsetY: Platform.isIOS ? 360 : 270,
      sloganColor: "#FFFFFF",
      sloganFontSize: 12,
      sloganWidth: 200,

      loginBtnText: "一键登录",
      loginBtnColor: "#FFFFFF",
      loginBtnFontSize: 17,
      loginBtnOffsetY: Platform.isIOS ? 400 : 310,
      loginBtnBgColor: "#0257F6",
      loginBtnHeight: 56,
      loginBtnMarginHorizontal: 40,

      otherLoginImages: [
        "assets/images/icon_login_wechat.png",
        "assets/images/icon_login_phone.png"
      ],
      otherLoginWH: 40,
      otherLoginSpace: 40,
      otherLoginOffsetY: 100,

      checkBoxImages: [
        "assets/images/btn_checked.png",
        "assets/images/btn_unchecked.png"
      ],
      privacyOne: ["《用户服务》", "https://www.baidu.com"],
      privacyTwo: ["《隐私协议》", "https://www.taobao.com"],
      checkBoxWH: Platform.isIOS ? 24 : 15,
      checkBoxImageEdgeInsets: [4, 8, 8, 4],
      privacyColors: ["#BDBDBD", "#92A6E2"],
      privacyPreText: "阅读并同意",
      privacyFontSize: 11,
      privacySufText: "",
      privacyOperatorPreText: "《",
      privacyOperatorSufText: "》",
      privacyOperatorMarginHorizontal: 37,
      privacyOffsetY: Platform.isIOS ? 80 : 38,

      privacyNavBackImage: "assets/images/return_btn.png",
      privacyNavColor: "#161518",
      privacyNavTitleColor: "#FFFFFF",

      //二次协议弹窗
      privacyAlertIsNeedShow: true,
      privacyAlertBackgroundColor: "#161518",
      privacyAlertCornerRadiusArray: [20, 20, 20, 20],
      privacyAlertTitleFontSize: 16,
      privacyAlertTitleContent: "请阅读并同意以下条款",
      privacyAlertTitleColor: "#FFFFFF",
      privacyAlertTitleBackgroundColor: "#161518",
      privacyAlertTitleOffsetY: 24,

      privacyAlertContentFontSize: 14,
      privacyAlertContentColors: ["#BDBDBD", "#92A6E2"],
      privacyAlertContentBackgroundColor: "#161518",
      privacyAlertContentMarginHorizontal: 16,
      privacyAlertContentMarginVertical: 16,
      privacyAlertContentOffsetY: 64,

      privacyAlertButtonTextColors: ["#FFFFFF", "#FFFFFF"],
      privacyAlertButtonFontSize: 14,
      privacyAlertBtnBackgroundColor: "#0257F6",
      privacyAlertBtnContent: "同意并继续",
      privacyAlertButtonWidth: 180,
      privacyAlertButtonCornerRadius: 12,
      privacyAlertButtonHeight: 40,
      privacyAlertButtonOffsetY: 140,
      privacyAlertCloseButtonIsNeedShow: false,
      privacyAlertWidth: 270,
      privacyAlertHeight: 40,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: [
          ElevatedButton(
            onPressed: () async {
              _enyaAliAuthPlugin.startToLogin();
            },
            child: Text('Login'),
          ),
          ElevatedButton(
            onPressed: () async {},
            child: Text('Logout'),
          ),
        ]),
      ),
    );
  }
}
