//
//  AdsSuccessAddVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/8/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AdsSuccessAddVC: UIViewController {
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var Ad_Id = ""
    
    var section_ID = ""
    var subSection_ID = ""
    
    var Message = ""
    
    @IBOutlet weak var MessageLabel: UILabel!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        MessageLabel.text = Message

        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
    }

    @IBAction func BackToMyAdsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
        vc.AdId = Ad_Id
        navigationController?.pushViewController(vc, animated: true)

    }
    
    
    @IBAction func GoToAdvAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "SubAdsVC") as! SubAdsVC
        vc.Id = subSection_ID
        vc.CurrentPg = "advertisements"
        vc.backToHome = 1
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
