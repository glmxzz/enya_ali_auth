import Flutter
import UIKit
import ATAuthSDK
import Foundation


public class EnyaAliAuthPlugin: NSObject, FlutterPlugin {
    var _vc :UIViewController?
    var _layoutModel:TXCustomModel?
    static var _channel:FlutterMethodChannel?
    var uiConfig:UiConfig?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    _channel = FlutterMethodChannel(name: "enya_ali_auth", binaryMessenger: registrar.messenger())
    let instance = EnyaAliAuthPlugin()
    registrar.addMethodCallDelegate(instance, channel: _channel!)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "init":
        if let arguments = call.arguments as? [String: Any] {
            self.uiConfig = UiConfig.init(dictionary: arguments)
            if let apiKey = self.uiConfig?.apiKey {
                TXCommonHandler.sharedInstance().setAuthSDKInfo(apiKey) { [weak self] (resultDic) in
                    TXCommonHandler.sharedInstance().accelerateLoginPage(withTimeout: 5.0) { [weak self] (resultDic) in
                        guard let self = self else { return }
                        if let resultDic = resultDic as? [String : Any] {
                            let dict = NSDictionary(dictionary: resultDic)
                            if let resultCode = dict["resultCode"] as? String, resultCode == "600000" {
                                self._startToLogin()
                            } else {
                                self._onTokenResult(resultDic: NSDictionary(dictionary: ["code": 500012])) //自定义code，预取号失败
                            }
                        } else {
                            self._onTokenResult(resultDic: NSDictionary(dictionary: ["code": 500012]))  //自定义code，预取号失败
                        }
                    }
                }
            }
        }
        
        result("")
        break
    case "startToLogin" :
        _startToLogin()
        result("")
        break
    case "quitLoginPage" :
        TXCommonHandler.sharedInstance().cancelLoginVC(animated: true) {
            
        }
        
        result("")
        break
    case "dismissLoading" :
        TXCommonHandler.sharedInstance().hideLoginLoading()
        result("")
        break
    default:
      result(FlutterMethodNotImplemented)
        break
    }
  }
    
    func _startToLogin() {
        if _vc == nil {
            _vc = findCurrentViewController()
        }
        if _layoutModel == nil {
            _layoutModel = initLayout()
        }

        
        if let config = self.uiConfig {

            _layoutModel?.sloganText = NSAttributedString(string:TXCommonUtils.getCurrentCarrierName()! + "提供认证服务", attributes: [
        .foregroundColor: hexStringToUIColor(hex: config.sloganColor)!,
        .font: UIFont.systemFont(ofSize: CGFloat(config.sloganFontSize))])

            if (config.isDebug) {
                TXCommonHandler.sharedInstance().debugLoginUI(with: _vc!, model: _layoutModel) { (resultDic) in
                    self._onTokenResult(resultDic: NSDictionary(dictionary: resultDic as! [String : Any]))
                }
            } else {
                TXCommonHandler.sharedInstance().getLoginToken(withTimeout: 3.0, controller: _vc!, model: _layoutModel!) { (resultDic) in
                    self._onTokenResult(resultDic: NSDictionary(dictionary: resultDic as! [String : Any]))
                }
            }
        }
        
        
    }
    
    func _onTokenResult(resultDic: NSDictionary) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: resultDic, options: [])
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                EnyaAliAuthPlugin._channel?.invokeMethod("onResponseResult", arguments: jsonString)
            }
        } catch {
            print("转换出错: \(error)")
        }
    }
    
    func _onThirdLogin(type:Int) {
        EnyaAliAuthPlugin._channel?.invokeMethod("onThirdLogin", arguments: type)
    }
    
    
