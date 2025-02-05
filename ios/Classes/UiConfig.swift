import Foundation

@objc public class UiConfig: NSObject {
    @objc public var apiKey: String
    @objc public var isDebug: Bool
    @objc public var isWxInstalled: Bool
    @objc public var backgroundColor: String
    @objc public var autoHideLoginLoading: Bool
    @objc public var changeBtnIsHidden: Bool
    @objc public var navIsHidden: Bool
    @objc public var hideLoginLoading: Bool

    @objc public var logoIsHidden: Bool
    @objc public var logoImage: String
    @objc public var logoWidth: CGFloat
    @objc public var logoHeight: CGFloat
    @objc public var logoOffsetY: CGFloat

    @objc public var numberColor: String
    @objc public var numberFontSize: Int
    @objc public var numberOffsetY: CGFloat

    @objc public var sloganIsHidden: Bool
    @objc public var sloganText: String
    @objc public var sloganOffsetY: CGFloat
    @objc public var sloganColor: String
    @objc public var sloganFontSize: Int
    @objc public var sloganWidth: CGFloat

    @objc public var loginBtnText: String
    @objc public var loginBtnOffsetY: CGFloat
    @objc public var loginBtnColor: String
    @objc public var loginBtnFontSize: Int
    @objc public var loginBtnHeight: CGFloat
    @objc public var loginBtnMarginHorizontal: CGFloat
    @objc public var loginBtnBgColor: String

    @objc public var otherLoginImages: [String]
    @objc public var otherLoginWH: CGFloat  //其他登录按钮的宽高        
    @objc public var otherLoginSpace: CGFloat //其他登录按钮之间的间距
    @objc public var otherLoginOffsetY: CGFloat //相对于一键登录按钮的距离

    @objc public var checkBoxImages: [String]
    @objc public var checkBoxWH: CGFloat //复选框的宽高     
    @objc public var checkBoxImageEdgeInsets: [CGFloat] //复选框图片的边距
    @objc public var privacyColors: [String] //协议区文字颜色
    @objc public var privacyFontSize: CGFloat //协议区文字大小
    @objc public var privacyPreText: String //协议区前缀
    @objc public var privacySufText: String //协议区后缀
    @objc public var privacyOperatorPreText: String //协议区运营商前缀
    @objc public var privacyOperatorSufText: String //协议区运营商后缀
    @objc public var privacyOperatorMarginHorizontal: CGFloat //协议区运营商之间的间距
    @objc public var privacyOffsetY: CGFloat //协议区距离底部距离
    @objc public var privacyOne: [String]
    @objc public var privacyTwo: [String]

    //协议详情
    @objc public var privacyNavBackImage: String
    @objc public var privacyNavColor: String
    @objc public var privacyNavTitleColor: String

    //二次协议弹窗
    @objc public var privacyAlertIsNeedShow: Bool
    @objc public var privacyAlertBackgroundColor: String
    @objc public var privacyAlertCornerRadiusArray: [CGFloat]
    @objc public var privacyAlertTitleContent: String
    @objc public var privacyAlertBtnContent: String
    @objc public var privacyAlertTitleFontSize: CGFloat
    @objc public var privacyAlertTitleColor: String
    @objc public var privacyAlertTitleBackgroundColor: String
    @objc public var privacyAlertTitleOffsetY: CGFloat
    @objc public var privacyAlertContentOffsetY: CGFloat
    
    @objc public var privacyAlertContentFontSize: CGFloat
    @objc public var privacyAlertContentColors: [String]
    @objc public var privacyAlertContentBackgroundColor: String
    @objc public var privacyAlertContentMarginHorizontal: CGFloat
    @objc public var privacyAlertContentMarginVertical: CGFloat

    @objc public var privacyAlertButtonTextColors: [String]
    @objc public var privacyAlertButtonFontSize: CGFloat
    @objc public var privacyAlertButtonCornerRadius: CGFloat
    @objc public var privacyAlertBtnBackgroundColor: String
    @objc public var privacyAlertButtonWidth: CGFloat
    @objc public var privacyAlertButtonHeight: CGFloat
    @objc public var privacyAlertButtonOffsetY: CGFloat
    @objc public var privacyAlertCloseButtonIsNeedShow: Bool
    @objc public var privacyAlertWidth: CGFloat
    @objc public var privacyAlertHeight: CGFloat
    
