//
//  AllSpecialAdsVC.swift
//  AskHail
//
//  Created by bodaa on 29/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AllSpecialAdsVC: UIViewController {

    @IBOutlet weak var SpecialAdsTableView: UITableView!
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    
    var order_by = ""
    var side = ""
    var block = ""
    
    
    
    @IBOutlet weak var TopLabol: UILabel!
    
    var isActive = true
    
    private func createSpinnerFooter() -> UIView {
        let FooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        FooterView.backgroundColor = .clear
        let spinner = UIActivityIndicatorView()
        
        spinner.style = .large
        spinner.color = #colorLiteral(red: 0, green: 0.2846388221, blue: 0.497141242, alpha: 1)
        
        spinner.center = FooterView.center
        FooterView.addSubview(spinner)
        spinner.startAnimating()
        
        return FooterView
        
    }
    
    var CurrentPage = 1
    var lastPage = 1

    
    var SpecialAdsArray : [AdsData] = []
    var SpecialAdsData = false
    
    var isSaved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSpecialAds()
        
        tabBarController?.tabBar.isHidden = true
        SpecialAdsTableView.backgroundColor = Colors.ViewBackGroundColoer
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))

        SpecialAdsTableView.dataSource = self
        SpecialAdsTableView.delegate = self
        SpecialAdsTableView.RegisterNib(cell: SubAdsCell.self)
        
        
        if L102Language.currentAppleLanguage() == englishLang {
            TopLabol.text = "Show all featured ads"
        }else{
            TopLabol.text = "عرض كل الاعلانات المميزة"
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func FilterAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "SubFilterVC") as! SubFilterVC
        vc.Delegte = self
        vc.currentPage = "advertisements"
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        
    }
    
    
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        tabBarController?.tabBar.isHidden = false

        navigationController?.popViewController(animated: true)
        
    }
    
    func reloadToAdv() {
        CurrentPage = 1
        lastPage = 1
        SpecialAdsArray.removeAll()
       
        
        getSpecialAds()
    }
    
}

extension AllSpecialAdsVC : refreshData {
    
    func refresh(state: Int, Order: String, sidee: String, regionn: String) {
      
            self.order_by = Order
            self.side = sidee
            self.block = regionn
        
        reloadToAdv()
            
        
        
    }
}

//MARK:TAbleView Controller

extension AllSpecialAdsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SpecialAdsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as SubAdsCell
        
        if app_enable_show_count == false {
            cell.ViewStack.isHidden = true
        }else {
            cell.ViewStack.isHidden = false
        }
        
        if SpecialAdsData {
            
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
            } else {
                cell.pageControl.isHidden = true
            }
            
            isSaved = Model.adv_is_favorite ?? false
            
            cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
            
            if Model.adv_is_favorite == true {
                cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white-1"), for: .normal)
            }else{
                cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
            }
            
            cell.StarAdView.isHidden = true
            
            if Model.adv_special_status == "special" || Model.adv_special_status == "مميز" {
                cell.StarAdView.isHidden = false
            }
            
            cell.SelectCell = {
                
                if Model.adv_type ?? "" == "business" {
                    let storyboard = UIStoryboard(name: Home, bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC") as! BusinessAdsDetailsVC
                    vc.AdId = "\(Model.adv_id ?? 0)"
                    self.navigationController?.pushViewController(vc, animated: true)
                }else {
                    let storyboard = UIStoryboard(name: Home, bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
                    vc.AdId = "\(Model.adv_id ?? 0)"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if SpecialAdsArray[indexPath.row].adv_type ?? "" == "business" {
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC") as! BusinessAdsDetailsVC
            vc.AdId = "\(SpecialAdsArray[indexPath.row].adv_id ?? 0)"
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
            vc.AdId = "\(SpecialAdsArray[indexPath.row].adv_id ?? 0)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0)
        UIView.animate(
            withDuration: 0.4,
            animations: {
                cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
            }, completion: nil)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let position = scrollView.contentOffset.y
            let ContentHeight = scrollView.contentSize.height
            // print(position , tableView.contentSize.height)
            if isActive {
                if position > ContentHeight - scrollView.frame.height {
                    
                    print("Done")
                    isActive = false
                    
                    //numberofitem
                    
                    //  print(CurrentPage , lastPage)
                    if CurrentPage < lastPage {
                        
                        CurrentPage = CurrentPage + 1
                        
                        self.getSpecialAds()
                        
                    }
                }
                
            }
            
        }
}

//MARK:API
extension AllSpecialAdsVC {
    
    func getSpecialAds() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)all-special-advertisements??order_by=\(order_by)&side=\(side)&block=\(block)&page=\(CurrentPage)") { (data : AllSpecialAdsModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                 self.lastPage = data.data?.pagination?.last_page ?? 1

                for item in data.data?.data ?? [] {
                    
                    self.SpecialAdsArray.append(item)
                }
                
                self.SpecialAdsTableView.isHidden = true
                if data.data?.data?.count ?? 0 > 0{
                    self.SpecialAdsTableView.isHidden = false
                }
                self.SpecialAdsData = true
                
                
                self.SpecialAdsTableView.reloadData()

                self.isActive = true

                
                print(data)
                
                
            }
        }
    }
    
    func AddToFavourite(advertisement_id : String) {
        
        //  self.view.lock()
        
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
                
                //   self.StarAdsCollection.reloadData()
                
                
                print(data)
                
                
            }
        }
    }
    
}
