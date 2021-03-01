//
//  VisitorVC.swift
//  AskHail
//
//  Created by Mohab on 1/24/21.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class VisitorVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "PrayTimeVC") 
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
      
    }
    

  
    

}
