//
//  BusinessAdvVC.swift
//  AskHail
//
//  Created by bodaa on 09/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class BusinessAdvVC: UIViewController {
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TopBar: UIView!
    
    
    @IBOutlet weak var AdvTableView: UITableView!
    
    @IBOutlet weak var MapBtn: UIButton!
    
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var SearchTF: UITextField!
    
    @IBOutlet weak var SearchBtn: UIButton!
    @IBOutlet weak var SecondSearchBtn: UIButton!
    
    @IBOutlet weak var CancelBtn: UIButton!
    
    var subSectionTitle = ""
    
    @IBOutlet weak var PageTitle: UILabel!
    
    @IBOutlet weak var filterBtn: UIButton!
    
    
    @IBOutlet weak var LoadingView: UIView!
    
    
    var isSaved = false
    
    var BusinessArray : [BusinessDetails] = []
    
    var AdsData = false
    var OrderData = false
    
    var CurrentPg = "advertisements"
    
    var Id = ""
    
    var backToHome = 0
    
    var isActive = true
    
    var order_by = ""
    var side = ""
    var block = ""
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        var CurrentPage = 1
        var lastPage = 1
        BusinessArray.removeAll()   
        getAdsData()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PageTitle.text = subSectionTitle
        
        SearchTF.returnKeyType = UIReturnKeyType.search
        
        SearchView.isHidden = true
        LoadingView.backgroundColor = Colors.ViewBackGroundColoer
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        AdvTableView.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        AdvTableView.dataSource = self
        AdvTableView.delegate = self
        AdvTableView.RegisterNib(cell: BusinessSubAdsCell.self)
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == SearchTF {
            textField.resignFirstResponder()
            getAdsData()
        }
        return true
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
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
        
        CurrentPage = 1
        lastPage = 1
        BusinessArray.removeAll()
        getAdsData()
        
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        
        CurrentPage = 1
        lastPage = 1
        BusinessArray.removeAll()
        SearchTF.text = ""
        
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
    
    
}

//MARK:-Search Controller

extension BusinessAdvVC : refreshData {
    
    func refresh(state: Int, Order: String, sidee: String, regionn: String) {
        if state == 1 {
            self.order_by = Order
            self.side = sidee
            self.block = regionn
            self.CurrentPage = 1
            self.lastPage = 1
            self.BusinessArray.removeAll()
            self.getAdsData()
        }
    }
}



//MARK:CollectionView Controller

extension BusinessAdvVC : UITableViewDataSource ,UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let ContentHeight = scrollView.contentSize.height
        // print(position , tableView.contentSize.height)
        if isActive {
            if position > ContentHeight - scrollView.frame.height {
                
                isActive = false
                
                if CurrentPage < lastPage {
                    CurrentPage = CurrentPage + 1
                    
                    self.getAdsData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BusinessArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as BusinessSubAdsCell
        
        if AdsData {
            
            var Model = BusinessArray[indexPath.row]
            
            cell.ImagesUrl = Model.adv_media ?? []
            cell.pageControl.numberOfPages =  Model.adv_media?.count ?? 0
            cell.PagerView.reloadData()
            cell.CellTitle.text = Model.adv_title ?? ""
            cell.distance.text = Model.adv_distance ?? ""
            cell.ViewsNumber.text = Model.adv_views ?? ""
            cell.CellRate.text = Model.adv_total_rate ?? ""
            
            if Model.adv_price ?? "" == "0" {
                cell.Price.isHidden = true
                cell.SERlbl.isHidden = true
            }else{
                cell.Price.text = Model.adv_price ?? ""
            }
            
            if cell.ImagesUrl.count > 1 {
                cell.pageControl.isHidden = false
            } else {
                cell.pageControl.isHidden = true
            }
            
            if L102Language.currentAppleLanguage() == englishLang {
                
                cell.isAvailabelLabel.text = Model.adv_available_status
            }else {
                
                cell.isAvailabelLabel.text = Model.adv_available_custom_status
            }
            
            if Model.adv_available_status ==  "available" {
                cell.isAvailabelLabel.textColor = #colorLiteral(red: 0.2862745098, green: 0.8588235294, blue: 0.4980392157, alpha: 1)
            }else{
                cell.isAvailabelLabel.textColor = #colorLiteral(red: 1, green: 0.4784313725, blue: 0.5803921569, alpha: 1)
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
                
                let storyboard = UIStoryboard(name: Home, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC") as! BusinessAdsDetailsVC
                vc.AdId = "\(self.BusinessArray[indexPath.row].adv_id ?? 0)"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC") as! BusinessAdsDetailsVC
        vc.AdId = "\(BusinessArray[indexPath.row].adv_id ?? 0)"
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


//MARK:-API
extension BusinessAdvVC {
    
    func getAdsData() {
        
        
        self.view.lock()
        self.LoadingView.isHidden = false
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)sub-section-advertisements/\(Id)?order_by=\(order_by)&side=\(side)&block=\(block)&page=\(CurrentPage)&search=\(self.SearchTF.text ?? "")") { (data : BusinessModel?, String) in
            
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
                    self.BusinessArray.append(item)
                }
                
                self.AdvTableView.isHidden = true
                self.AdvTableView.isHidden = true
                self.MapBtn.isHidden = true
                if self.BusinessArray.count > 0 {
                    self.MapBtn.isHidden = false
                    self.AdvTableView.isHidden = false
                    self.MapBtn.isHidden = false
                }
                
                self.AdsData = true
                
                self.AdvTableView.reloadData()
                
                self.isActive = true
                
                print(data)
                
            }
        }
    }
    
    
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
    
}
