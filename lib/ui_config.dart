class UIConfig {
  final String apiKey;
  final bool isDebug;
  final String backgroundColor;
  final bool autoHideLoginLoading;
  final bool changeBtnIsHidden;
  final bool navIsHidden;

  //logo区域
  final bool logoIsHidden;
  final String logoImage;
  final double logoWidth;
  final double logoHeight;
  final double logoOffsetY;

  //掩码区域
  final String numberColor; //掩码颜色
  final int numberFontSize; //掩码字体大小
  final double numberOffsetY; //相对屏幕顶部的距离

  //slogen区域
  final bool sloganIsHidden;
  final String sloganText;
  final double sloganOffsetY;
  final String sloganColor;
  final int sloganFontSize;
  final double sloganWidth;

  //一键登录区域
  final String loginBtnText;
  final double loginBtnOffsetY;
  final String loginBtnColor;
  final int loginBtnFontSize;

  final double loginBtnMarginHorizontal;
  final double loginBtnHeight;
  final String loginBtnBgColor;

  //其他登录区域
  final List<String> otherLoginImages;
  final double otherLoginWH;
  final double otherLoginSpace;
  final double otherLoginOffsetY; //相对于一键登录按钮的距离

  //协议区
  final List<String> checkBoxImages;
  final double checkBoxWH;
  final List<double> checkBoxImageEdgeInsets;
  final List<String> privacyColors;
  final String privacyPreText;
  final double privacyFontSize;
  final String privacySufText;
  final String privacyOperatorPreText;
  final String privacyOperatorSufText;
  final double privacyOperatorMarginHorizontal;
  final double privacyOffsetY; //距离底部距离
  final List<String> privacyOne;
  final List<String> privacyTwo;

  //协议详情
  final String privacyNavBackImage;
  final String privacyNavColor;
  final String privacyNavTitleColor;

  //二次协议弹窗
  final bool privacyAlertIsNeedShow;
  final String privacyAlertBackgroundColor;
  final List<double> privacyAlertCornerRadiusArray;
  final String privacyAlertTitleContent;
  final double privacyAlertTitleFontSize;
  final String privacyAlertTitleColor;
  final String privacyAlertTitleBackgroundColor;
  final double privacyAlertTitleOffsetY;

  final double privacyAlertContentFontSize;
  final List<String> privacyAlertContentColors;
  final String privacyAlertContentBackgroundColor;
  final double privacyAlertContentOffsetY;
  final double privacyAlertContentMarginHorizontal;
  final double privacyAlertContentMarginVertical;

  final List<String> privacyAlertButtonTextColors;
  final String privacyAlertBtnContent;
  final double privacyAlertButtonFontSize;
  final double privacyAlertButtonCornerRadius;
  final String privacyAlertBtnBackgroundColor;
  final double privacyAlertButtonWidth;
  final double privacyAlertButtonHeight;
  final double privacyAlertButtonOffsetY;

  final bool privacyAlertCloseButtonIsNeedShow;
  final double privacyAlertWidth;
  final double privacyAlertHeight;

  UIConfig({
    this.apiKey = "",
    this.isDebug = false,
    this.backgroundColor = "",
    this.autoHideLoginLoading = false,
    this.changeBtnIsHidden = true,
    this.navIsHidden = false,

    //logo区域
    this.logoIsHidden = false, //是否隐藏logo
    this.logoImage = "", //logo图片
    this.logoWidth = 0, //logo宽度
    this.logoHeight = 0, //logo高度
    this.logoOffsetY = 0, //相对屏幕顶部的距离

    //掩码区域
    this.numberColor = "", //掩码颜色
    this.numberFontSize = 0, //掩码字体大小
    this.numberOffsetY = 0, //相对屏幕顶部的距离

    //slogen区域
    this.sloganIsHidden = false,
    this.sloganText = "",
    this.sloganWidth = 0,
    this.sloganOffsetY = 0,
    this.sloganColor = "",
    this.sloganFontSize = 0,

    //一键登录区域
    this.loginBtnText = "",
    this.loginBtnOffsetY = 0,
    this.loginBtnColor = "",
    this.loginBtnFontSize = 0,
    this.loginBtnHeight = 0,
    this.loginBtnMarginHorizontal = 0,
    this.loginBtnBgColor = "",

    //其他登录区域
    this.otherLoginImages = const [],
    this.otherLoginWH = 0,
    this.otherLoginSpace = 0,
    this.otherLoginOffsetY = 0, //相对于一键登录按钮的距离

    //复选框区域
    this.checkBoxImages = const [],
    this.checkBoxWH = 0,
    this.checkBoxImageEdgeInsets = const [],
    this.privacyColors = const [],
    this.privacyPreText = "",
    this.privacyFontSize = 0,
    this.privacySufText = "",
    this.privacyOperatorPreText = "",
    this.privacyOperatorSufText = "",
    this.privacyOperatorMarginHorizontal = 0,
    this.privacyOffsetY = 0, //距离底部距离
    this.privacyOne = const [],
    this.privacyTwo = const [],

    //返回按钮
    this.privacyNavBackImage = "",
    this.privacyNavColor = "",
    this.privacyNavTitleColor = "",

    //二次协议弹窗
    this.privacyAlertIsNeedShow = false,
    this.privacyAlertBackgroundColor = "",
    this.privacyAlertCornerRadiusArray = const [],
    this.privacyAlertTitleContent = "",
    this.privacyAlertTitleFontSize = 0,
    this.privacyAlertTitleColor = "",
    this.privacyAlertTitleBackgroundColor = "",
    this.privacyAlertTitleOffsetY = 0,
    this.privacyAlertContentFontSize = 0,
    this.privacyAlertContentColors = const [],
    this.privacyAlertContentBackgroundColor = "",
    this.privacyAlertContentOffsetY = 0,
    this.privacyAlertContentMarginHorizontal = 0,
    this.privacyAlertContentMarginVertical = 0,
    this.privacyAlertButtonTextColors = const [],
    this.privacyAlertBtnContent = "",
    this.privacyAlertButtonFontSize = 0,
    this.privacyAlertButtonCornerRadius = 0,
    this.privacyAlertBtnBackgroundColor = "",
    this.privacyAlertButtonWidth = 0,
    this.privacyAlertButtonHeight = 0,
    this.privacyAlertButtonOffsetY = 0,
    this.privacyAlertCloseButtonIsNeedShow = false,
    this.privacyAlertWidth = 0,
    this.privacyAlertHeight = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "apiKey": apiKey,
      "isDebug": isDebug,
      "backgroundColor": backgroundColor,
      "autoHideLoginLoading": autoHideLoginLoading,
      "changeBtnIsHidden": changeBtnIsHidden,
      "navIsHidden": navIsHidden,
      "logoIsHidden": logoIsHidden,
      "logoImage": logoImage,
      "logoWidth": logoWidth,
      "logoHeight": logoHeight,
      "logoOffsetY": logoOffsetY,
      "numberColor": numberColor,
      "numberFontSize": numberFontSize,
      "numberOffsetY": numberOffsetY,
      "sloganIsHidden": sloganIsHidden,
      "sloganText": sloganText,
      "sloganWidth": sloganWidth,
      "sloganOffsetY": sloganOffsetY,
      "sloganColor": sloganColor,
      "sloganFontSize": sloganFontSize,
      "loginBtnText": loginBtnText,
      "loginBtnOffsetY": loginBtnOffsetY,
      "loginBtnColor": loginBtnColor,
      "loginBtnFontSize": loginBtnFontSize,
      "loginBtnHeight": loginBtnHeight,
      "loginBtnMarginHorizontal": loginBtnMarginHorizontal,
      "loginBtnBgColor": loginBtnBgColor,
      "otherLoginImages": otherLoginImages,
      "otherLoginWH": otherLoginWH,
      "otherLoginSpace": otherLoginSpace,
      "otherLoginOffsetY": otherLoginOffsetY,
      "checkBoxImages": checkBoxImages,
      "checkBoxWH": checkBoxWH,
      "checkBoxImageEdgeInsets": checkBoxImageEdgeInsets,
      "privacyColors": privacyColors,
      "privacyFontSize": privacyFontSize,
      "privacyPreText": privacyPreText,
      "privacySufText": privacySufText,
      "privacyOperatorPreText": privacyOperatorPreText,
      "privacyOperatorSufText": privacyOperatorSufText,
      "privacyOperatorMarginHorizontal": privacyOperatorMarginHorizontal,
      "privacyOffsetY": privacyOffsetY,
      "privacyOne": privacyOne,
      "privacyTwo": privacyTwo,

      "privacyNavBackImage": privacyNavBackImage,
      "privacyNavColor": privacyNavColor,
      "privacyNavTitleColor": privacyNavTitleColor,

      //二次协议弹窗
      "privacyAlertIsNeedShow": privacyAlertIsNeedShow,
      "privacyAlertBackgroundColor": privacyAlertBackgroundColor,
      "privacyAlertCornerRadiusArray": privacyAlertCornerRadiusArray,
      "privacyAlertTitleFontSize": privacyAlertTitleFontSize,
      "privacyAlertTitleContent": privacyAlertTitleContent,
      "privacyAlertTitleColor": privacyAlertTitleColor,
      "privacyAlertTitleBackgroundColor": privacyAlertTitleBackgroundColor,
      "privacyAlertTitleOffsetY": privacyAlertTitleOffsetY,

      "privacyAlertContentFontSize": privacyAlertContentFontSize,
      "privacyAlertContentColors": privacyAlertContentColors,
      "privacyAlertContentBackgroundColor": privacyAlertContentBackgroundColor,
      "privacyAlertContentOffsetY": privacyAlertContentOffsetY,
      "privacyAlertContentMarginHorizontal":
          privacyAlertContentMarginHorizontal,
      "privacyAlertContentMarginVertical": privacyAlertContentMarginVertical,
      "privacyAlertButtonTextColors": privacyAlertButtonTextColors,
      "privacyAlertButtonFontSize": privacyAlertButtonFontSize,
      "privacyAlertButtonCornerRadius": privacyAlertButtonCornerRadius,
      "privacyAlertBtnBackgroundColor": privacyAlertBtnBackgroundColor,
      "privacyAlertBtnContent": privacyAlertBtnContent,
      "privacyAlertButtonWidth": privacyAlertButtonWidth,
      "privacyAlertButtonHeight": privacyAlertButtonHeight,
      "privacyAlertButtonOffsetY": privacyAlertButtonOffsetY,
      "privacyAlertCloseButtonIsNeedShow": privacyAlertCloseButtonIsNeedShow,
      "privacyAlertWidth": privacyAlertWidth,
      "privacyAlertHeight": privacyAlertHeight,
    };
  }
}
