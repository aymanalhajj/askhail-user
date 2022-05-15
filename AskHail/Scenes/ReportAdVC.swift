//
//  ReportAdVC.swift
//  AskHail
//
//  Created by mohab mowafy on 13/05/2022.
//  Copyright © 2022 MOHAB. All rights reserved.
//

import UIKit



class ReportAdVC: BottomPopupViewController {
    
    @IBOutlet weak var TitleLAbel: UILabel!
    
    var title_page = ""
    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    
   
    @IBOutlet weak var ReportBtn: UIButton!
    var Reports_Array = [reportـreasonsـData]()
    
    var Checked_Array = Set<Int>()
    
    var Selecte_Report_array = [Int]()

    @IBOutlet weak var tableView: UITableView!
   
    var report_type :String?
    var report_type_id :String?
    
    
    var titleVariable = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleLAbel.text = title_page
        

        getReports()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.RegisterNib(cell: ReportCell.self)
    }
    

    @IBAction func ReportAction(_ sender: Any) {
        addReports()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func getPopupHeight() -> CGFloat {
        return 600
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return 20 
    }
    
    override func getPopupPresentDuration() -> Double {
        return 0.3
    }
    
    override func getPopupDismissDuration() -> Double {
        return 0.3
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return true
    }
    
    
}

extension ReportAdVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Reports_Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ReportCell
        
        cell.Press_check = {
            
            
            if self.Checked_Array.contains(indexPath.row) {
                self.Checked_Array.remove(indexPath.row)
            }else {
                self.Checked_Array.insert(indexPath.row)
            }
            
        
            
            self.tableView.reloadData()
        }
        
        if self.Checked_Array.contains(indexPath.row) {
            cell.CheckBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
        }else {
            cell.CheckBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        }
        cell.ConfigureCell(Model: Reports_Array[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.Checked_Array.contains(indexPath.row) {
            self.Checked_Array.remove(indexPath.row)
        }else {
            self.Checked_Array.insert(indexPath.row)
        }
        
        
        self.tableView.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
}

extension ReportAdVC {
    func getReports(){
        self.view.lock()
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)get-report-reasons") { (Model: reportـreasonsـModel? , err : String? )in
            self.view.unlock()
            
            
            if  err != nil {
              //  Completion(nil,"noNet")
                if err == "noNet" {
                   // self.show_NoDataView(View: self.view)
                    
                }else if err == "anError" {
                  //  self.show_AnErrorView(View: self.view)
                }else {
                    self.showAlertWithTitle(title: "Error".localized, message: err ?? "", type: .error)
                }
               
                
            }else {
//
//                self.hide_AnErrorView(View: self.view)
//                self.hide_NoConnectionView(View: self.view)
//
                self.Reports_Array = Model?.data ?? []
                self.tableView.reloadData()
                
            }
            
        }
        
    }
    
    func addReports(){
        
        for item in Checked_Array {
            self.Selecte_Report_array.append(self.Reports_Array[item].report_reason_id ?? 0)
        }
        
        let  param = [
            "type" : report_type ?? "" ,
            "type_id" : report_type_id ?? "" ,
            "report_reasons" : Selecte_Report_array
        ] as [String : Any]
        
        print(param)
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String:AnyObject] , url: "\(hostName)add-report") { (Model: Add_Report_Model? , err : String? )in
            self.view.unlock()
            
            
            if  err != nil {
              //  Completion(nil,"noNet")
                if err == "noNet" {
                   // self.show_NoDataView(View: self.view)
                    
                }else if err == "anError" {
                  //  self.show_AnErrorView(View: self.view)
                }else {
                    self.showAlertWithTitle(title: "Error".localized, message: err ?? "", type: .error)
                }
               
                
            }else {
                
//                self.hide_AnErrorView(View: self.view)
//                self.hide_NoConnectionView(View: self.view)
                
                
                self.showAlertWithTitle(title: "", message: Model?.data ?? "", type: .success)
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
    }
}
