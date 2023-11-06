//
//  SuccessAddedVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/5/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class SuccessAddedVC: UIViewController {

    @IBOutlet weak var MessegeLable: UILabel!
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var messge = ""
    var Order_id = ""
    
    var Section_id = ""
    var SubSection_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MessegeLable.text = messge
        
        if L102Language.currentAppleLanguage() == englishLang {
            
            ConfirmBtn.setTitle("My Requests", for: .normal)
            
        }
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
       

    
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    

    @IBAction func ConfirmAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "OrderVC") as! OrderVC
        vc.is_Success = true
        vc.Order_id = Order_id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func BackToOrdersAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "SubAdsVC") as! SubAdsVC
        vc.Id = Order_id
        vc.Id = SubSection_id
        vc.CurrentPg = "order"
        vc.backToHome = 1
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
