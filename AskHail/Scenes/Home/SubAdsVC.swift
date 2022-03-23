//
//  SubAdsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//



import UIKit
import PMAlertController

class SubAdsVC: UIViewController ,UITextFieldDelegate       {
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TopBar: UIView!
    
    @IBOutlet weak var contanierView: UIView!
    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var AdvTableView: UITableView!
    @IBOutlet weak var OrderTableView: UITableView!
    
    @IBOutlet weak var MapBtn: UIButton!
    @IBOutlet weak var AddNewOrder: UIButton!
    
    @IBOutlet weak var AdvBtn: UIButton!
    @IBOutlet weak var OrderBtn: UIButton!
    
    @IBOutlet weak var AdvWidth: NSLayoutConstraint!
    @IBOutlet weak var OrderWidth: NSLayoutConstraint!
    
    @IBOutlet weak var AdvLineView: UIView!
    @IBOutlet weak var OrderLineView: UIView!
    
    
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var SearchTF: UITextField!
    
    @IBOutlet weak var SearchBtn: UIButton!
    @IBOutlet weak var SecondSearchBtn: UIButton!
    
    @IBOutlet weak var CancelBtn: UIButton!
    
    
    @IBOutlet weak var PageTitle: UILabel!
    @IBOutlet weak var filterBtn: UIButton!
    
    
    @IBOutlet weak var LoadingView: UIView!
    
    var isbackToAds = false
    
    var order_by = ""
    var side = ""
    var block = ""
    var subSectionTitle = ""
    
    var isSaved = false
    
    var OrdersArray : [OrderData] = []
    
    var SpecialAdsArray : [AdsData] = []
    
    var AdsData = false
    var OrderData = false
    
    var CurrentPg = "advertisements"
    
    var Id = ""
    
    var backToHome = 0
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        PageTitle.text = subSectionTitle
        
        noDataLabel.text = "There are no new ads at the moment. Click the + icon to add a new one.".localized

        SearchTF.returnKeyType = UIReturnKeyType.search
        
        SearchView.isHidden = true
        
        AdvWidth.constant = contanierView.frame.width / 2
        OrderWidth.constant = contanierView.frame.width / 2
        
        OrderLineView.roundCorners([.topLeft, .topRight], radius: 4)
        AdvLineView.roundCorners([.topLeft, .topRight], radius: 4)
        
        
        OrderBtn.alpha = 0.5
        OrderLineView.alpha = 0
        
        AdvTableView.isHidden = true
        OrderTableView.isHidden = true
        
        LoadingView.backgroundColor = Colors.ViewBackGroundColoer
        AdvTableView.backgroundColor = Colors.ViewBackGroundColoer
        OrderTableView.backgroundColor = Colors.ViewBackGroundColoer
        BackGround.backgroundColor = Colors.ViewBackGroundColoer

        
        AdvTableView.dataSource = self
        AdvTableView.delegate = self
        AdvTableView.RegisterNib(cell: SubAdsCell.self)
        
        OrderTableView.dataSource = self
        OrderTableView.delegate = self
        OrderTableView.RegisterNib(cell: OrderCell.self)
        
        SearchTF.delegate = self
        
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.LoadingView.isHidden = false
       // CurrentPage = 1
        
        print(CurrentPage , lastPage)
        
        
        if CurrentPg == "advertisements" {
            reloadToAdv()
        } else {
            reloadToOrder()
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == SearchTF {
            textField.resignFirstResponder()
            performAction()
        }
        return true
    }
    
    func performAction() {
        
        CurrentPage = 1
        lastPage = 1
        SpecialAdsArray.removeAll()
        
        AdvBtn.alpha = 1
        AdvLineView.alpha = 1
        OrderBtn.alpha = 0.5
        OrderLineView.alpha = 0
        CurrentPg = "advertisements"
        getAdsData()
        
    }
    
    
    @IBAction func AddNewOrderAction(_ sender: Any) {
        
        if CurrentPg == "advertisements" {
            CkeckIfHaveOldAds()
        }else {
            CkeckIfHaveOldOrder()
        }
        

        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        if backToHome == 1 {
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
            backToHome = 0
        }else{
            
            navigationController?.popViewController(animated: true)
            
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        SearchView.isHidden = false
        CancelBtn.alpha = 0
        self.SearchTF.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.SecondSearchBtn.center.x += 100
            self.SecondSearchBtn.frame.size.width = 200
            self.CancelBtn.alpha = 1
        }, completion: { _ in
            self.SearchTF.alpha = 1
        })
        
        
    }
    
    @IBAction func SecondSearchAction(_ sender: Any) {
        
        
        
    }
    
    
    
    @IBAction func CancelAction(_ sender: Any) {
        
        CurrentPage = 1
        lastPage = 1
        SpecialAdsArray.removeAll()
        SearchTF.text = ""
        AdvBtn.alpha = 1
        AdvLineView.alpha = 1
        OrderBtn.alpha = 0.5
        OrderLineView.alpha = 0
        CurrentPg = "advertisements"
        getAdsData()
        
        
        self.SearchView.isHidden = true
        
        UIView.animate(withDuration: 0.4, animations: {
            self.SearchBtn.center.x -= 100
            self.SearchBtn.frame.size.width = -200
            
        }, completion: { _ in
            
            
        })
        
        
        
    }
    
    @IBAction func FilterAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "SubFilterVC") as! SubFilterVC
        vc.Delegte = self
        vc.currentPage = CurrentPg
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func ToMapAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vc.Section_id = Id
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func AdsAction(_ sender: Any) {
        
        noDataLabel.text = "There are no new ads at the moment. Click the + icon to add a new one.".localized
        
        CurrentPage = 1
        lastPage = 1
        SpecialAdsArray.removeAll()
        
        filterBtn.isHidden = false
        SearchBtn.isHidden = false
        
        AdvBtn.alpha = 1
        AdvLineView.alpha = 1
        OrderBtn.alpha = 0.5
        OrderLineView.alpha = 0
        CurrentPg = "advertisements"
        getAdsData()
        
    }
    
    
    @IBAction func OrderAcrion(_ sender: Any) {
        noDataLabel.text = "There are no new requests at the moment. Click the + icon to add a new order".localized

        CurrentPage = 1
        lastPage = 1
        OrdersArray.removeAll()
        filterBtn.isHidden = true
        SearchBtn.isHidden = true
        
        AdvBtn.alpha = 0.5
        AdvLineView.alpha = 0
        OrderBtn.alpha = 1
        OrderLineView.alpha = 1
        CurrentPg = "orders"
        
        getOrdderData()
    }
}

