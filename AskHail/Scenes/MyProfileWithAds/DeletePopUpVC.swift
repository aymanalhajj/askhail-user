//
//  DeletePopUpVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/16/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import Toast_Swift

class DeletePopUpVC: UIViewController {
    
    var Ad_Id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        
    }
    
    
    @IBAction func DeleteAction(_ sender: Any) {

        DeletAds()
        removeAnimate()
        
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        
        removeAnimate()
        
    }
    
    
}

extension DeletePopUpVC {
    
    func DeletAds() {
        
        self.view.lock()
        
        let Parameters = [
            
            "advertisement_id" : Ad_Id
            
        ]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/delete-advertisement") { (data : Level_6_Model?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "HomeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
                
                
                print(data)
                
                self.navigationController?.view.makeToast("\(data.data ?? "")")
                
            }
        }
    }
    
}
