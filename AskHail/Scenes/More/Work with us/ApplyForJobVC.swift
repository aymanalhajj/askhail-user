//
//  ApplyForJobVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/30/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ApplyForJobVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TopBar: UIView!
    
    @IBOutlet weak var JobTitle: UILabel!
    @IBOutlet weak var JobDesc: UILabel!
    @IBOutlet weak var FullNameTf: UITextField!
    @IBOutlet weak var FullnameImage: UIImageView!
    @IBOutlet weak var FullnameLineView: UIView!
    @IBOutlet weak var FullNameView: UIView!
    
    @IBOutlet weak var MailTf: UITextField!
    @IBOutlet weak var MailImage: UIImageView!
    @IBOutlet weak var MailLineView: UIView!
    @IBOutlet weak var MailView: UIView!
    
    @IBOutlet weak var PhoneTf: UITextField!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var PhoneLineView: UIView!
    @IBOutlet weak var PhoneView: UIView!
    
    @IBOutlet weak var desTxt: UITextView!
    @IBOutlet weak var desLineView: UIView!
    @IBOutlet weak var desView: UIView!
    
    var jobDesc = ""
    var jobTitle = ""
    
    var Job_id = ""
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JobTitle.text = jobTitle
        JobDesc.text = jobDesc
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        if L102Language.currentAppleLanguage() == englishLang {
            PhoneView.semanticContentAttribute = .forceLeftToRight
        }
        
        FullNameTf.placeHolderColor = Colors.PlaceHolderColoer
        PhoneTf.placeHolderColor = Colors.PlaceHolderColoer
        MailTf.placeHolderColor = Colors.PlaceHolderColoer
        PhoneTf.placeHolderColor = Colors.PlaceHolderColoer
        
        FullNameTf.delegate = self
        MailTf.delegate = self
        PhoneTf.delegate = self
        desTxt.delegate = self
        
        FullNameTf.setPadding(left: 16, right: 16)
        PhoneTf.setPadding(left: 16, right: 16)
        MailTf.setPadding(left: 16, right: 16)
        PhoneTf.setPadding(left: 16, right: 16)
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        setShadow(view: MailView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PhoneView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: desView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: FullNameView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        
        if L102Language.currentAppleLanguage() == "en" {
            
            desTxt.text = "Your Messege"
            
        }else {
            
            desTxt.text = "رسالتك"
        }
        
        desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if desTxt.textColor == #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5) {
            desTxt.text = ""
            desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        }
    }
    
    
    @IBAction func BackAcrion(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if FullNameTf.text?.isEmpty != true ,MailTf.text?.isEmpty != true,PhoneTf.text?.isEmpty != true,desTxt.text?.isEmpty != true {
            
            ApplyJobs()
            
        } else {
            
            if FullNameTf.text?.isEmpty == true {
                ErrorLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: false)
            }
            if MailTf.text?.isEmpty == true {
                ErrorLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail"), lineView: MailLineView, ishidden: false)
                
            }
            if PhoneTf.text?.isEmpty == true {
                    ErrorLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: false)
                
            }
            if desTxt.text?.isEmpty == true {
                    ErrorLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: false)
            }
            
            self.view.shake()
            
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == PhoneTf {
            
            EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone-1"), lineView: PhoneLineView, ishidden: false)
            PhoneTf.textAlignment = .left
        } else if textField == MailTf {
            
            EnableLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail-1"), lineView: MailLineView, ishidden: false)
        } else if textField == FullNameTf {
            
            EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: FullnameLineView, ishidden: false)
            
        } else if textField ==  desTxt{
            
            UIView.animate(withDuration: 0.06, animations: {
                
                self.desLineView.isHidden = false
                self.desLineView.center.x = 100
                self.desLineView.frame.size.width = +200
                
            }) { (_) in
                
            }
        }
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            if textField == PhoneTf {
                
                EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: true)
                PhoneTf.textAlignment = .natural
            } else if textField == MailTf {
                
                EnableLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail"), lineView: MailLineView, ishidden: true)
            } else if textField == FullNameTf {
                
                EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: true)
            } else {
                self.desLineView.isHidden = true
            }
        }
        return true;
    }
    
    
}

extension ApplyForJobVC {
    
    func ApplyJobs() {
        self.view.lock()
        
        var Parameters = [
            "job_id" : Job_id,
            "name" : FullNameTf.text ?? "",
            "email" : MailTf.text ?? "",
            "mobile" : PhoneTf.text ?? "",
            "message" : desTxt.text ?? ""
        ]
        
        print(Parameters)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)job-apply") { (data : RealEstateShotModel?, String) in
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                

                let storyboard = UIStoryboard(name: More, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "RequestSendedVC") as! RequestSendedVC
                self.navigationController?.pushViewController(vc, animated: true)
                
                
                print(data)
                
            }
        }
    }
    
}
