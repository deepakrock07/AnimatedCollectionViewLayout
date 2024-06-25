import UIKit
import AnimatedCollectionViewLayout
import WebKit


protocol enableScrolling_delegate {
    func setEnableScrolling(set: Bool)
}

//protocol removeVc: AnyObject {
//    func didVcRemoved(with delvc : UIViewController)
//}

class WebViewController: UIViewController, WKNavigationDelegate {
    //    func getBool() -> Bool {
    //        <#code#>
    //    }
    //
    //    func setBool(_ value: Bool) {
    //        <#code#>
    //    }
    //
    
    var webView: WKWebView!
    var backButton: UIButton!
    var closeButton: UIButton!
    
    static  var edelegate: enableScrolling_delegate?
//    static var Ddelegate: removeVc?
    
    //    var condition: Bool  = ImageCollectionViewController.isScroll
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = .brown
        print("self",self.view.backgroundColor)
        
        // Create the WKWebView and add it to the view
        
        
        
        webView = WKWebView(frame: view.frame)
        webView.navigationDelegate = self
//        webView.backgroundColor = .black
        
        view.addSubview(webView)
        
        self.title = "Google"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title : "back", style: .plain, target: self, action: #selector(backButtonPressed) )
        
        webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 16).isActive = true
        //        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 24).isActive = true

        
        // Load the Google homepage
        let url = URL(string: "https://www.google.com")!
        let request = URLRequest(url: url)
        webView.load(request)
        
        
        
        //        webView.scrollView.isScrollEnabled = false
        //        self.view.isUserInteractionEnabled = false
        
        
        
//        closeButton = UIButton(type: .system)
//        closeButton.setTitle("Close", for: .normal)
////        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
//        self.view.addSubview(closeButton)
//        view.addSubview(closeButton)
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
//        
        
    }
    
    @objc func backButtonPressed() {
        WebViewController.edelegate?.setEnableScrolling(set: true)
        //        dismiss(animated: true)
        //        print("back button tapped")
    }
    
//    @objc func closeButtonPressed() {
//        dismiss(animated: true)
//        print("close button tapped ",self)
//        WebViewController.Ddelegate?.didVcRemoved(with: self)
//    }
    
    // MARK: - WKNavigationDelegate
    
    //    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    //        backButton.isEnabled = webView.canGoBack
    //    }
}
