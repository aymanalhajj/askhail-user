//
//  PaymentPolicyVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/30/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class PaymentPolicyVC: UIViewController {

    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTerms()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
      
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        print(" Visitor ")
    
        
    }
    
}


extension PaymentPolicyVC{
    
    func getTerms() {
        
        self.view.lock()
        
       ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)fixed-page/payment-policy-when-selling-or-renting-the-property") { (data : FixedPagesModel?, String) in
        self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
               self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 10
                let attributes = [NSAttributedString.Key.paragraphStyle : style]
                self.TextView.attributedText = NSAttributedString(string: data.data?.fixed_page_body?.html2String ?? "", attributes:attributes)
                self.TextView.textColor = Colors.DarkBlue
                self.TextView.font = UIFont(name: "Tajawal-Regular", size: 16)
                
                print(data)
                
                
            }
        }
    }
    
}
