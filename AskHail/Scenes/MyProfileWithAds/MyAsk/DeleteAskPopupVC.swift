//
//  DeleteAskPopupVC.swift
//  AskHail
//
//  Created by bodaa on 17/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class DeleteAskPopupVC: UIViewController {
    
    var question_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DeleteAction(_ sender: Any) {
        
        DeletASk()
        removeAnimate()
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        removeAnimate()

    }
    

}

extension DeleteAskPopupVC {
    
    func DeletASk() {
        
        self.view.lock()
        
        let Parameters = [
            
            "question_id" : question_id
            
        ]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/delete-question") { (data : Level_6_Model?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.showStatus(image: #imageLiteral(resourceName: "delete"), message: "\(data.data ?? "")")
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "HomeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                print(data)
                
            }
        }
    }
}