//MARK:CollectionView Controller

extension SubAdsVC : UITableViewDataSource ,UITableViewDelegate {
    
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
                    
                    
                    if CurrentPg == "advertisements" {
                        
                        self.getAdsData()
                    }else {
                        self.getOrdderData()
                    }
                }
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if CurrentPg == "advertisements" {
            return SpecialAdsArray.count
            
        }else {
            return OrdersArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if CurrentPg == "advertisements" {
            
            let cell = AdvTableView.dequeue() as SubAdsCell
            
            if AdsData {
                
                var Model = SpecialAdsArray[indexPath.row]
                
                cell.ImagesUrl = Model.adv_media ?? []
                cell.pageControl.numberOfPages =  Model.adv_media?.count ?? 0
                cell.PagerView.reloadData()
                cell.name.text = Model.adv_title
                cell.Price.text = Model.adv_price
                cell.distance.text = Model.adv_distance
                cell.ViewsNumber.text = Model.adv_views
                
                if cell.ImagesUrl.count > 1 {
                    cell.pageControl.isHidden = false
                }else {
                    cell.pageControl.isHidden = true
                }
                
                if "\(Model.adv_advertiser_id ?? 0)" == "\(AuthService.userData?.advertiser_id ?? 0)" {
                    cell.SaveBtn.isHidden = true
                }else{
                    cell.SaveBtn.isHidden = false
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
                    vc.is_Success = false
                        vc.user_id = "\(self.SpecialAdsArray[indexPath.row].adv_advertiser_id ?? 0)"
                        vc.AdId = "\(self.SpecialAdsArray[indexPath.row].adv_id ?? 0)"
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
            
        } else {
            
            let cell = OrderTableView.dequeue() as OrderCell
            
            setShadow(view: cell, width: 1, height: 1, shadowRadius: 0.5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7133837342, green: 0.699488461, blue: 0.6991828084, alpha: 1))
            
            if OrderData {
                
                let Model = OrdersArray[indexPath.row]
                
                cell.OrderName.text = Model.order_advertiser_name ?? ""
                cell.OrderTime.text = Model.order_custom_date ?? ""
                cell.OrderTitle.text = Model.order_title ?? ""
                cell.OrderPrice.text = "less than ".localized + "\(Model.order_price ?? "")"
                
                cell.IsNewView.isHidden = false
                if Model.order_date_status ?? "" == "" {
                    cell.IsNewView.isHidden = true
                }
                
            }
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if CurrentPg == "advertisements" {
            return 200
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if CurrentPg == "advertisements" {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
            vc.user_id = "\(self.SpecialAdsArray[indexPath.row].adv_advertiser_id ?? 0)"
            vc.AdId = "\(self.SpecialAdsArray[indexPath.row].adv_id ?? 0)"
            vc.is_Success = false
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "OrderVC") as! OrderVC
            vc.Order_id = "\(OrdersArray[indexPath.row].order_id ?? 0)"

            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func reloadToAdv() {
        CurrentPage = 1
        lastPage = 1
        SpecialAdsArray.removeAll()
        AdvBtn.alpha = 1
        AdvLineView.alpha = 1
        OrderBtn.alpha = 0.5
        OrderLineView.alpha = 0
        MapBtn.isHidden = false
        CurrentPg = "advertisements"
        getAdsData()
    }
    
    func reloadToOrder() {
        CurrentPage = 1
        lastPage = 1
        OrdersArray.removeAll()
        AdvBtn.alpha = 0.5
        AdvLineView.alpha = 0
        OrderBtn.alpha = 1
        OrderLineView.alpha = 1
        MapBtn.isHidden = true
        CurrentPg = "orders"
        getOrdderData()
    }
    
}

extension SubAdsVC : refreshData {
    
    func refresh(state: Int, Order: String, sidee: String, regionn: String) {
        if state == 1 {
            self.order_by = Order
            self.side = sidee
            self.block = regionn
            reloadToAdv()
        }else if state == 2{
            self.order_by = Order
            self.side = sidee
            self.block = regionn
            reloadToOrder()
            
        }
        
    }
}

//MARK:API

extension SubAdsVC {
    
    func getAdsData() {
        self.MapBtn.isHidden = true
        self.view.lock()
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)sub-section-advertisements/\(Id)?order_by=\(order_by)&side=\(side)&block=\(block)&page=\(CurrentPage)&search=\(self.SearchTF.text ?? "")") { (data : AllSpecialAdsModel?, String) in
            
            self.view.unlock()
            self.LoadingView.isHidden = true
            
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
                
                if self.SpecialAdsArray.count > 0 {
                    self.MapBtn.isHidden = false
                    self.isActive = true
                    self.OrderTableView.isHidden = true
                    self.AdvTableView.isHidden = false
                }else {
                    self.OrderTableView.isHidden = true
                    self.AdvTableView.isHidden = true
                    self.MapBtn.isHidden = true
                    
                }
                
                self.AdsData = true
                
                self.AdvTableView.reloadData()
                
                self.isActive = true
                
                print(data)
                
            }
        }
    }
    
    func getOrdderData() {
        
        self.view.lock()
        self.MapBtn.isHidden = true
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)sub-section-orders/\(Id)?page=\(CurrentPage)") { (data : MyOrderModel?, String) in
            self.LoadingView.isHidden = true
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
            
                
                print(self.CurrentPage , self.lastPage)
                
                for item in data.data?.data ?? [] {
                    self.OrdersArray.append(item)
                }
                
                
                if self.OrdersArray.count > 0 {
                   
                    self.OrderTableView.isHidden = false
                    self.AdvTableView.isHidden = true
                    
                }else {
                    self.OrderTableView.isHidden = true
                    self.AdvTableView.isHidden = true
                    self.MapBtn.isHidden = true
                    
                }
                
                self.OrderData = true
                self.OrderTableView.reloadData()
                
                self.isActive = true
                
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

//MARK:API add new Adv
extension SubAdsVC {
    
    func CkeckIfHaveOldAds() {
        
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)user-add-advertisement/level1-check-last-not-completed-advertisement") { (data : Level_1_Model?, String) in
            
            if String != nil {
                
                let storyboard = UIStoryboard(name: AddAds , bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AdsTermsVC") as! AdsTermsVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                let alertVC = PMAlertController(title: "Advertisement".localized, description: data.message ?? "", image: nil, style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "Complete now".localized, style: .default, action: { () -> Void in
                    
                    if data.data?.next_level == 2 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "ChoseGradeVC") as! ChoseGradeVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else if data.data?.next_level == 3 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPlaceTypeVC") as! AdsPlaceTypeVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else if data.data?.next_level == 4 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsAddPhotoVC") as! AdsAddPhotoVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    } else if data.data?.next_level == 5 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsDetailsVC") as! AdsDetailsVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    } else if data.data?.next_level == 6 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsContactNumberVC") as! AdsContactNumberVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    self.getNewOrContinue(state: "continue")
                    
                    
                }))
                
                alertVC.addAction(PMAlertAction(title:  "New one".localized, style: .default, action: { () in
                    
                    self.getNewOrContinue(state: "new")
                    
                    let storyboard = UIStoryboard(name: AddAds , bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "AdsTermsVC") as! AdsTermsVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    print("Complite now")
                    
  
                }))
                
                alertVC.addAction(PMAlertAction(title:  "Cancel".localized, style: .cancel, action: { () in
                    
                }))
                
                self.present(alertVC, animated: true, completion: nil)
                
                print(data)
                

            }
        }
        
    }
    

    func getNewOrContinue(state : String) {
        
        let Parameters = [
            "desire" : state
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user-add-advertisement/choose-continue-or-new") { (data : RealEstateShotModel?, String) in
            
            if String != nil {
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                               
                print(data)
                
            }
        }
    }
}
//MARK:API Add new Order

extension SubAdsVC {
    
    func CkeckIfHaveOldOrder() {
        self.view.lock()
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)user-add-order/level1-check-last-not-completed-order") { (data : Order_lvl_1_Model?, String) in
            self.view.unlock()
            
            if String != nil {
                
                self.getOrderNewOrContinue(state : "new")
                
            }else {
                
                guard let data = data else {
                    return
                }
                
             
                
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
                
                if state == "new" {
                    let storyboard = UIStoryboard(name: Order, bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "TermsOfNewOrderVC") as! TermsOfNewOrderVC
                    vc.Ad_id = "\(data.data?.order_id ?? 0)"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                
            }
        }
    }
    
}

