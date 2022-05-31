//
//  HomeVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//ccccc

import UIKit

var app_enable_show_count = false

class HomeVC: BaseViewController {
    
    @IBOutlet weak var BackGround: UIView!
    @IBOutlet weak var BackGroundView : UIView!
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var StarAdsCollection: UICollectionView!
    @IBOutlet weak var BusinessSectorCollection: UICollectionView!
    @IBOutlet weak var MediaCollectionview: UICollectionView!
    
    @IBOutlet weak var RealEstateHeightCollectionView: NSLayoutConstraint!
    @IBOutlet weak var realtyCollection: UICollectionView!
    
    var SpecialAdsArray : [Special_advertisements] = []
    var StarDataCount = false
    
    var RealEstateArray : [Real_estate] = []
    var RealEstateData = false
    
    var BusinessArray : [Business] = []
    var BusinessData = false
    
    var FamousArray = [Famous]()
    var FamousData = false
    
    var isSaved = false

    var x = 0.0
    
    
  
    var carousalTimer: Timer?
    var newOffsetX: CGFloat = 0.0
    
    
   // @IBOutlet weak var ScrollHeight: NSLayoutConstraint!
    
    @IBOutlet weak var BusnissHeightCollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var MediaHeightCollectionView: NSLayoutConstraint!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        App_Info()
        NotificationCenter.default.addObserver(self, selector: #selector(showPopUp), name: NSNotification.Name(rawValue: NotificationCenterpreePlusBtn), object: nil)
        tabBarController?.tabBar.isHidden = false
        getHome()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Tajawal-Regular", size: 12)!], for: .normal)
        
        tabBarController?.tabBar.items?[0].title = "Home".localized
        tabBarController?.tabBar.items?[1].title = "Chat".localized
        tabBarController?.tabBar.items?[4].title = "More".localized
        tabBarController?.tabBar.items?[3].title = "Ask Hail".localized
      
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        StarAdsCollection.delegate = self
        StarAdsCollection.dataSource = self
        StarAdsCollection.RegisterNib(cell: StarAdsCell.self)
        StarAdsCollection.RegisterNib(cell: AllSpecialAdsCell.self)
        
        StarAdsCollection.flipX()
        BusinessSectorCollection.flipX()
        realtyCollection.flipX()
        MediaCollectionview.flipX()
        
        BusinessSectorCollection.delegate = self
        BusinessSectorCollection.dataSource = self
        BusinessSectorCollection.RegisterNib(cell: BusinessSectorCell.self)
        
        MediaCollectionview.delegate = self
        MediaCollectionview.dataSource = self
        MediaCollectionview.RegisterNib(cell: BusinessSectorCell.self)
        
        realtyCollection.delegate = self
        realtyCollection.dataSource = self
        realtyCollection.RegisterNib(cell: BusinessSectorCell.self)
        
        
        BackGroundView.backgroundColor = Colors.ViewBackGroundColoer
        StarAdsCollection.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        
        
        
        self.BusinessSectorCollection.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        BusinessSectorCollection.layer.removeAllAnimations()
        DispatchQueue.main.async {
            self.BusnissHeightCollectionView.constant = self.BusinessSectorCollection.contentSize.height
            self.MediaHeightCollectionView.constant = self.MediaCollectionview.contentSize.height
        }
        
        
     //   ScrollHeight.constant = BusinessSectorCollection.contentSize.height + 550
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    

    
    @IBAction func NotificationAction(_ sender: Any) {
        
        guard AuthService.userData?.advertiser_api_token != nil else {
            
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: Notification_Stry, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func PrayTimeAction(_ sender: Any) {
        
        guard AuthService.userData?.advertiser_api_token != nil else {
            
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "PrayTimeVC") as! PrayTimeVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
}

//MARK:- CollectionView Controller
extension HomeVC : UICollectionViewDataSource , UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == StarAdsCollection {
            
            if !StarDataCount  {
                return 5
            }else {
                
                if SpecialAdsArray.count == 0 {
                    StarAdsCollection.isHidden = true
                    return 0
                }else {
                    
                    return SpecialAdsArray.count + 1
                }
               
            }
            
        } else if collectionView == realtyCollection {
            
            if !RealEstateData {
                return 3
            }else {
                return RealEstateArray.count
            }
            
        } else if collectionView == BusinessSectorCollection {
            
            if !BusinessData {
                return 12
            }else{
                print(BusinessArray.count)
                return BusinessArray.count
            }
            
        }else {
            if !FamousData {
                return 12
            }else{
                return FamousArray.count
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == StarAdsCollection {
            
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarAdsCell", for: indexPath) as! StarAdsCell
            
            cell.SubView.backgroundColor = Colors.DarkBlue
            cell.SubView.alpha = 0.5
            
            if app_enable_show_count == false {
                cell.ViewsStack.isHidden = true
            }else {
                cell.ViewsStack.isHidden = false
            }
            
            
            if self.StarDataCount {
                
                if indexPath.row == SpecialAdsArray.count {
                    
                    let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "AllSpecialAdsCell", for: indexPath) as! AllSpecialAdsCell
                    
                    cell1.bgView.alpha = 0.4
                    cell1.flipX()
                    return cell1
                    
                }
                
                var Model = SpecialAdsArray[indexPath.row]
                
                if "\(Model.adv_advertiser_id ?? 0)" == "\(AuthService.userData?.advertiser_id ?? 0)" {
                    cell.SaveBtn.isHidden = true
                }else{
                    cell.SaveBtn.isHidden = false
                }
                
                cell.BackGroundImage.loadImage(URL(string: Model.adv_promotional_image ?? ""))
                cell.Price.text = Model.adv_price
                cell.title.text = Model.adv_title
                cell.distance.text = Model.adv_distance
                
                if Model.adv_price ?? "" == "0" {
                    cell.SARLbl.isHidden = true
                    cell.Price.isHidden = true
                }else{
                    cell.Price.text = Model.adv_price
                }
                

                cell.SpecialView.isHidden = true
                isSaved = Model.adv_is_favorite ?? false
                
                if Model.adv_special_status == "special" || Model.adv_special_status == "مميز" {
                    cell.SpecialView.isHidden = false
                }
                
                cell.ViewsNumber.text = Model.adv_views
                
                if Model.adv_is_favorite == true {
                     cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white-1"), for: .normal)
                }else{
                    cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
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
            
            
            cell.flipX()
            return cell
            
        } else if collectionView == realtyCollection {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessSectorCell", for: indexPath) as! BusinessSectorCell
            
            if self.RealEstateData {
                
                var Model = RealEstateArray[indexPath.row]
                
                cell.title.text = Model.section_name
                cell.BackGroundImage.loadImage(URL(string: Model.section_image ?? ""))
                
            }
            
            cell.flipX()
            return cell
            
        } else if collectionView == BusinessSectorCollection {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessSectorCell", for: indexPath) as! BusinessSectorCell
            
            if self.BusinessData {
                var Model = BusinessArray[indexPath.row]
                
                cell.BackGroundImage.loadImage(URL(string: Model.section_image ?? ""))
                cell.title.text = Model.section_name
                
            }
            
            self.BusnissHeightCollectionView.constant = BusinessSectorCollection.contentSize.height
            
            cell.flipX()
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessSectorCell", for: indexPath) as! BusinessSectorCell
            
            if self.FamousData {
                var Model = FamousArray[indexPath.row]
                    
                
                
                cell.BackGroundImage.loadImage(URL(string: Model.section_image ?? ""))
                cell.title.text = Model.section_name
                
            }
            
            cell.flipX()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == StarAdsCollection {
            
            if indexPath.row == SpecialAdsArray.count {
                
                let storyboard = UIStoryboard(name: Home, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AllSpecialAdsVC") as! AllSpecialAdsVC
                navigationController?.pushViewController(vc, animated: true)
                return collectionView.deselectItem(at: indexPath, animated: true)
                
            }
            
            if SpecialAdsArray[indexPath.row].adv_type ?? "" == "real_estate" {
                
                if "\(SpecialAdsArray[indexPath.row].adv_advertiser_id ?? 0)" == "\(AuthService.userData?.advertiser_id ?? 0)" {
                    
                    let storyboard = UIStoryboard(name: Home, bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
                    vc.AdId = "\(SpecialAdsArray[indexPath.row].adv_id ?? 0)"
//                    vc.User_id = SpecialAdsArray[indexPath.row].adv_advertiser_id ?? 0
//                    vc.isMyAdv = 0
                    navigationController?.pushViewController(vc, animated: true)
                    
                }else{
                    
                let storyboard = UIStoryboard(name: Home, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
                vc.AdId = "\(SpecialAdsArray[indexPath.row].adv_id ?? 0)"
                vc.isHome = 1
                navigationController?.pushViewController(vc, animated: true)
                return collectionView.deselectItem(at: indexPath, animated: true)
                }
                
            }else{
                let storyboard = UIStoryboard(name: Home, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC") as! BusinessAdsDetailsVC
                vc.AdId = "\(SpecialAdsArray[indexPath.row].adv_id ?? 0)"
                vc.isHome = 1
                navigationController?.pushViewController(vc, animated: true)
                return collectionView.deselectItem(at: indexPath, animated: true)
            }
            
        } else if collectionView == realtyCollection {
            
            if RealEstateArray[indexPath.row].section_type == "business" {
                let storyboard = UIStoryboard(name: Home, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "RealtySaleVC") as! RealtySaleVC
                vc.id = "\(RealEstateArray[indexPath.row].section_id ?? 0)"
                vc.Title = RealEstateArray[indexPath.row].section_name ?? ""
                vc.state = 2
                navigationController?.pushViewController(vc, animated: true)
                return collectionView.deselectItem(at: indexPath, animated: true)
            }else {
                let storyboard = UIStoryboard(name: Home, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "RealtySaleVC") as! RealtySaleVC
                vc.id = "\(RealEstateArray[indexPath.row].section_id ?? 0)"
                vc.Title = RealEstateArray[indexPath.row].section_name ?? ""
                vc.state = 1
                navigationController?.pushViewController(vc, animated: true)
            }
            
           
            
            return collectionView.deselectItem(at: indexPath, animated: true)
            
            
        } else if collectionView == BusinessSectorCollection  {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "RealtySaleVC") as! RealtySaleVC
            vc.id = "\(BusinessArray[indexPath.row].section_id ?? 0)"
            vc.Title = BusinessArray[indexPath.row].section_name ?? ""
            vc.state = 2
            navigationController?.pushViewController(vc, animated: true)
            return collectionView.deselectItem(at: indexPath, animated: true)
            
        }else {
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "RealtySaleVC") as! RealtySaleVC
            vc.id = "\(FamousArray[indexPath.row].section_id ?? 0)"
            vc.Title = FamousArray[indexPath.row].section_name ?? ""
            vc.state = 2
            navigationController?.pushViewController(vc, animated: true)
        }
        
        return collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

extension HomeVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == realtyCollection {
            let width = (collectionView.frame.width - 64)/3
            var height = (collectionView.frame.height-10)/2
            if RealEstateHeightCollectionView.constant == 104 {
                height = collectionView.frame.height
            }else {
                height = (collectionView.frame.height-10)/2
            }
           
            
            return CGSize.init(width: width , height:height)
            
        } else if collectionView == BusinessSectorCollection {
            
            var width = (collectionView.frame.width - 8)/2
            
            if indexPath.row == 0 {
                
                width = (collectionView.frame.width)
                
            }
            
            return CGSize.init(width: width , height:120)
        } else if collectionView == MediaCollectionview {
            
            var width = (collectionView.frame.width - 8)/2
            
            if indexPath.row == 0 {
                
                width = (collectionView.frame.width)
                
            }
            
            return CGSize.init(width: width , height:120)
        }else {
            
            var width = collectionView.frame.width - 48
            
            return CGSize.init(width: width , height:collectionView.frame.height)
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0)
        UIView.animate(
            withDuration: 0.4,
            animations: {
                cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
            }, completion: nil)
    }
    
    
}

extension HomeVC {
    
    
    func AddToFavourite(advertisement_id : String) {
                
        let param = [
            "advertisement_id" : advertisement_id
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)advertisement-operations/add-remove-favorite") { (data : ContactUsModel?, String) in
            //self.view.unlock()
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
    
    
    func getHome() {
        
        DispatchQueue.main.async {
            self.StarAdsCollection.layoutIfNeeded()
            self.BusinessSectorCollection.layoutIfNeeded()
            self.realtyCollection.layoutIfNeeded()
            self.BusinessSectorCollection.showLoader()
            self.StarAdsCollection.showLoader()
            self.realtyCollection.showLoader()
            self.MediaCollectionview.showLoader()
        }
    
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)main-page") { (data : HomeModel?, String) in
            if String != nil {
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.StarAdsCollection.hideLoader()
                self.SpecialAdsArray = data.data?.special_advertisements ?? []
                self.StarDataCount = true
                
                self.realtyCollection.hideLoader()
                self.RealEstateArray = data.data?.real_estate ?? []
                
                
                self.RealEstateData = true
                
                if self.RealEstateArray.count <= 3 {
                    self.RealEstateHeightCollectionView.constant = 104
                }
                
                self.BusinessSectorCollection.hideLoader()
                self.BusinessArray = data.data?.business ?? []
                
                print(self.BusinessArray.count)
                self.BusinessData = true
                
                self.MediaCollectionview.hideLoader()
                self.FamousArray = data.data?.famous ?? []
                self.FamousData = true
                
                print(self.BusinessArray.count)
                
                self.StarAdsCollection.reloadData()
                self.realtyCollection.reloadData()
                self.BusinessSectorCollection.reloadData()
                self.MediaCollectionview.reloadData()
                
                print(data)
                
                
            }
        }
    }
    

    
    func App_Info() {
        
        
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)app-info") { (data : AboutUsModel?, String) in
            
          
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
               app_enable_show_count = data.data?.app_enable_show_count ?? false
                
                print(data.data?.app_banner ?? "")
                if (data.data?.app_banner ?? "") != "" {
                    let storyboard = UIStoryboard(name: Home, bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "AdsBannerVC") as! AdsBannerVC
                    
                    vc.Banner_url = data.data?.app_banner_url ?? ""
                    vc.imageUrl = data.data?.app_banner ?? ""
                    
                    vc.modalPresentationStyle = .fullScreen
                    self.addChild(vc)
                    vc.view.frame = self.view.frame
                    
                    self.view.addSubview(vc.view)
                    vc.didMove(toParent: self)
                }
               
                
                
                print(app_enable_show_count)

            }
        }
    }
    
}
