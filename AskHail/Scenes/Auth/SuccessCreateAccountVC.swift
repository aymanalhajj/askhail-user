//
//  SuccessCreateAccountVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class SuccessCreateAccountVC: UIViewController {

    @IBOutlet weak var ContinueBtn: UIButton!
    
    @IBOutlet weak var MainText: UILabel!
    @IBOutlet weak var SubText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if L102Language.currentAppleLanguage() == englishLang {
            MainText.text = "successfully registered"
            SubText.text = "Thank you for registering with us! You can now use the Ask Hail application without restrictions"
        }
        
        ContinueBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        
        setShadowButton(view: ContinueBtn, width: 0, height: 0, shadowRadius: 0, shadowOpacity: 0, shadowColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        
        

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func ContinueAction(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
}
