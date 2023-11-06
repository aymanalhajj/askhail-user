//
//  DisableAdsPopUpVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/16/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import Toast_Swift

protocol DisableAds {
    func disableAds()
}

class DisableAdsPopUpVC: UIViewController {
    
    
    @IBOutlet weak var DisableLable: UILabel!
    
    var deleget : DisableAds?
    var enable = 0
    var Ad_id = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if enable == 1 {
            DisableLable.text = "Active".localized
        }else{
            DisableLable.text = "DeActive".localized
        }
        
        showAnimate()
    }
    
    @IBAction func DisableAction(_ sender: Any) {
        
        if enable == 1 {
            DeActioveAdv(id: Ad_id)
        }else{
            StopAdv(id: Ad_id)
        }
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        
        removeAnimate()
        
    }
    
}

extension DisableAdsPopUpVC {
    
    func StopAdv(id : Int) {
        
        self.view.lock()
        
        let Parameters = [
            
            "advertisement_id" : id,
            "status" : "block"
            
        ] as [String : Any]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/active-or-block-advertisement") { (data : RealEstateShotModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.removeAnimate()
                
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "HomeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
                self.navigationController?.view.makeToast("\(data.data ?? "")")
                
                print(data)
                
            }
        }
    }
    
    
    func DeActioveAdv(id : Int) {
        
        let Parameters = [
            
            "advertisement_id" : id,
            "status" : "active"
            
        ] as [String : Any]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/active-or-block-advertisement") { (data : RealEstateShotModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.removeAnimate()
                
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "HomeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
                self.navigationController?.view.makeToast("\(data.data ?? "")")
                
                print(data)
                
            }
        }
    }
    
}