func initLayout() -> TXCustomModel? {
    let txCustomModel = TXCustomModel()
    if let config = self.uiConfig {
        
        txCustomModel.backgroundColor = hexStringToUIColor(hex:config.backgroundColor)!
        txCustomModel.autoHideLoginLoading = config.autoHideLoginLoading
        txCustomModel.changeBtnIsHidden = config.changeBtnIsHidden
        txCustomModel.navIsHidden = config.navIsHidden
        txCustomModel.hideLoginLoading = config.hideLoginLoading
    
        let logoKey = FlutterDartProject.lookupKey(forAsset: config.logoImage)
    
    
    txCustomModel.logoImage = UIImage(named: logoKey, in: Bundle.main, compatibleWith: nil)!
        txCustomModel.logoIsHidden=config.logoIsHidden
    txCustomModel.logoFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
        // 计算x坐标使按钮水平居中
        let x = (superViewSize.width - config.logoWidth) / 2
        return CGRect(x: Int(x), y: Int(config.logoOffsetY), width:Int(config.logoWidth), height: Int(config.logoHeight))
    }
                         
    //手机掩码
        txCustomModel.numberColor = hexStringToUIColor(hex: config.numberColor)!
        txCustomModel.numberFont = UIFont.systemFont(ofSize: CGFloat(config.numberFontSize))
    txCustomModel.numberFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
        // 计算x坐标使按钮水平居中
        let x = (superViewSize.width - frame.width) / 2
        
        return CGRect(x: Int(x), y: Int(config.numberOffsetY), width:Int(frame.width), height: Int(frame.size.height))
    }
    
    //slogan
        txCustomModel.sloganIsHidden = config.sloganIsHidden
    txCustomModel.sloganText = NSAttributedString(string:TXCommonUtils.getCurrentCarrierName()! + "提供认证服务", attributes: [
        .foregroundColor: hexStringToUIColor(hex: config.sloganColor)!,
        .font: UIFont.systemFont(ofSize: CGFloat(config.sloganFontSize))
     ])
    txCustomModel.sloganFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
        // 计算x坐标使按钮水平居中
        let x = (superViewSize.width - config.sloganWidth) / 2
        
        return CGRect(x: Int(x), y: Int(config.sloganOffsetY), width:Int(config.sloganWidth), height: Int(frame.size.height))
    }
    
    
    
    //一键登录按钮
        txCustomModel.loginBtnText = NSAttributedString(string:config.loginBtnText, attributes: [
            .foregroundColor: hexStringToUIColor(hex: config.loginBtnColor)!,
            .font: UIFont.systemFont(ofSize: CGFloat(config.loginBtnFontSize))
     ])
    
    
        let loginImg = createRoundedButtonImage(
            color: hexStringToUIColor(hex: config.loginBtnBgColor)!,
            cornerRadius: config.privacyAlertButtonCornerRadius
        )
        
    
    txCustomModel.loginBtnBgImgs = [loginImg, loginImg, loginImg]
    txCustomModel.loginBtnFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
        // 计算x坐标使按钮水平居中
        let itemWidth = superViewSize.width - config.loginBtnMarginHorizontal * 2
        let x = (superViewSize.width - itemWidth) / 2
        
        
        return CGRect(x: x, y: config.loginBtnOffsetY, width:itemWidth, height: config.loginBtnHeight)
    }
    
        let wxKey = FlutterDartProject.lookupKey(forAsset: config.otherLoginImages[0])
    let phoneKey = FlutterDartProject.lookupKey(forAsset: config.otherLoginImages[1])
    
