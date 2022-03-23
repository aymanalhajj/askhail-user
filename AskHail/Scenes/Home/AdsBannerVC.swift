//
//  AdsVC.swift
//  AskHail
//
//  Created by mohab mowafy on 22/03/2022.
//  Copyright © 2022 MOHAB. All rights reserved.
//

import UIKit

class AdsBannerVC: UIViewController {
    
    @IBOutlet weak var adsImage: UIImageView!
    var imageUrl = ""
    @IBOutlet weak var closeBn: UIButton!
    
    @IBOutlet weak var GradientView: UIView!
    
    var Banner_url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
      //  GradientView.applyGradient(withColours: [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1) , #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)], gradientOrientation: .vertical)
        
      //  closeBn.setImage(#imageLiteral(resourceName: "WhiteClose").withRenderingMode(.alwaysOriginal).withTintColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), for: .normal)
        
        
        showAnimate()
     adsImage.loadImage(URL(string: imageUrl))
        
   //  adsImage.image = #imageLiteral(resourceName: "how to use")
    }
    
    @IBAction func CancelAction(_ sender: Any) {
      
        removeAnimate()
    }
    
    @IBAction func OpenURL(_ sender: Any) {
        OpenUrl(url: Banner_url)
    }
    
    
}
