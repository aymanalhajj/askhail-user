//
//  MyInfoVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/14/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class MyInfoVC: UIViewController {
    
    var type_id_array = [typeIdData]()

    @IBOutlet var BackGround: UIView!
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var View1: UIView!
    
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBOutlet weak var sideTF: UILabel!
    @IBOutlet weak var TypeIdTF: UILabel!
    @IBOutlet weak var IdTF: UILabel!
    @IBOutlet weak var capacityTF: UILabel!
    @IBOutlet weak var delegation_numberTF: UILabel!
    @IBOutlet weak var LicenceTF: UILabel!
    
    
    @IBOutlet weak var delegation_numberView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: View1 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(AuthService.userData)
        
        getTypeId() 
        
        UserName.text = AuthService.userData?.advertiser_name
        Email.text = AuthService.userData?.advertiser_email
        phoneNumber.text = AuthService.userData?.advertiser_mobile
        
        sideTF.text = AuthService.userData?.advertiser_side?.localized
        TypeIdTF.text = AuthService.userData?.advertiser_type?.localized
        IdTF.text = AuthService.userData?.advertiser_id_number
        capacityTF.text = AuthService.userData?.advertiser_capacity?.localized
        
        if AuthService.userData?.advertiser_delegation_number != "" , AuthService.userData?.advertiser_delegation_number != nil {
            delegation_numberView.isHidden = false
            delegation_numberTF.text = AuthService.userData?.advertiser_delegation_number?.localized
        }else {
            delegation_numberView.isHidden = true
        }
        
        LicenceTF.text = AuthService.userData?.advertiser_licence_number
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func EditInfoAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "EditMyInfoVC") as! EditMyInfoVC
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func EditPasswordAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "EditPasswordVC") as! EditPasswordVC
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

}

extension MyInfoVC {
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
                
                
                for item in self.type_id_array {
                    if item.type_id == AuthService.userData?.advertiser_type_id {
                        self.TypeIdTF.text = item.type_name
                    }
                }
                
                print(data)
                
                
            }
        }
    }
}

