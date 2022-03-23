//
//  Extentions+AskVC-MyAsk.swift
//  AskHail
//
//  Created by bodaa on 17/02/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
import UIKit

extension AskHailDetailsVC {
    
    func CheckIfMyAsk() {
        
        if "\(AuthService.userData?.advertiser_id ?? 0)" == "\(self.AskData?.question_advertiser_id ?? 0)" {
            self.buttomView.backgroundColor = UIColor(hexString: "ffffff")
            self.EditView.backgroundColor = UIColor(hexString: "ffffff")
            self.EditView.isHidden = false
            print("My ask")

        }else{
            self.buttomView.backgroundColor = UIColor(hexString: "E5F2F7")
            self.EditView.backgroundColor = UIColor(hexString: "E5F2F7")
            self.EditView.isHidden = true
            print("normal ask")

            
        }
        
    }
    
}
