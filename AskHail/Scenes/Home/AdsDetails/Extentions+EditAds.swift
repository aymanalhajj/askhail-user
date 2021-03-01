//
//  Extentions+EditAds.swift
//  AskHail
//
//  Created by bodaa on 15/02/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
import UIKit

extension AdsVC : selectEditSection {
    func SelectEdit(select: Int) {
        
        if select == 0 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditCategoryVC") as! EditCategoryVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
        }else if select == 1 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditImageVC") as! EditImageVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
        else if select == 2 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditDetailsVD") as! EditDetailsVD
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            vc.CurrentFeatureArray = AdData?.advertisement_details?.adv_specifications ?? []
            navigationController?.pushViewController(vc, animated: true)
            
        }else if select == 3 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditContactWayVC") as! EditContactWayVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
    }
}
