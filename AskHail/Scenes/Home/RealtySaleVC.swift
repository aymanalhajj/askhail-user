//
//  RealtySaleVC.swift
//  AskHail
//
//  Created by Abdullah on 10/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class RealtySaleVC: UIViewController {
    
    @IBOutlet var BackGroundView: UIView!
    
    @IBOutlet weak var RealtyCollectionView: UICollectionView!
    
    @IBOutlet weak var TopBar: UIView!
    
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    
    
    var Title = ""
    
    var MainSectionArray : [MainSectionData] = []
    var mainSectiondata = false
    var id = ""
    var state = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TitleLabel.text = Title
         
        getSubSection()
        
        RealtyCollectionView.flipX()
        
        self.tabBarController?.tabBar.isHidden = true
       // RealtyCollectionView.RegisterNib(cell: RealtySaleCell.self)
        RealtyCollectionView.RegisterNib(cell: BusinessSectorCell.self)
        RealtyCollectionView.dataSource = self
        RealtyCollectionView.delegate = self
        
        BackGroundView.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
        
    }
    
}

extension RealtySaleVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return MainSectionArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessSectorCell", for: indexPath) as! BusinessSectorCell
        
        cell.flipX()
        
        if self.mainSectiondata {
            
            var Model = MainSectionArray[indexPath.row]
            
            cell.BackGroundImage.loadImage(URL(string: Model.section_image ?? ""))
            cell.title.text = Model.section_name
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if state == 1 {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "SubAdsVC") as! SubAdsVC
            vc.Id = "\(MainSectionArray[indexPath.row].section_id ?? 0)"
            vc.subSectionTitle = "\(MainSectionArray[indexPath.row].section_name ?? "")"
            navigationController?.pushViewController(vc, animated: true)
            
            return collectionView.deselectItem(at: indexPath, animated: true)
            state = 0
            
        }else if state == 2{
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdvVC") as! BusinessAdvVC
            vc.Id = "\(MainSectionArray[indexPath.row].section_id ?? 0)"
            vc.subSectionTitle = "\(MainSectionArray[indexPath.row].section_name ?? "")"
            navigationController?.pushViewController(vc, animated: true)
            
            return collectionView.deselectItem(at: indexPath, animated: true)
            
            state = 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = (collectionView.frame.width - 8)/2
        
        return CGSize.init(width: width , height:120)

    }
    
}

//extension RealtySaleVC : UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = (collectionView.frame.width - 16)/3
//        // let height = collectionView.frame.height
//
//        return CGSize.init(width: width , height: 156)
//
//    }
//}

extension RealtySaleVC {
    
    func getSubSection() {
        
        self.view.lock()
        
        DispatchQueue.main.async {
            
            self.RealtyCollectionView.layoutIfNeeded()
            self.RealtyCollectionView.showLoader()
 
        }
        
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)sub-sections/\(id)") { (data : MainSectionModel?, String) in
            
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.RealtyCollectionView.hideLoader()
                self.MainSectionArray = data.data ?? []
                self.mainSectiondata = true
                
                self.RealtyCollectionView.reloadData()
                
                print(data)
                
                
            }
        }
    }
    
}

