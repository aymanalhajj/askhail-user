//
//  EditOrderPopUpVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/16/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

protocol selectEditOrderSection {
    
    func SelectEdit(select : Int)
    
}

class EditOrderPopUpVC: UIViewController {

    var deleget : selectEditOrderSection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        
    }
    
    @IBAction func CategoryAction(_ sender: Any) {
        
        deleget?.SelectEdit(select: 0)
        removeAnimate()
    }
    
    
    @IBAction func DetailsAction(_ sender: Any) {
        
        deleget?.SelectEdit(select:1)
        removeAnimate()
    }
    
    @IBAction func ContactWayAction(_ sender: Any) {
        
        deleget?.SelectEdit(select: 2)
        removeAnimate()
    }
    
    @IBAction func Cancel(_ sender: Any) {
        
        removeAnimate()
        
    }
    
    
}

