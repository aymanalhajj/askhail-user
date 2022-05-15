//
//  ChooseBlockVC.swift
//  AskHail
//
//  Created by mohab mowafy on 13/05/2022.
//  Copyright © 2022 MOHAB. All rights reserved.
//

import UIKit

enum Report_type {
    case Adv
    case Order
    case Ask
    case adviser
    case Block
}

protocol Choose_Block {
    func Report_type(Report_Type:Report_type)
}

class ChooseBlockVC:  BottomPopupViewController {
    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    
    var Delegate:Choose_Block?
    
    var advertiser_id = ""
    
    
    var Report_Type :Report_type = .Adv

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func ReportContentAction(_ sender: Any) {
       
        dismiss(animated: true, completion: nil)
        Delegate?.Report_type(Report_Type: Report_Type)
        
    }
    
    
    @IBAction func ReportPublsherAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        Report_Type = .adviser
        Delegate?.Report_type(Report_Type: Report_Type)
    }
    
    
    @IBAction func BlockPublisherAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        Report_Type = .Block
        Delegate?.Report_type(Report_Type: Report_Type)
        
       
    }
    
    
    @IBAction func Cancelaction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func getPopupHeight() -> CGFloat {
        return 400
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return topCornerRadius ?? CGFloat(10)
    }
    
    override func getPopupPresentDuration() -> Double {
        return 0.3
    }
    
    override func getPopupDismissDuration() -> Double {
        return 0.3
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return true
    }
    

}

extension ChooseBlockVC {
    func Block() {
        self.view.lock()
       var Parameters = [ "advertiser_id" : advertiser_id,
       ]
       
       print(Parameters)
       
       ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)add-ban") { (data : Add_Report_Model?, String) in
           self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
               self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
               
               
                self.showAlertWithTitle(title: "", message: data.data ?? "", type: .success)
                self.dismiss(animated: true, completion: nil)
               
                print(data)
                
                
            }
        }
    }
}
