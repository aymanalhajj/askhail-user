//
//  EditOrderContactWayVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/16/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class EditOrderContactWayVC: UIViewController {
    
    var CheckBoxPhone = false
    var CheckBoxWhatsApp = false
    
    @IBOutlet weak var LoadingView: UIView!
    var PhoneState = ""
    var WhatsState = ""
    
    var Order_id = ""
    
    var lable = 0
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var BackGround: UIView!
    @IBOutlet weak var View1: UIView!
    
    @IBOutlet weak var PhoneCheckBoxBtn: UIButton!
    @IBOutlet weak var WhatsCheckBoxBtn: UIButton!
    
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var WhatsAppNymber: UILabel!
    
    @IBOutlet weak var AddPhoneBtn: UIButton!
    @IBOutlet weak var AddWhatsAppBtn: UIButton!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getContactWay()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        LoadingView.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        setShadow(view: View1 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func ChatCheckBoxAction(_ sender: Any) {
        
        self.showAlertWithTitle(title: "", message: "Chan Comuncation is Importemt", type: .warning)
        
    }
    
    
    @IBAction func PhoneCheckBoxAction(_ sender: Any) {
        
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
            vc.Delegate = self
            vc.modalPresentationStyle = .fullScreen
            self.addChild(vc)
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
            
            print(" Phone ")
            
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
            
            print(" What's App ")
            
        }
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        updateContactWay()
        
    }
    
}

extension EditOrderContactWayVC : AddPhone {
    
    func getPhone(Phone: String) {
        
        if lable == 0 {
            self.PhoneNumber.text = "\(Phone)"
        } else {
            self.WhatsAppNymber.text = "\(Phone)"
        }
        
    }
}


extension EditOrderContactWayVC {
    
    func updateContactWay() {
        
        self.view.lock()
        
        let Parameters = [
            "order_id" : Order_id,
            "call_contact_status" : PhoneState,
            "call_number" : PhoneNumber.text ?? "",
            "whatsapp_contact_status" : WhatsState,
            "whatsapp_number" : WhatsAppNymber.text
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)user-update-order/update-contact-ways") { (data : OrderSuccessEditModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.view.makeToast("\(data.data?.message ?? "")")
                
                print(data)
                
                
            }
        }
    }
    
    func getContactWay() {
        
        self.view.lock()
        self.LoadingView.isHidden = false
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)user-update-order/edit-contact-ways?order_id=\(Order_id)") { (data : OrderEditContactsModel?, String) in
            self.LoadingView.isHidden = true
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.Order_id = "\(data.data?.order_id ?? 0)"
                
                self.PhoneState = data.data?.order_call_number_status ?? ""
                self.PhoneNumber.text = data.data?.order_call_number ?? ""
                
                self.WhatsState = data.data?.order_whatsapp_number_status ?? ""
                self.WhatsAppNymber.text = data.data?.order_whatsapp_number ?? ""
                
                
                self.PhoneCheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
                if data.data?.order_call_number_status == "active" {
                    self.PhoneCheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
                    self.PhoneState = data.data?.order_call_number_status ?? ""
                    self.CheckBoxPhone = true
                }
                
                
                self.WhatsCheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
                if data.data?.order_whatsapp_number_status == "active" {
                    self.WhatsCheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
                    self.WhatsState = data.data?.order_whatsapp_number_status ?? ""
                    self.CheckBoxWhatsApp = true
                }
                
                print(data)
                
                
            }
        }
    }
    
}