    @objc public override init() {
        self.apiKey = ""
        self.isDebug = false
        self.isWxInstalled = false
        self.backgroundColor = ""
        self.autoHideLoginLoading = false
        self.changeBtnIsHidden = false
        self.navIsHidden = false
        self.hideLoginLoading = true
        self.logoIsHidden = false
        self.logoImage = ""
        self.logoWidth = 0
        self.logoHeight = 0
        self.logoOffsetY = 0
        self.numberColor = ""
        self.numberFontSize = 0
        self.numberOffsetY = 0

        self.sloganIsHidden = false
        self.sloganText = ""
        self.sloganOffsetY = 0
        self.sloganColor = ""
        self.sloganFontSize = 0
        self.sloganWidth = 0

        
        self.loginBtnText = ""
        self.loginBtnOffsetY = 0
        self.loginBtnColor = ""
        self.loginBtnFontSize = 0
        self.loginBtnHeight = 0
        self.loginBtnMarginHorizontal = 0
        self.loginBtnBgColor = ""

        self.otherLoginImages = []
        self.otherLoginWH = 0
        self.otherLoginSpace = 0
        self.otherLoginOffsetY = 0

        self.checkBoxImages = []
        self.checkBoxWH = 0
        self.checkBoxImageEdgeInsets = []
        self.privacyColors = []
        self.privacyFontSize = 0
        self.privacyPreText = ""
        self.privacySufText = ""
        self.privacyOperatorPreText = ""
        self.privacyOperatorSufText = ""
        self.privacyOperatorMarginHorizontal = 0
        self.privacyOffsetY = 0
        self.privacyOne = []
        self.privacyTwo = []

        self.privacyNavBackImage = ""
        self.privacyNavColor = ""
        self.privacyNavTitleColor = ""

        self.privacyAlertIsNeedShow = false
        self.privacyAlertBackgroundColor = ""
        self.privacyAlertCornerRadiusArray = []
        self.privacyAlertTitleContent = ""
        self.privacyAlertTitleFontSize = 0
        self.privacyAlertTitleColor = ""
        self.privacyAlertTitleBackgroundColor = ""
        self.privacyAlertTitleOffsetY = 0
        self.privacyAlertContentOffsetY = 0

        self.privacyAlertContentFontSize = 0
        self.privacyAlertContentColors = []
        self.privacyAlertContentBackgroundColor = ""
        self.privacyAlertContentMarginHorizontal = 0
        self.privacyAlertContentMarginVertical = 0

        self.privacyAlertBtnContent = ""
        self.privacyAlertButtonTextColors = []
        self.privacyAlertButtonFontSize = 0
        self.privacyAlertButtonCornerRadius = 0
        self.privacyAlertBtnBackgroundColor = ""
        self.privacyAlertButtonWidth = 0
        self.privacyAlertButtonHeight = 0
        self.privacyAlertButtonOffsetY = 0
        self.privacyAlertCloseButtonIsNeedShow = false
        self.privacyAlertWidth = 0
        self.privacyAlertHeight = 0
        
        super.init()
    }
    
