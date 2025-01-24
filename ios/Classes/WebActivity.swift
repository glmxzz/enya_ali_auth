import UIKit
import Flutter
import WebKit

class WebActivity: UIViewController {
    var url: String = ""
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebContent()
    }
    
    private func setupUI() {
        // 设置导航栏样式
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#161518")
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = hexStringToUIColor(hex: "#161518")
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        // 获取 Bundle 中的图标
        let navReturnKey = FlutterDartProject.lookupKey(forAsset: "assets/images/return_btn.png")
        
        let returnImage = UIImage(named: navReturnKey, in: Bundle.main, compatibleWith: nil)!
        
        // 添加返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(returnImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        // 设置按钮的frame
        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        // 设置图片的内边距，这样图片会显示得更小
        backButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        // 配置进度条
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = hexStringToUIColor(hex: "#0257F6")
        progressView.trackTintColor = .clear
        view.addSubview(progressView)
        
        // 配置WebView
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        
        // 设置约束
        progressView.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 进度条约束
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2),
            
            // WebView约束
            webView.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 添加进度观察
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    private func loadWebContent() {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func backButtonTapped() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            dismiss(animated: true)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            
            // 当加载完成时，淡出进度条
            if progressView.progress == 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                })
            } else {
                progressView.alpha = 1.0
            }
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    private func hexStringToUIColor(hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return .gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}

// MARK: - WKNavigationDelegate
extension WebActivity: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // 处理加载失败的情况
        let alert = UIAlertController(title: "加载失败", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - WKUIDelegate
extension WebActivity: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        // 处理新窗口打开的情况
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
