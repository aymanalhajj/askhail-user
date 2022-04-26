//
//  CreateAccount_3.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import AJMessage


class CreateAccount_3: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var FullNameTf: UITextField!
    @IBOutlet weak var MailTf: UITextField!
    @IBOutlet weak var PasswordFt: UITextField!
    @IBOutlet weak var sideTF: UITextField!
    @IBOutlet weak var capacityTF: UITextField!
    @IBOutlet weak var delegation_numberTF: UITextField!
    @IBOutlet weak var LicenceTF: UITextField!
    
    
    @IBOutlet weak var FullnameImage: UIImageView!
    @IBOutlet weak var MailImage: UIImageView!
    @IBOutlet weak var PasswordImage: UIImageView!
    @IBOutlet weak var sideImg: UIImageView!
    @IBOutlet weak var typeIdImage: UIImageView!
    @IBOutlet weak var IdImage: UIImageView!
    
    @IBOutlet weak var capacityImg: UIImageView!
    @IBOutlet weak var delegation_numberImg: UIImageView!
    @IBOutlet weak var LicenceTFImg: UIImageView!
    
    
    @IBOutlet weak var FullnameLineView: UIView!
    @IBOutlet weak var MailLineView: UIView!
    @IBOutlet weak var PasswordLineView: UIView!
    @IBOutlet weak var sideLineView: UIView!
    @IBOutlet weak var TypeIdLineView: UIView!
    @IBOutlet weak var IdLineView: UIView!
    
    
    @IBOutlet weak var capacityLineView: UIView!
    @IBOutlet weak var delegation_numberLineView: UIView!
    @IBOutlet weak var LicenceTFLinceView: UIView!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    @IBOutlet weak var FullNameView: UIView!
    @IBOutlet weak var MailView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var capacityView: UIView!
    @IBOutlet weak var delegation_numberView: UIView!
    @IBOutlet weak var LicenceView: UIView!
    
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    @IBOutlet weak var Lable: UILabel!
    
    @IBOutlet weak var TypeIdTF: UITextField!
    @IBOutlet weak var IdTF: UITextField!
    
    
    var sidePicker = UIPickerView()
    var capacityPicker = UIPickerView()
    var TypeIdPicker = UIPickerView()
    var IdPicker = UIPickerView()
    
    var Side_choose = ""
    var type_id_choose = ""
    var id_choose = ""
    var Capacity_choose = ""
    
    var Side_Array = ["individual" , "company"]
    var Side_Array_ar = ["فرد" , "شركة"]
    
    var Capacity_Array = ["owner" , "delegate"]
    var Capacity_Array_ar = ["مالك" , "مفوض"]
    
    
    var type_id_array = [typeIdData]()
    
    var checkBox = false
    
    var user_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTypeId()
        
        delegation_numberView.isHidden = true
        
        sideTF.placeholder = "Advertiser category".localized
        TypeIdTF.placeholder = "type id".localized
        IdTF.placeholder = "id number".localized
        
        capacityTF.placeholder = "Advertiser character".localized
        delegation_numberTF.placeholder = "delegate number".localized
        LicenceTF.placeholder = "Advertiser license number".localized
        
        sideTF.inputView = sidePicker
        TypeIdTF.inputView = TypeIdPicker
        
        capacityTF.inputView = capacityPicker
        
        
        FullNameTf.delegate = self
        MailTf.delegate = self
        PasswordFt.delegate = self
        sideTF.delegate = self
        TypeIdTF.delegate = self
        IdTF.delegate = self
        capacityTF.delegate = self
        delegation_numberTF.delegate = self
        LicenceTF.delegate = self
        
        FullNameTf.placeHolderColor = Colors.PlaceHolderColoer
        MailTf.placeHolderColor = Colors.PlaceHolderColoer
        PasswordFt.placeHolderColor = Colors.PlaceHolderColoer
        sideTF.placeHolderColor = Colors.PlaceHolderColoer
        TypeIdTF.placeHolderColor = Colors.PlaceHolderColoer
        IdTF.placeHolderColor = Colors.PlaceHolderColoer
        capacityTF.placeHolderColor = Colors.PlaceHolderColoer
        delegation_numberTF.placeHolderColor = Colors.PlaceHolderColoer
        LicenceTF.placeHolderColor = Colors.PlaceHolderColoer
        
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        setShadow(view: FullNameView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: MailView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PasswordView, width: 0, height: 2, shadowRadius: 2, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: sideView, width: 0, height: 2, shadowRadius: 2, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: capacityView, width: 0, height: 2, shadowRadius: 2, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: delegation_numberView, width: 0, height: 2, shadowRadius: 2, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: LicenceView, width: 0, height: 2, shadowRadius: 2, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        
        FullNameTf.setPadding(left: 16, right: 16)
        MailTf.setPadding(left: 16, right: 16)
        PasswordFt.setPadding(left: 16, right: 16)
        sideTF.setPadding(left: 16, right: 16)
        IdTF.setPadding(left: 16, right: 16)
        TypeIdTF.setPadding(left: 16, right: 16)
        capacityTF.setPadding(left: 16, right: 16)
        delegation_numberTF.setPadding(left: 16, right: 16)
        LicenceTF.setPadding(left: 16, right: 16)
        
        
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 16), NSAttributedString.Key.foregroundColor : Colors.DarkBlue]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 16), NSAttributedString.Key.foregroundColor : UIColor(hexString: "#39CDEE")]
        
        let attributedString1 = NSMutableAttributedString(string: "By registering for the Ask Hail application, I agree to".localized, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: " Terms and Conditions".localized, attributes:attrs2)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7
        
        attributedString1.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString1.length
            ))
        
        attributedString2.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString2.length
            ))
        
        attributedString1.append(attributedString2)
        Lable.attributedText = attributedString1
        
        self.initPickers(picker: sidePicker)
        self.initPickers(picker: capacityPicker)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func ConfirmACtion(_ sender: Any) {
        if checkBox == false{
           
            self.showAlertWithTitle(title: "", message: "you should agree terms and conditions".localized, type: .error)
            
            return
            
        }
        
        if FullNameTf.text?.isEmpty != true  , PasswordFt.text?.isEmpty != true , checkBox != false {
            
            CompleteRegister()
            view.lock()
           
            
        } else {
            
            if FullNameTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: false)
                
            }
            
