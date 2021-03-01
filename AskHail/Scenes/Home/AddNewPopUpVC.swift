//
//  AddNewPopUpVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import PMAlertController


var order_id_Status = ""

protocol AddNewProtocl {
    func AddNew(status : Int)
}

class AddNewPopUpVC: UIViewController {
    
    var Delegate : AddNewProtocl?
    var Ad_id = ""
    var Order_id = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        showAnimate()
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        tabBarController?.tabBar.isHidden = false
        removeAnimate()
    }
    
    @IBAction func AddNewAdsAction(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        tabBarController?.tabBar.isHidden = false
        CkeckIfHaveOldAds()
        
    }
    
    @IBAction func NewRequestAction(_ sender: Any) {
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        tabBarController?.tabBar.isHidden = false
        
        CkeckIfHaveOldOrder()
        
    }
    
    
    @IBAction func NewQuestion(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        tabBarController?.tabBar.isHidden = false
        
        Delegate?.AddNew(status: 3)
        removeAnimate()
        
    }
    
    
}

//MARK:API Service

extension AddNewPopUpVC {
    
    func CkeckIfHaveOldAds() {
        self.view.lock()
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)user-add-advertisement/level1-check-last-not-completed-advertisement") { (data : Level_1_Model?, String) in
            
            self.view.unlock()
            if String != nil {
                
                self.Delegate?.AddNew(status: 1)
                self.removeAnimate()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.removeAnimate()
                
                
                let alertVC = PMAlertController(title: "Advertisement".localized, description: data.message ?? "", image: nil, style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "Complete now".localized, style: .default, action: { () -> Void in
                    
                    self.getAdvNewOrContinue(state: "continue")
                    
                    if data.data?.next_level == 2 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "ChoseGradeVC") as! ChoseGradeVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else if data.data?.next_level == 3 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPlaceTypeVC") as! AdsPlaceTypeVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else if data.data?.next_level == 4 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsAddPhotoVC") as! AdsAddPhotoVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    } else if data.data?.next_level == 5 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsDetailsVC") as! AdsDetailsVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    } else if data.data?.next_level == 6 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsContactNumberVC") as! AdsContactNumberVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    
                    print("Complete")
                }))
                
                alertVC.addAction(PMAlertAction(title:  "New one".localized, style: .default, action: { () in
                    self.getAdvNewOrContinue(state: "new")
                    self.Delegate?.AddNew(status: 1)
                    self.removeAnimate()
                    print("Complite now")
                }))
                
                alertVC.addAction(PMAlertAction(title:  "Cancel".localized, style: .cancel, action: { () in
                    
                }))
                
                self.present(alertVC, animated: true, completion: nil)
                
                print(data)
                

            }
        }
        
    }
        
    
    func CkeckIfHaveOldOrder() {
        self.view.lock()
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)user-add-order/level1-check-last-not-completed-order") { (data : Order_lvl_1_Model?, String) in
            
            self.view.unlock()
            if String != nil {
              self.getOrderNewOrContinue(state : "new")
//            self.Delegate?.AddNew(status: 2)
//            self.removeAnimate()
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.removeAnimate()
                
                let alertVC = PMAlertController(title: "Order".localized, description: data.message ?? "", image: nil, style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "Complete now".localized, style: .default, action: { () -> Void in
                    
                    self.getOrderNewOrContinue(state : "continue")
                    
                    if data.data?.next_level == 2 {
                        
                        print(data)
                        
                        let storyboard = UIStoryboard(name: Order, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
                        vc.Ad_id = "\(data.data?.order_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else if data.data?.next_level == 3 {
                        
                        let storyboard = UIStoryboard(name: Order, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "OrderContactNumberVC") as! OrderContactNumberVC
                        vc.Ad_id = "\(data.data?.order_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    } else if data.data?.next_level == 4 {
                        
                        let storyboard = UIStoryboard(name: Order, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "PlaceTypeVC") as! PlaceTypeVC
                        vc.Ad_id = "\(data.data?.order_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    
                }))
                
                
                
                alertVC.addAction(PMAlertAction(title:  "New one".localized, style: .default, action: { () in
                    
                  self.getOrderNewOrContinue(state : "new")
                    
                    
                }))
                
                alertVC.addAction(PMAlertAction(title:  "Cancel".localized, style: .cancel, action: { () in
                    
                }))
                
                self.present(alertVC, animated: true, completion: nil)
                
                print(data)
                
            }
        }
        
    }
    

    func getAdvNewOrContinue(state : String) {
        
        let Parameters = [
            "desire" : state
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user-add-advertisement/choose-continue-or-new") { (data : Level_1_Model?, String) in
            
            if String != nil {
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                
                print(data)
                
            }
        }
    }
    
    func getOrderNewOrContinue(state : String) {
        
        
        let Parameters = [
            "desire" : state
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user-add-order/choose-continue-or-new") { (data : Order_lvl_1_Model?, String) in
            
            if String != nil {
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                

                order_id_Status = "\(data.data?.order_id ?? 0)"
                
                if state == "new" {
                    self.Delegate?.AddNew(status: 2)
                    self.removeAnimate()
                    
                }
                
            
                print("order_id_Status")
                
//                print(data.data?.order_id)
                
            }
        }
    }
    
}


