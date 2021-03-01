//
//  MyOrderVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/12/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import PMAlertController

class MyOrderVC: UIViewController {

    @IBOutlet var BackGround: UIView!
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backTitle: UILabel!
    
    var OrderArray : [OrderData] = []
    var OdderData = false
    var Order_id = ""
    
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
        
        MyOrder()
        
        backTitle.text = "There are no new requests at the moment. Click the + icon to add a new order".localized
        
        let date = Date()
        print(date)
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        tableView.backgroundColor = Colors.ViewBackGroundColoer
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.RegisterNib(cell: OrderCell.self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAvtion(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func AddNewOrder(_ sender: Any) {
        
        CkeckIfHaveOldOrder()
        
    }
    
}

//MARK:-TableView Controller

extension MyOrderVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return OrderArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as OrderCell
        
        setShadow(view: cell, width: 3, height: 3, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7984270179, green: 0.8598688598, blue: 0.9253893956, alpha: 1))
        
        if OdderData {
            
            let Model = OrderArray[indexPath.row]
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "OrderVC") as! OrderVC
        vc.Order_id = "\(OrderArray[indexPath.row].order_id ?? 0)"
        vc.myOrderCount = "\(OrderArray.count)"
        navigationController?.pushViewController(vc, animated: true)
        
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
        
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
                    
                    self.MyOrder()
                    
                }
            }
            
        }
        
    }
    
}

extension MyOrderVC {
    
    func MyOrder() {
        
        DispatchQueue.main.async {
            
            self.tableView.layoutIfNeeded()
            self.tableView.showLoader()
            
        }
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)user/my-orders?page=\(self.CurrentPage)") { (data : MyOrderModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                for item in data.data?.data ?? [] {
                    self.OrderArray.append(item)
                }
                
                self.tableView.isHidden = true
                
                self.tableView.hideLoader()

                self.tableView.reloadData()
                
                if self.OrderArray.count > 0 {
                    self.tableView.isHidden = false
                    self.OdderData = true
                }
                  
                self.isActive = true
                
                print(data.data?.data)
                
            }
        }
    }
    
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