//            if MailTf.text?.isEmpty == true {
//
//                ErrorLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail"), lineView: MailLineView, ishidden: false)
//
//            }
            
            if PasswordFt.text?.isEmpty == true {
                
                ErrorLineAnimite(text: PasswordFt, ImageView: PasswordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: PasswordLineView, ishidden: false)
                
            }
            
//            if sideTF.text?.isEmpty == true {
//
//                ErrorLineAnimite(text: sideTF, ImageView: sideImg, imageEnable: #imageLiteral(resourceName: "user"), lineView: sideLineView, ishidden: false)
//
//            }
            
//            if TypeIdTF.text?.isEmpty == true {
//
//                ErrorLineAnimite(text: TypeIdTF, ImageView: typeIdImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: TypeIdLineView, ishidden: false)
//
//            }
            
//            if IdTF.text?.isEmpty == true {
//                
//                ErrorLineAnimite(text: IdTF, ImageView: IdImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: IdLineView, ishidden: false)
//                
//            }
            
//            if capacityTF.text?.isEmpty == true {
//
//                ErrorLineAnimite(text: capacityTF, ImageView: capacityImg, imageEnable: #imageLiteral(resourceName: "user"), lineView: capacityLineView, ishidden: false)
//
//            }
            
//            if delegation_numberTF.text?.isEmpty == true {
//
//                ErrorLineAnimite(text: delegation_numberTF, ImageView: delegation_numberImg, imageEnable: #imageLiteral(resourceName: "user"), lineView: delegation_numberLineView, ishidden: false)
//
//            }
            
