//
//  OrderContactNumberVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/4/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit


class OrderContactNumberVC: UIViewController {
    
    var CheckBoxPhone = false
    var CheckBoxWhatsApp = false
    
    
    @IBOutlet weak var PhoneCheckBoxBtn: UIButton!
    @IBOutlet weak var WhatsCheckBoxBtn: UIButton!
    
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var WhatsAppNymber: UILabel!
    
    @IBOutlet weak var AddPhoneBtn: UIButton!
    @IBOutlet weak var AddWhatsAppBtn: UIButton!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var Ad_id = ""
    var lable = 0
    var WhatsState = "block"
    var PhoneState = "block"
    
    var Section_id = ""
    var SubSection_id = ""
    
    var isHome = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WhatsState = "block"
        PhoneState = "block"
        lable = 0
        
        PhoneNumber.text = Helper.getauser_Phone()
        WhatsAppNymber.text = Helper.getauser_Phone()
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
       
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    @IBAction func ChatCheckBoxAction(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func PhoneCheckBoxAction(_ sender: Any) {
        
        guard PhoneNumber.text != "" else {
            
            self.showAlertWithTitle(title: "", message: "There is no Phone number".localized, type: .error)
            return
        }
        
        if CheckBoxPhone == false{
            PhoneCheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
            CheckBoxPhone = true
            PhoneState = "active"
        }else{
            PhoneCheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            CheckBoxPhone = false
            PhoneState = "block"
        }
        
    }
    
    
    @IBAction func WhatsAppCheckBoxAction(_ sender: Any) {
        
        guard WhatsAppNymber.text != "" else {
            
            self.showAlertWithTitle(title: "", message: "There is no WhatsApp number".localized, type: .error)
            return
        }
        
        if CheckBoxWhatsApp == false{
            
            WhatsCheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
            CheckBoxWhatsApp = true
            WhatsState = "active"
        }else{
            WhatsCheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            CheckBoxWhatsApp = false
            WhatsState = "block"
        }
        
    }
    
    @IBAction func AddNumberPhoneAction(_ sender: UIButton) {
        
        if sender == AddPhoneBtn {
            
            lable = 0
            
            let storyboard = UIStoryboard(name: Order, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "OrderAddNewNumberVC") as! OrderAddNewNumberVC
            vc.modalPresentationStyle = .fullScreen
            self.addChild(vc)
            vc.Delegate = self
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
            
        } else if sender == AddWhatsAppBtn{
            
            lable = 1
            
            let storyboard = UIStoryboard(name: Order, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "OrderAddNewNumberVC") as! OrderAddNewNumberVC
            vc.Delegate = self
            vc.modalPresentationStyle = .fullScreen
            self.addChild(vc)
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
                        
            
        }
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        if isHome == 0 {
            navigationController?.popViewController(animated: true)
        }
        else{
            
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
            
        }
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        SetContactWay()
        
    }
}

extension OrderContactNumberVC : AddPhone {
    func getPhone(Phone: String) {
        
        if lable == 0 {
            self.PhoneNumber.text = "\(Phone)"
        } else {
            self.WhatsAppNymber.text = "\(Phone)"
        }
        
    }
}


extension OrderContactNumberVC {
    
    func SetContactWay() {
        
        var phoneState = ""
        var WhatsState = ""
        if CheckBoxPhone == false {
            phoneState = "block"
        }else{
            phoneState = "active"
        }
        
        if CheckBoxWhatsApp == false {
            WhatsState = "block"
        }else{
            WhatsState = "active"
        }
        
        
        self.view.lock()
        
        let Parameters = [
            "order_id" : Ad_id,
            "call_contact_status" : PhoneState,
            "call_number" : PhoneNumber.text ?? "",
            "whatsapp_contact_status" : WhatsState,
            "whatsapp_number" : WhatsAppNymber.text ?? ""
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)user-add-order/level4-choose-contact-ways") { (data : OrderSuccesAddModel?, String) in
        self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
               self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
               
                let storyboard = UIStoryboard(name: Order, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "SuccessAddedVC") as! SuccessAddedVC
                vc.Order_id = self.Ad_id
                vc.messge = data.data ?? ""
                vc.Section_id = self.Section_id
                vc.SubSection_id = self.SubSection_id
                self.navigationController?.pushViewController(vc, animated: true)
                
                print(data)
                
                
            }
        }
    }
    
}
