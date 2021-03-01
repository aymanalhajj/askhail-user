//
//  Home2VC.swift
//  AskHail
//
//  Created by bodaa on 21/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class Home2VC: UIViewController {

    override func viewDidLoad() {
        
      
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        navigationController?.pushViewController(vc, animated: true)
        print("cxvsdaafav")
    }
    

}
