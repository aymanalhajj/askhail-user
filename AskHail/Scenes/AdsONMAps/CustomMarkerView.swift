//
//  CustomMarkerView.swift
//  AskHail
//
//  Created by bodaa on 31/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class CustomMarkerView: UIView {
    var img: UIImage!
    var borderColor_Map: UIColor!
    
    init(frame: CGRect, image: UIImage?, borderColor: UIColor, tag: Int) {
        super.init(frame: frame)
        self.img = image
        self.borderColor_Map=borderColor
        self.tag = tag
        setupViews()
    }
    
    func setupViews() {
        let imgView = UIImageView(image: img)
        imgView.frame=CGRect(x: 0, y: 0, width: 50, height: 50)
        imgView.layer.cornerRadius = 25
        imgView.layer.borderColor=borderColor?.cgColor
        imgView.layer.borderWidth=4
        imgView.clipsToBounds=true
        let lbl=UILabel(frame: CGRect(x: 0, y: 45, width: 50, height: 10))
        lbl.text = "▾"
        lbl.font=UIFont.systemFont(ofSize: 24)
        lbl.textColor = borderColor
        lbl.textAlignment = .center
        
        self.addSubview(imgView)
        self.addSubview(lbl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









import Foundation
import Foundation
import Foundation
import UIKit

class CustomMarkerView2: UIView {
    var img: UIImage!
    var borderColor_Map: UIColor!
    
    init(frame: CGRect, image: UIImage?, borderColor: UIColor, tag: Int) {
        super.init(frame: frame)
        self.img = #imageLiteral(resourceName: "neighbourhood")
     
        setupViews()
    }
    
    func setupViews() {
        let imgView = UIImageView(image: img)
        imgView.frame=CGRect(x: 0, y: 0, width: 36, height: 36)
       
        imgView.clipsToBounds=false
       
        
        
        
        self.addSubview(imgView)
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









