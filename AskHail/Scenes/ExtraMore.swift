//
//  ExtraMore.swift
//  AskHail
//
//  Created by bodaa on 08/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ExtraMore: UIViewController {
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Tajawal-Regular", size: 12)!], for: .normal)
        
        tabBarController?.tabBar.items?[0].title = "Home".localized
        tabBarController?.tabBar.items?[1].title = "Chat".localized
        tabBarController?.tabBar.items?[4].title = "More".localized
        tabBarController?.tabBar.items?[3].title = "Ask Hail".localized
      
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
       
    }
   
    
    @objc func fireTimer() {
        tabBarController?.selectedIndex = 0
        timer.invalidate()
    }
    

}