//            if LicenceTF.text?.isEmpty == true {
//
//                ErrorLineAnimite(text: LicenceTF, ImageView: LicenceTFImg, imageEnable: #imageLiteral(resourceName: "user"), lineView: LicenceTFLinceView, ishidden: false)
//
//            }
            
            self.view.shake()
        }
        
    }
    
    
    
    @IBAction func CheckBoxAction(_ sender: Any) {
        
        if checkBox == false{
            checkBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
            checkBox = true
        }else{
            checkBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            checkBox = false
        }
    }
    
    
    @IBAction func TermsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "TempVC") as! TempVC
        vc.isCreateAccount = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == FullNameTf {
            EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: FullnameLineView, ishidden: false)
        }else if textField == MailTf {
            EnableLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail-1"), lineView: MailLineView, ishidden: false)
        }else if textField == PasswordFt {
            EnableLineAnimite(text: PasswordFt, ImageView: PasswordImage, imageEnable: #imageLiteral(resourceName: "password-1"), lineView: PasswordLineView, ishidden: false)
        }else if textField == sideTF {
            EnableLineAnimite(text: sideTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: sideLineView, ishidden: false)
        }else if textField == TypeIdTF {
            EnableLineAnimite(text: TypeIdTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: TypeIdLineView, ishidden: false)
        }else if textField == IdTF {
            EnableLineAnimite(text: IdTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: IdLineView, ishidden: false)
        }else if textField == capacityTF {
            EnableLineAnimite(text: capacityTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: capacityLineView, ishidden: false)
        }else if textField == delegation_numberTF {
            EnableLineAnimite(text: delegation_numberTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: delegation_numberLineView, ishidden: false)
        }else if textField == LicenceTF {
            EnableLineAnimite(text: LicenceTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: LicenceTFLinceView, ishidden: false)
        }
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty == true {
            
            if textField == FullNameTf {
                EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: true)
            }else if textField == MailTf {
                EnableLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail"), lineView: MailLineView, ishidden: true)
            }else if textField == PasswordFt {
                EnableLineAnimite(text: PasswordFt, ImageView: PasswordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: PasswordLineView, ishidden: true)
            }else if textField == sideTF {
                
                if sideTF.text == ""{
                    
                    if Side_Array.count != 0 {
                        if L102Language.currentAppleLanguage() == englishLang {
                            sideTF.text = Side_Array[0]
                        }else {
                            sideTF.text = Side_Array_ar[0]
                        }
                        
                        Side_choose = Side_Array[0]
                    }
                    EnableLineAnimite(text: sideTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: sideLineView, ishidden: true)
                }

            }else if textField == TypeIdTF {
               
                if TypeIdTF.text == ""{
                    
                    if type_id_array.count != 0 {
                       
                        TypeIdTF.text = type_id_array[0].type_name
                        
                        type_id_choose = "\(type_id_array[0].type_id ?? 0)"
                    }
                }
                EnableLineAnimite(text: TypeIdTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: TypeIdLineView, ishidden: true)

            }
            else if textField == capacityTF {
               
                if capacityTF.text == "" {
                    
                    if Capacity_Array.count != 0 {
                       
                        
                        if L102Language.currentAppleLanguage() == arabicLang {
                            capacityTF.text = Capacity_Array_ar[0]
                        }else {
                            capacityTF.text = Capacity_Array[0]
                        }
                        Capacity_choose = Capacity_Array[0]
                        
                        delegation_numberView.isHidden = true
                        
                    }
                    EnableLineAnimite(text: capacityTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: capacityLineView, ishidden: true)
                }
            }else if textField == delegation_numberTF {
                EnableLineAnimite(text: delegation_numberTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: delegation_numberLineView, ishidden: true)
            }else if textField == LicenceTF {
                EnableLineAnimite(text: LicenceTF, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: LicenceTFLinceView, ishidden: true)
            }
            
        }
        
    
        return true;
    }
}