//    微信登录
    let wxLoginBtn = UIButton.init(type: .custom)
    wxLoginBtn.setImage(UIImage(named: wxKey, in: Bundle.main, compatibleWith: nil), for: .normal)
    wxLoginBtn.addTarget(self, action: #selector(wxClicked), for: .touchUpInside)
    
    //手机号码登录
    let phoneLoginBtn = UIButton.init(type: .custom)
    phoneLoginBtn.setImage(UIImage(named: phoneKey, in: Bundle.main, compatibleWith: nil), for: .normal)
    phoneLoginBtn.addTarget(self, action: #selector(phoneClicked), for: .touchUpInside)

    
    txCustomModel.customViewBlock = {(superView) in
        if (config.isWxInstalled){
            superView.addSubview(wxLoginBtn)
        }
        
        superView.addSubview(phoneLoginBtn)
    }

    //自定义view的布局
    txCustomModel.customViewLayoutBlock = {(screenSize,contentViewFrame,navFrame,titleBarFrame,logoFrame,
                                            sloganFrame,numberFrame,loginFrame,changeBtnFrame,privacyFrame) in

        let itemWidth = config.otherLoginWH
        var itemSpace = config.otherLoginSpace
        var frameTotalWidth = itemWidth*2 + itemSpace
        
        if (!config.isWxInstalled) {
            itemSpace = 0
            frameTotalWidth = itemWidth
        }
        
        
        
        //居中
        let x = Int((loginFrame.size.width - CGFloat(frameTotalWidth))/2 + loginFrame.minX)
        let y = Int(loginFrame.minY) + Int(config.otherLoginOffsetY)
        
        
        if (config.isWxInstalled) {
            wxLoginBtn.frame = CGRect.init(x: CGFloat(x), y:CGFloat(y), width: itemWidth, height: itemWidth)
            wxLoginBtn.layer.cornerRadius = wxLoginBtn.frame.size.width / 2
            wxLoginBtn.layer.masksToBounds = true
        }
        
        var phoneLoginBtnX = CGFloat(x) + itemWidth + itemSpace
        if (!config.isWxInstalled) {
            phoneLoginBtnX = CGFloat(x)
        }
        
        phoneLoginBtn.frame = CGRect.init(x: phoneLoginBtnX, y: CGFloat(y), width: itemWidth, height: itemWidth)
        phoneLoginBtn.layer.cornerRadius = phoneLoginBtn.frame.size.width / 2
        phoneLoginBtn.layer.masksToBounds = true

    }
    
    
    //协议区
        let checkedBoxKey = FlutterDartProject.lookupKey(forAsset: config.checkBoxImages[0])
    let unCheckBoxKey = FlutterDartProject.lookupKey(forAsset: config.checkBoxImages[1])
    
    let checkImg = UIImage(named: checkedBoxKey, in: Bundle.main, compatibleWith: nil)
    let unCheckImg = UIImage(named: unCheckBoxKey, in: Bundle.main, compatibleWith: nil)
    
    txCustomModel.checkBoxImages = [unCheckImg!, checkImg!]
        txCustomModel.checkBoxWH = config.checkBoxWH
        txCustomModel.checkBoxImageEdgeInsets = UIEdgeInsets.init(top: config.checkBoxImageEdgeInsets[0], left: config.checkBoxImageEdgeInsets[1], bottom: config.checkBoxImageEdgeInsets[2], right: config.checkBoxImageEdgeInsets[3])
    
        txCustomModel.privacyColors = [hexStringToUIColor(hex: config.privacyColors[0])!, hexStringToUIColor(hex: config.privacyColors[1])!]
        
        txCustomModel.privacyPreText = config.privacyPreText
    txCustomModel.privacySufText = config.privacySufText
        txCustomModel.privacyOne = [config.privacyOne[0], config.privacyOne[1]]
    txCustomModel.privacyTwo = [config.privacyTwo[0], config.privacyTwo[1]]
        txCustomModel.privacyOperatorPreText = config.privacyOperatorPreText
        txCustomModel.privacyOperatorSufText = config.privacyOperatorSufText
    
//    txCustomModel.privacyAlignment = NSTextAlignment.center
    txCustomModel.privacyFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
        // 计算x坐标使按钮水平居中
        
        let itemWidth = superViewSize.width - config.privacyOperatorMarginHorizontal
        let x = (superViewSize.width - itemWidth) / 2
        
        return CGRect(x: x, y: superViewSize.height - config.privacyOffsetY, width:itemWidth, height: frame.size.height)
    }
    
    
    //协议详情
    let navReturnKey = FlutterDartProject.lookupKey(forAsset: config.privacyNavBackImage)
        txCustomModel.privacyNavColor = hexStringToUIColor(hex:config.privacyNavColor)!
    txCustomModel.privacyNavTitleColor = hexStringToUIColor(hex:config.privacyNavTitleColor)!
    txCustomModel.privacyNavBackImage = UIImage(named: navReturnKey, in: Bundle.main, compatibleWith: nil)!
    
    
    
    //二次协议弹窗
        txCustomModel.privacyAlertIsNeedShow = config.privacyAlertIsNeedShow
        txCustomModel.privacyAlertBackgroundColor = hexStringToUIColor(hex:config.privacyAlertBackgroundColor)!
        txCustomModel.privacyAlertCornerRadiusArray = config.privacyAlertCornerRadiusArray.map { NSNumber(value: Float($0)) }
    
    //二次协议弹窗标题
        txCustomModel.privacyAlertTitleContent = config.privacyAlertTitleContent
        txCustomModel.privacyAlertTitleFont = UIFont.systemFont(ofSize: config.privacyAlertTitleFontSize)
        txCustomModel.privacyAlertTitleColor = hexStringToUIColor(hex: config.privacyAlertTitleColor)!
        txCustomModel.privacyAlertTitleBackgroundColor = hexStringToUIColor(hex:config.privacyAlertBackgroundColor)!
    txCustomModel.privacyAlertTitleFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
        return CGRect(x: 0, y: config.privacyAlertTitleOffsetY, width:frame.size.width, height: frame.size.height)
    }
    
    //二次协议弹窗内容
        txCustomModel.privacyAlertContentFont = UIFont.systemFont(ofSize: config.privacyAlertContentFontSize)
        txCustomModel.privacyAlertContentColors = [hexStringToUIColor(hex: config.privacyAlertContentColors[0])!, hexStringToUIColor(hex: config.privacyAlertContentColors[1])!]
        txCustomModel.privacyAlertContentBackgroundColor = hexStringToUIColor(hex:config.privacyAlertContentBackgroundColor)!
    txCustomModel.privacyAlertPrivacyContentFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
        
        return CGRect(x: CGFloat(config.privacyAlertContentMarginHorizontal), y: CGFloat(config.privacyAlertContentOffsetY), width:frame.size.width -  config.privacyAlertContentMarginHorizontal*2, height: frame.size.height)
    }
    
    //二次协议弹窗确认按钮
        let alertLoginImg = createRoundedButtonImage(
            color: hexStringToUIColor(hex: config.privacyAlertBtnBackgroundColor)!,
            cornerRadius: config.privacyAlertButtonCornerRadius
        )
        txCustomModel.privacyAlertButtonTextColors = [hexStringToUIColor(hex: config.privacyAlertButtonTextColors[0])!, hexStringToUIColor(hex: config.privacyAlertButtonTextColors[1])!]
        txCustomModel.privacyAlertButtonFont = UIFont.systemFont(ofSize: config.privacyAlertButtonFontSize)
        
        txCustomModel.privacyAlertBtnContent = config.privacyAlertBtnContent
    txCustomModel.privacyAlertBtnBackgroundImages = [alertLoginImg, alertLoginImg]
    txCustomModel.privacyAlertButtonFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
        // 计算x坐标使按钮水平居中
        let x = (superViewSize.width - config.privacyAlertButtonWidth) / 2
        return CGRect(x: x, y: config.privacyAlertButtonOffsetY, width: config.privacyAlertButtonWidth, height: config.privacyAlertButtonHeight)
    }
    
        txCustomModel.privacyAlertCloseButtonIsNeedShow = config.privacyAlertCloseButtonIsNeedShow
    txCustomModel.privacyAlertFrameBlock = { (screenSize: CGSize, superViewSize: CGSize, frame: CGRect) -> CGRect in
        return CGRect(x: (screenSize.width-config.privacyAlertWidth)/2, y: frame.minY, width:config.privacyAlertWidth, height: frame.height)
    }
    }
        
    return txCustomModel
}
    
    func findCurrentViewController() -> UIViewController {
        guard let window = UIApplication.shared.delegate?.window, let rootViewController = window?.rootViewController else {
            fatalError("无法获取到有效的窗口或根视图控制器")
        }
        
        var topViewController = rootViewController
        while true {
            if let presentedViewController = topViewController.presentedViewController {
                topViewController = presentedViewController
            } else if topViewController is UINavigationController, let navController = topViewController as? UINavigationController, let topVC = navController.topViewController {
                topViewController = topVC
            } else if topViewController is UITabBarController, let tabBarController = topViewController as? UITabBarController, let selectedVC = tabBarController.selectedViewController {
                topViewController = selectedVC
            } else {
                break
            }
        }
        
        return topViewController
    }
    
    
    private func hexStringToUIColor(hex: String) -> UIColor? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    
    @objc func wxClicked() {
        print("wxClicked 按钮被点击了")
        if (TXCommonHandler.sharedInstance().queryCheckBoxIsChecked()) {
            _onThirdLogin(type: 0)
        } else {
            //没有勾选隐私协议
            showPrivacyAlert(type:0)
        }
    }
    
    @objc func phoneClicked() {
        print("phoneClicked 按钮被点击了")
        if (TXCommonHandler.sharedInstance().queryCheckBoxIsChecked()) {
            _onThirdLogin(type: 1)
        } else {
            //没有勾选隐私协议
            showPrivacyAlert(type: 1)
        }
    }

    private func showPrivacyAlert(type: Int) {
        if let config = self.uiConfig {
            DispatchQueue.main.async {
            let currentVC = self.findCurrentViewController()
            
            // 创建背景遮罩
            let backgroundView = UIView(frame: currentVC.view.bounds)
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0)
            
            // 创建alert容器
            let alertView = UIView()
                alertView.backgroundColor = self.hexStringToUIColor(hex:config.privacyAlertBackgroundColor)!
                alertView.layer.cornerRadius = config.privacyAlertCornerRadiusArray[0]
            
            // 创建标题
            let titleLabel = UILabel()
                titleLabel.text = config.privacyAlertTitleContent
                titleLabel.textColor = self.hexStringToUIColor(hex: config.privacyAlertTitleColor)!
                titleLabel.font = .systemFont(ofSize: config.privacyAlertTitleFontSize)
            titleLabel.textAlignment = .center
            
            // 创建消息标签
            let messageLabel = UILabel()
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.isUserInteractionEnabled = true
            
            // 创建富文本
            let fullText = config.privacyPreText + config.privacyOne[0] + "和" + config.privacyTwo[0]
            let attributedString = NSMutableAttributedString(string: fullText)
            
            // 设置基础样式
            attributedString.addAttribute(.foregroundColor, value: self.hexStringToUIColor(hex: config.privacyAlertContentColors[0])!, range: NSRange(location: 0, length: fullText.count))
                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: config.privacyAlertContentFontSize), range: NSRange(location: 0, length: fullText.count))
            
            // 设置可点击部分的样式
            let userAgreementRange = (fullText as NSString).range(of: config.privacyOne[0])
            let privacyRange = (fullText as NSString).range(of: config.privacyTwo[0])
            
                let linkColor = self.hexStringToUIColor(hex: config.privacyAlertContentColors[1])!
            attributedString.addAttribute(.foregroundColor, value: linkColor, range: userAgreementRange)
            attributedString.addAttribute(.foregroundColor, value: linkColor, range: privacyRange)
            
            messageLabel.attributedText = attributedString
            
            // 添加点击手势
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapOnLabel(_:)))
            messageLabel.addGestureRecognizer(tapGesture)
            
            // 创建确定按钮
            let confirmButton = UIButton(type: .custom)
            confirmButton.setTitle(config.privacyAlertBtnContent, for: .normal)
                confirmButton.setTitleColor(self.hexStringToUIColor(hex: config.privacyAlertButtonTextColors[0]), for: .normal)
                confirmButton.titleLabel?.font = .systemFont(ofSize: config.privacyAlertButtonFontSize)
                confirmButton.backgroundColor = self.hexStringToUIColor(hex: config.privacyAlertBtnBackgroundColor)
                confirmButton.layer.cornerRadius = config.privacyAlertButtonCornerRadius
            confirmButton.tag = type
            confirmButton.addTarget(self, action: #selector(self.confirmPrivacyAlert(_:)), for: .touchUpInside)
            
            // 添加视图层级
            currentVC.view.addSubview(backgroundView)
            backgroundView.addSubview(alertView)
            alertView.addSubview(titleLabel)
            alertView.addSubview(messageLabel)
            alertView.addSubview(confirmButton)
            
            // 设置约束
            alertView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            confirmButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                alertView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
                alertView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
                alertView.widthAnchor.constraint(equalToConstant: config.privacyAlertWidth),
                
                titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: config.privacyAlertTitleOffsetY),
                titleLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
                
                messageLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: config.privacyAlertContentOffsetY),
                messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: config.privacyAlertContentMarginHorizontal),
                messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -config.privacyAlertContentMarginHorizontal),
                
                confirmButton.topAnchor.constraint(equalTo: alertView.topAnchor, constant: config.privacyAlertButtonOffsetY - config.privacyAlertContentFontSize),
                confirmButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
                confirmButton.widthAnchor.constraint(equalToConstant: config.privacyAlertButtonWidth),
                confirmButton.heightAnchor.constraint(equalToConstant: config.privacyAlertButtonHeight),
                confirmButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -16)
            ])
            
            // 添加背景点击手势
            let tapBackgroundGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissPrivacyAlert(_:)))
            backgroundView.addGestureRecognizer(tapBackgroundGesture)
            
            // 添加动画
            alertView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                alertView.transform = .identity
            }
        }
        }
        
    }
    
    @objc private func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
        if let config = self.uiConfig {
        guard let label = gesture.view as? UILabel else { return }
        
        let text = label.attributedText?.string ?? ""
        let userAgreementRange = (text as NSString).range(of: config.privacyOne[0])
        let privacyRange = (text as NSString).range(of: config.privacyTwo[0])
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        
        let locationOfTouchInLabel = gesture.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (label.bounds.width - textBoundingBox.width) * 0.5 - textBoundingBox.minX,
            y: (label.bounds.height - textBoundingBox.height) * 0.5 - textBoundingBox.minY
        )
        
        let locationOfTouchInTextContainer = CGPoint(
            x: locationOfTouchInLabel.x - textContainerOffset.x,
            y: locationOfTouchInLabel.y - textContainerOffset.y
        )
        
        let indexOfCharacter = layoutManager.characterIndex(
            for: locationOfTouchInTextContainer,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )
        

            if NSLocationInRange(indexOfCharacter, userAgreementRange) {
                let currentVC = self.findCurrentViewController()
                let webVC = WebActivity()
                webVC.url = config.privacyOne[1]
                let navController = UINavigationController(rootViewController: webVC)
                navController.modalPresentationStyle = .fullScreen
                currentVC.present(navController, animated: true)
            } else if NSLocationInRange(indexOfCharacter, privacyRange) {
                let currentVC = self.findCurrentViewController()
                let webVC = WebActivity()
                webVC.url = config.privacyTwo[1]
                let navController = UINavigationController(rootViewController: webVC)
                navController.modalPresentationStyle = .fullScreen
                currentVC.present(navController, animated: true)
            }
        }
        
        
    }

    @objc private func confirmPrivacyAlert(_ sender: UIButton) {
        if let backgroundView = sender.superview?.superview {
            if let alertView = backgroundView.subviews.first {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                    backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0)
                    alertView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
                } completion: { _ in
                    backgroundView.removeFromSuperview()
                    self._onThirdLogin(type: sender.tag)
                }
            }
        }
    }

    @objc private func dismissPrivacyAlert(_ gesture: UITapGestureRecognizer) {
        // 确保点击的是背景视图，而不是其他视图
        if gesture.view == gesture.view?.subviews.first?.superview {
            if let alertView = gesture.view?.subviews.first {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                    gesture.view?.backgroundColor = UIColor.black.withAlphaComponent(0)  // 背景渐变消失
                    alertView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)  // 向下移动
                } completion: { _ in
                    gesture.view?.removeFromSuperview()
                }
            }
        }
    }

}