    @objc public init(dictionary: [String: Any]) {
        self.apiKey = dictionary["apiKey"] as? String ?? ""
        self.isDebug = dictionary["isDebug"] as? Bool ?? false
        self.isWxInstalled = dictionary["isWxInstalled"] as? Bool ?? false
        self.backgroundColor = dictionary["backgroundColor"] as? String ?? ""
        self.autoHideLoginLoading = dictionary["autoHideLoginLoading"] as? Bool ?? false
        self.changeBtnIsHidden = dictionary["changeBtnIsHidden"] as? Bool ?? false
        self.navIsHidden = dictionary["navIsHidden"] as? Bool ?? false
        self.hideLoginLoading = dictionary["hideLoginLoading"] as? Bool ?? true

        self.logoIsHidden = dictionary["logoIsHidden"] as? Bool ?? false
        self.logoImage = dictionary["logoImage"] as? String ?? ""
        self.logoWidth = dictionary["logoWidth"] as? CGFloat ?? 0
        self.logoHeight = dictionary["logoHeight"] as? CGFloat ?? 0
        self.logoOffsetY = dictionary["logoOffsetY"] as? CGFloat ?? 0
        self.numberColor = dictionary["numberColor"] as? String ?? ""
        self.numberFontSize = dictionary["numberFontSize"] as? Int ?? 0
        self.numberOffsetY = dictionary["numberOffsetY"] as? CGFloat ?? 0
        self.sloganIsHidden = dictionary["sloganIsHidden"] as? Bool ?? false
        self.sloganText = dictionary["sloganText"] as? String ?? ""
        self.sloganOffsetY = dictionary["sloganOffsetY"] as? CGFloat ?? 0
        self.sloganColor = dictionary["sloganColor"] as? String ?? ""
        self.sloganFontSize = dictionary["sloganFontSize"] as? Int ?? 0
        self.sloganWidth = dictionary["sloganWidth"] as? CGFloat ?? 0
        
        self.loginBtnText = dictionary["loginBtnText"] as? String ?? ""
        self.loginBtnOffsetY = dictionary["loginBtnOffsetY"] as? CGFloat ?? 0
        self.loginBtnColor = dictionary["loginBtnColor"] as? String ?? ""
        self.loginBtnFontSize = dictionary["loginBtnFontSize"] as? Int ?? 0
        self.loginBtnHeight = dictionary["loginBtnHeight"] as? CGFloat ?? 0
        self.loginBtnMarginHorizontal = dictionary["loginBtnMarginHorizontal"] as? CGFloat ?? 0
        self.loginBtnBgColor = dictionary["loginBtnBgColor"] as? String ?? ""
        self.otherLoginImages = dictionary["otherLoginImages"] as? [String] ?? []
        self.otherLoginWH = dictionary["otherLoginWH"] as? CGFloat ?? 0
        self.otherLoginSpace = dictionary["otherLoginSpace"] as? CGFloat ?? 0
        self.otherLoginOffsetY = dictionary["otherLoginOffsetY"] as? CGFloat ?? 0
        self.checkBoxImages = dictionary["checkBoxImages"] as? [String] ?? []
        self.checkBoxWH = dictionary["checkBoxWH"] as? CGFloat ?? 0
        self.checkBoxImageEdgeInsets = dictionary["checkBoxImageEdgeInsets"] as? [CGFloat] ?? []
        self.privacyColors = dictionary["privacyColors"] as? [String] ?? []
        self.privacyFontSize = dictionary["privacyFontSize"] as? CGFloat ?? 0
        self.privacyPreText = dictionary["privacyPreText"] as? String ?? ""
        self.privacySufText = dictionary["privacySufText"] as? String ?? ""
        self.privacyOperatorPreText = dictionary["privacyOperatorPreText"] as? String ?? ""
        self.privacyOperatorSufText = dictionary["privacyOperatorSufText"] as? String ?? ""
        self.privacyOperatorMarginHorizontal = dictionary["privacyOperatorMarginHorizontal"] as? CGFloat ?? 0
        self.privacyOffsetY = dictionary["privacyOffsetY"] as? CGFloat ?? 0
        self.privacyOne = dictionary["privacyOne"] as? [String] ?? []
        self.privacyTwo = dictionary["privacyTwo"] as? [String] ?? []
        self.privacyNavBackImage = dictionary["privacyNavBackImage"] as? String ?? ""
        self.privacyNavColor = dictionary["privacyNavColor"] as? String ?? ""
        self.privacyNavTitleColor = dictionary["privacyNavTitleColor"] as? String ?? ""

        self.privacyAlertIsNeedShow = dictionary["privacyAlertIsNeedShow"] as? Bool ?? false
        self.privacyAlertBackgroundColor = dictionary["privacyAlertBackgroundColor"] as? String ?? ""
        self.privacyAlertCornerRadiusArray = dictionary["privacyAlertCornerRadiusArray"] as? [CGFloat] ?? []
        self.privacyAlertTitleFontSize = dictionary["privacyAlertTitleFontSize"] as? CGFloat ?? 0
        self.privacyAlertTitleContent = dictionary["privacyAlertTitleContent"] as? String ?? ""
        self.privacyAlertTitleColor = dictionary["privacyAlertTitleColor"] as? String ?? ""
        self.privacyAlertTitleBackgroundColor = dictionary["privacyAlertTitleBackgroundColor"] as? String ?? ""
        self.privacyAlertTitleOffsetY = dictionary["privacyAlertTitleOffsetY"] as? CGFloat ?? 0

        self.privacyAlertContentOffsetY = dictionary["privacyAlertContentOffsetY"] as? CGFloat ?? 0
        self.privacyAlertContentFontSize = dictionary["privacyAlertContentFontSize"] as? CGFloat ?? 0
        self.privacyAlertContentColors = dictionary["privacyAlertContentColors"] as? [String] ?? []
        self.privacyAlertContentBackgroundColor = dictionary["privacyAlertContentBackgroundColor"] as? String ?? ""
        self.privacyAlertContentMarginHorizontal = dictionary["privacyAlertContentMarginHorizontal"] as? CGFloat ?? 0
        self.privacyAlertContentMarginVertical = dictionary["privacyAlertContentMarginVertical"] as? CGFloat ?? 0
        self.privacyAlertButtonTextColors = dictionary["privacyAlertButtonTextColors"] as? [String] ?? []
        self.privacyAlertButtonFontSize = dictionary["privacyAlertButtonFontSize"] as? CGFloat ?? 0
        self.privacyAlertButtonCornerRadius = dictionary["privacyAlertButtonCornerRadius"] as? CGFloat ?? 0
        self.privacyAlertBtnContent = dictionary["privacyAlertBtnContent"] as? String ?? ""
        self.privacyAlertBtnBackgroundColor = dictionary["privacyAlertBtnBackgroundColor"] as? String ?? ""
        self.privacyAlertButtonWidth = dictionary["privacyAlertButtonWidth"] as? CGFloat ?? 0
        self.privacyAlertButtonHeight = dictionary["privacyAlertButtonHeight"] as? CGFloat ?? 0
        self.privacyAlertButtonOffsetY = dictionary["privacyAlertButtonOffsetY"] as? CGFloat ?? 0
        self.privacyAlertCloseButtonIsNeedShow = dictionary["privacyAlertCloseButtonIsNeedShow"] as? Bool ?? false
        self.privacyAlertWidth = dictionary["privacyAlertWidth"] as? CGFloat ?? 0
        self.privacyAlertHeight = dictionary["privacyAlertHeight"] as? CGFloat ?? 0
        super.init()
    }
    
    @objc public func toDictionary() -> [String: Any] {
        return [
            "apiKey": apiKey,
            "isDebug": isDebug,
            "isWxInstalled": isWxInstalled,
            "backgroundColor":backgroundColor,
            "autoHideLoginLoading": autoHideLoginLoading,
            "changeBtnIsHidden": changeBtnIsHidden,
            "navIsHidden": navIsHidden,
            "hideLoginLoading": hideLoginLoading,
            
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
            "sloganOffsetY": sloganOffsetY,
            "sloganColor": sloganColor,
            "sloganFontSize": sloganFontSize,
            "sloganWidth": sloganWidth,

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
            "privacyAlertContentOffsetY": privacyAlertContentOffsetY,
            "privacyAlertContentFontSize": privacyAlertContentFontSize,
            "privacyAlertContentColors": privacyAlertContentColors,
            "privacyAlertContentBackgroundColor": privacyAlertContentBackgroundColor,
            "privacyAlertContentMarginHorizontal": privacyAlertContentMarginHorizontal, 
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
        ]
    }
}