extension CreateAccount_3 {
    
    func CompleteRegister() {
        
        var Parameters = [
            "advertiser_id" : "\(user_id)",
            "name" : FullNameTf.text ?? "",
            "password":PasswordFt.text ?? "",
            "password_confirmation" : PasswordFt.text ?? "",
            "side" : Side_choose ,
            "capacity" : Capacity_choose ,
            "firebase_token" : Helper.getFcmtoken() ?? "token",
            "email" : "\(MailTf.text ?? "")"
            
        ]
        
        Parameters["delegation_number"] = delegation_numberTF.text ?? ""
        Parameters["licence_number"] =  LicenceTF.text ?? ""
        Parameters["type_id"] =  type_id_choose
        Parameters["id_number"] =  IdTF.text ?? ""
        
        print(Parameters)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/register-level3-add-details") { (data : RegisterModel_3?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                AuthService.userData = data.data
                Helper.SaveChatType(ChatState: "true")
                
                let storyboard = UIStoryboard(name: Authontication, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "SuccessCreateAccountVC") as! SuccessCreateAccountVC
                self.navigationController?.pushViewController(vc, animated: true)
                self.view.unlock()
                    
                
                print(data)
                
            }
        }
    }
    
    func getTypeId() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)get-id-types") { (data : typeIdModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.type_id_array = data.data ?? []
                self.initPickers(picker: self.TypeIdPicker)
                
                print(data)
                
                
            }
        }
    }
    
}


//MARK:- Picker Controller

extension CreateAccount_3 : UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func initPickers(picker: UIPickerView) {
        
        picker.dataSource = self as! UIPickerViewDataSource
        picker.delegate = self as! UIPickerViewDelegate
        picker.tintColor = #colorLiteral(red: 0.840886116, green: 0.6630725861, blue: 0.2519706488, alpha: 1)
        picker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == sidePicker {
            
            return Side_Array.count
            
        } else if pickerView == TypeIdPicker {
            
            return type_id_array.count
            
        }
        else if pickerView == capacityPicker {
            
            return Capacity_Array.count
            
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == sidePicker{
            
            if Side_Array.count != 0 {
                if L102Language.currentAppleLanguage() == arabicLang {
                    return Side_Array_ar[row]
                }else {
                    return Side_Array[row]
                }
                
            }
            
        }else if pickerView == TypeIdPicker{
            
            if type_id_array.count != 0 {
               
                return type_id_array[row].type_name
                
                
            }
        }
        else if pickerView == capacityPicker{
            
            if Capacity_Array.count != 0 {
                if L102Language.currentAppleLanguage() == arabicLang {
                    return Capacity_Array_ar[row]
                }else {
                    return Capacity_Array[row]
                }
           
                
                
            }
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == sidePicker{
            
            if Side_Array.count != 0 {
                if L102Language.currentAppleLanguage() == englishLang {
                    sideTF.text = Side_Array[row]
                }else {
                    sideTF.text = Side_Array_ar[row]
                }
                
                Side_choose = Side_Array[row]
                
               
            }
        }else if pickerView == TypeIdPicker{
            
            if type_id_array.count != 0 {
              
                TypeIdTF.text = type_id_array[row].type_name
                
                
                type_id_choose = "\(type_id_array[row].type_id ?? 0)"
                
               
            }
        }
        else if pickerView == capacityPicker {
            
            if Capacity_Array.count != 0 {
               
                
                if L102Language.currentAppleLanguage() == arabicLang {
                    capacityTF.text = Capacity_Array_ar[row]
                }else {
                    capacityTF.text = Capacity_Array[row]
                }
                Capacity_choose = Capacity_Array[row]
                
                if row == 0 {
                    delegation_numberView.isHidden = true
                }else {
                    delegation_numberView.isHidden = false
                }
                
            }
        }
    }
}
