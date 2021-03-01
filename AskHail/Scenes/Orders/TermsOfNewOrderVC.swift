//
//  TermsOfNewOrderVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/4/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class TermsOfNewOrderVC: UIViewController {

    @IBOutlet weak var TermsTextView: UITextView!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var Ad_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if order_id_Status != "" {
            
            Ad_id = order_id_Status
            
            order_id_Status = ""
            
            print(Ad_id)
        }
        
        getTerms()
        
        print(Ad_id)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
       
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ConfirmTermsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Order , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "PlaceTypeVC") as! PlaceTypeVC
        vc.Ad_id = Ad_id
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension TermsOfNewOrderVC {
    
    func getTerms() {
        
        self.view.lock()
        
       ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)fixed-page/Terms-and-Conditions") { (data : FixedPagesModel?, String) in
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
                self.TermsTextView.attributedText = NSAttributedString(string: data.data?.fixed_page_body?.html2String ?? "", attributes:attributes)
                self.TermsTextView.textColor = Colors.DarkBlue
                self.TermsTextView.font = UIFont(name: "Tajawal-Regular", size: 16)
                
                print(data)
                
                
            }
        }
    }
    
}
