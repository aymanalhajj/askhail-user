//
//  UserProfileVC.swift
//  AskHail
//
//  Created by bodaa on 28/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {

    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var TableView: UITableView!

    @IBOutlet weak var CompanyName: UILabel!
    @IBOutlet weak var AdsNumber: UILabel!
    
    var SpecialAdsArray : [AdvData] = []
    var AdsData = false
    
    var isSaved = false
    
    var User_id = ""
    var User_Name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAdvertiserProfile()
        
        CompanyName.text = User_Name
        
        TableView.dataSource = self
        TableView.delegate = self
        TableView.RegisterNib(cell: SubAdsCell.self)
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        TableView.backgroundColor = Colors.ViewBackGroundColoer

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }

}

extension UserProfileVC : UITableViewDataSource ,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SpecialAdsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeue() as SubAdsCell
        
        if AdsData {
            
            var Model = SpecialAdsArray[indexPath.row]
            
            cell.ImagesUrl = Model.adv_media ?? []
            cell.pageControl.numberOfPages =  Model.adv_media?.count ?? 0
            cell.PagerView.reloadData()
            cell.name.text = Model.adv_title
            cell.Price.text = Model.adv_price
            cell.distance.text = Model.adv_distance
            cell.ViewsNumber.text = Model.adv_views
            
            if "\(Model.adv_advertiser_id ?? 0)" == "\(AuthService.userData?.advertiser_id ?? 0)" {
                cell.SaveBtn.isHidden = true
            }else{
                cell.SaveBtn.isHidden = false
            }
            
            if cell.ImagesUrl.count > 1 {
                cell.pageControl.isHidden = false
            }else{
                cell.pageControl.isHidden = true
            }
            
            cell.StarAdView.isHidden = true
            
            if Model.adv_special_status == "special" || Model.adv_special_status == "مميز" {
                cell.StarAdView.isHidden = false
            }
            
            isSaved = Model.adv_is_favorite ?? false
            
            cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
            
            if Model.adv_is_favorite == true {
                cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white-1"), for: .normal)
            }else{
                cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
            }
            
            
            cell.SelectCell = {
                
                let storyboard = UIStoryboard(name: Home, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
                vc.AdId = "\(self.SpecialAdsArray[indexPath.row].adv_id ?? 0)"
                // present(vc, animated: true, completion: nil)
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
            cell.SaveAcrion = {
                
                self.AddToFavourite(advertisement_id: "\(Model.adv_id ?? 0)")
                
                if Model.adv_is_favorite == false {
                    cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white-1"), for: .normal)
                    Model.adv_is_favorite = true
                }else{
                    cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
                    Model.adv_is_favorite = false
                }
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0)
        UIView.animate(
            withDuration: 0.4,
            animations: {
                cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
            }, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
        vc.AdId = "\(self.SpecialAdsArray[indexPath.row].adv_id ?? 0)"
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


extension UserProfileVC {
    
    func getAdvertiserProfile() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)advertiser-page/\(User_id)") { (data : AdvertiserProfileModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.AdsNumber.text = data.data?.advertisements_count ?? ""
                
                if data.data?.data?.count ?? 0 >= 0 {
                    self.SpecialAdsArray = data.data?.data ?? []
                    self.AdsData = true
                }
                
                self.TableView.reloadData()
                
                print(data)
                
                
            }
        }
        
    }
    
    func AddToFavourite(advertisement_id : String) {
        
        let param = [
            
            "advertisement_id" : advertisement_id
            
        ]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)advertisement-operations/add-remove-favorite") { (data : ContactUsModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                print(data)
                
                
            }
        }
    }
    
}
