//
//  MyAccountVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/30/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class WorkWithUsVC: UIViewController {

    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BAckGround: UIView!
    @IBOutlet weak var JobTableView: UITableView!

    var JobsArray : [JubData] = []
    var JubsData = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJobs()
        
        
        BAckGround.backgroundColor = Colors.ViewBackGroundColoer
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        JobTableView.dataSource = self
        JobTableView.delegate = self
        JobTableView.RegisterNib(cell: JobCell.self)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        print(" Visitor ")
        
    }
    
}

extension WorkWithUsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as JobCell
        setShadow(view: cell, width: 0, height: 5, shadowRadius: 15, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8879565207, green: 0.9096216317, blue: 0.9441563005, alpha: 1))
        
        if JubsData{
            
            let Model = JobsArray[indexPath.row]
            
            cell.JobTitle.text = Model.job_title ?? ""
            cell.JobDescription.text = Model.job_description ?? ""
           
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: More , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "ApplyForJobVC") as! ApplyForJobVC
        vc.Job_id = "\(JobsArray[indexPath.row].job_id ?? 0)"
        vc.jobDesc = "\(JobsArray[indexPath.row].job_description ?? "")"
        vc.jobTitle = "\(JobsArray[indexPath.row].job_title ?? "")"
        
        navigationController?.pushViewController(vc, animated: true)
        
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


extension WorkWithUsVC {
    
    func getJobs() {
        self.view.lock()
        
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)jobs") { (data : JobsModel?, String) in
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.JobsArray = data.data?.data ?? []
                self.JubsData = true
                
                self.JobTableView.reloadData()
                
                
                print(data)
                
            }
        }
    }
    
}
