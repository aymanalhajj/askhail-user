//
//Extentions+AdsVC-MyAdv.swift
//  AskHail
//  Created by bodaa on 04/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import UIKit

extension AdsVC {
    
    func CheckIfMyAds() {
        
        if Helper.getaUser_id() == "\(self.AdData?.advertisement_details?.adv_advertiser_id ?? 0)" {
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
