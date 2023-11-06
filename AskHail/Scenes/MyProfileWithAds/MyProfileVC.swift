//
//  MyProfileVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/10/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {
    @IBOutlet weak var LogOutBtn: UIButton!
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AuthService.userData?.advertiser_api_token == nil {
            
            self.LogOutBtn.setTitle("Log In".localized, for: .normal)
            
        }
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))

        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{ return }
        
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        
        
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
    
    @IBAction func MyAdsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "MyAdsVC") as! MyAdsVC
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func MyRequestsAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "MyOrderVC") as! MyOrderVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func MyPackgeAction(_ sender: Any) {
       
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "MyPackgeVC") as! MyPackgeVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func MyQuestionAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "MyAskVC") as! MyAskVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

    @IBAction func SavedAdsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "MyFavoriteAdsVC") as! MyFavoriteAdsVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func MyInfoAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "MyInfoVC") as! MyInfoVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func LogOuteAction(_ sender: Any) {
        if AuthService.userData?.advertiser_api_token == nil {
            
            AuthService.userData = nil
            
            guard let window = UIApplication.shared.keyWindow else{return}
            
            let sb = UIStoryboard(name: Authontication, bundle: nil)
            var vc : UIViewController
            
            
            vc = sb.instantiateViewController(withIdentifier: "WelcomeVC")
            
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
            
            
        }else {
            Logout()
        }
      
        
    }
    
}

extension MyProfileVC {
    
    func Logout() {
        
        self.view.lock()
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)logout") { (data : RealEstateShotModel?, String) in
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }

                
                self.LogOut()
                
              
                
                print(data)
                
            }
        }
    }
    
}