extension EnyaAliAuthPlugin: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        // 直接打开网页，不关闭弹窗
        let currentVC = self.findCurrentViewController()
        let webVC = WebActivity()
        webVC.url = URL.absoluteString
        let navController = UINavigationController(rootViewController: webVC)
        navController.modalPresentationStyle = .fullScreen
        currentVC.present(navController, animated: true)
        
        return false
    }
}

// 创建圆角按钮背景图片
func createRoundedButtonImage(color: UIColor, cornerRadius: CGFloat) -> UIImage {
    // 创建更大的 size 以确保圆角效果正确
    let size = CGSize(width: cornerRadius * 2 + 1, height: cornerRadius * 2 + 1)
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let context = UIGraphicsGetCurrentContext()
    
    // 创建圆角路径
    let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), 
                           cornerRadius: cornerRadius)
    context?.addPath(path.cgPath)
    
    // 设置颜色并填充
    color.setFill()
    path.fill()
    
    // 获取图片并设置 resizable 区域
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    // 设置可拉伸区域，保持圆角不变形
    let inset = cornerRadius
    return image?.resizableImage(withCapInsets: UIEdgeInsets(top: inset, 
                                                            left: inset, 
                                                            bottom: inset, 
                                                            right: inset),
                                resizingMode: .stretch) ?? UIImage()
}
