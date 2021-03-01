//
//  Extentions+OrderrVC-MyOrder.swift.swift
//  AskHail
//
//  Created by bodaa on 15/02/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
import UIKit

extension OrderVC {
    
    func CheckIfMyAds() {
        
        if Helper.getaUser_id() == "\(self.Order?.order_details?.order_advertiser_id ?? 0)" {
            self.buttomView.backgroundColor = UIColor(hexString: "ffffff")
            self.EditView.isHidden = false
            self.OwnerView.isHidden = true
            print("My Ads")

        }else{
            self.buttomView.backgroundColor = UIColor(hexString: "E5F2F7")
            self.EditView.isHidden = true
            self.OwnerView.isHidden = false
            print("normal Ads")

            
        }
        
    }
    
}
