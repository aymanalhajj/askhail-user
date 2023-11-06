//
//  CreateAccount_1.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class CreateAccount_1: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var PhoneTf: UITextField!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var PhoneLineView: UIView!
    @IBOutlet weak var NextBtn: UIButton!
    
    @IBOutlet weak var PhoneView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if L102Language.currentAppleLanguage() == englishLang {
            PhoneView.semanticContentAttribute = .forceLeftToRight
            
        }
        
        PhoneTf.placeHolderColor = Colors.PlaceHolderColoer
        
        PhoneTf.delegate = self
        PhoneTf.setPadding(left: 16, right: 16)
        
        NextBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: NextBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PhoneView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
         
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if PhoneTf.text?.isEmpty != true {
            
            RegisterWithPhone()
            view.lock()
            
        } else {
            
            ErrorLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: false)
            self.view.shake()
            
        }
        
        
        
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == PhoneTf {
            
            EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone-1"), lineView: PhoneLineView, ishidden: false)
            PhoneTf.textAlignment = .left
        }
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text?.isEmpty == true {
            if textField == PhoneTf {
                
                EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: true)
                PhoneTf.textAlignment = .left
            }
            
        }
        return true;
    }
    
}

extension CreateAccount_1 {
    
    func RegisterWithPhone() {
        
        let Parameters = [
            "mobile" : PhoneTf.text ?? ""
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/register-level1-add-mobile") { (data : ForgetPasswordModel_1?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                self.view.unlock()
            }else {
                
                guard let data = data else {
                    
                    return
                }
                
                print(data.data?.advertiser_id)
                AuthService.userData?.advertiser_id = data.data?.advertiser_id ?? 0
                
                print(AuthService.userData?.advertiser_id)
                
                let storyboard = UIStoryboard(name: Authontication, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "CreateAccount_2") as! CreateAccount_2
                vc.user_id = "\(data.data?.advertiser_id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
                self.view.unlock()
                
                print(data)
                
                
            }
        }
    }
    
}
