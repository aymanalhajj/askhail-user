//
//  Extentions+EditOrder.swift
//  AskHail
//
//  Created by bodaa on 15/02/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
import UIKit

extension OrderVC : selectEditOrderSection {
    func SelectEdit(select: Int) {
        
        if select == 0 {
            
            let storyboard = UIStoryboard(name: EditOrder_srory , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditOrderCategoryVC") as! EditOrderCategoryVC
            vc.Order_id = self.Order_id
            navigationController?.pushViewController(vc, animated: true)
            
        }else if select == 1 {
            
            let storyboard = UIStoryboard(name: EditOrder_srory , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditOrderDetailsVD") as! EditOrderDetailsVD
            vc.Order_id = self.Order_id
            vc.CurrentFeatureArray = Order?.order_details?.order_specifications ?? []
            navigationController?.pushViewController(vc, animated: true)
            
        }
        else if select == 2 {
            
            let storyboard = UIStoryboard(name: EditOrder_srory , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditOrderContactWayVC") as! EditOrderContactWayVC
            vc.Order_id = self.Order_id
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
