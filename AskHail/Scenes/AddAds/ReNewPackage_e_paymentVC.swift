import UIKit
import WebKit
import Alamofire

class ReNewPackage_e_paymentVC:  UIViewController, UIScrollViewDelegate,WKNavigationDelegate {
    var url = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    
    var texxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        //              load()
        
        let purl = URL(string: url)
        print(purl)
        self.webView.load(URLRequest(url: purl!))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print("Finish navigation")
        print("test: \(webView.url)" , webView.uiDelegate)
        
        webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (result, error) in
            
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            }else {
                
                
                print(result)
                
            }
            
            
            
            webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: { (res, error) in
                
                print(res)
                if let fingerprint = res as? String {
                    
                    
                    if fingerprint.contains("\"status\":false") {
                        
                        
                        print("Error")
                        
                        self.dismiss(animated: true, completion: nil)
                    }else if fingerprint.contains("\"status\":true") {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "PaymenSuccessesVC") as! PaymenSuccessesVC
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                        
                        print("Success")
                        
                    }
                    
                    
                    print(res)
                    
                    
                    
                    
                }else {
                    
                    print(error?.localizedDescription)
                }
            })
            
        }
        
    }
    
    
    @IBAction func goooback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
    
    
    func load(){
        let url1 = url
        let purl = URL(string: url1)!
        print(purl)
        self.webView.load(URLRequest(url: purl))
        
    }
    
    var loaded = false;
    var coood = ""
    
}
extension String {
    
    func slice2(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}


//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//
//
//            print("Finish navigation")
//            print("test: \(webView.url)" , webView.uiDelegate)
//            webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (result, error) in
//
//
//                    if error != nil {
//                        print(error?.localizedDescription ?? "")
//                    }else {
//
//
//                        print(result)
//
//                    }
//
//
//
//            webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: { (res, error) in
//                if let fingerprint = res {
//
//
//                    print(res)
//
//
//
//
//                }else {
//
//                    print(error?.localizedDescription)
//                }
//            })
//
//            print("finished")
//
//        }
//
//        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//
//
//
//            if let link = navigationAction.request.url?.absoluteString {
//                print("link= \(link)")
//
//                if link.contains("payment?success=0"){
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
//                        self.navigationController?.popViewController(animated: true)
//                    })
//
//                }else if link.contains("payment?success=1"){
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
//
//                        self.navigationController?.popViewController(animated: true)
//                                  })
//                   https://dev.therose-app.com/check-payment?success=1
//                }
//            }
//
//            decisionHandler(.allow)
//        }
//
//
//
//
