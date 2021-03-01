//
//  RestaurantPreviewView.swift
//  AskHail
//
//  Created by bodaa on 31/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class RestaurantPreviewView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.clipsToBounds=true
        self.layer.masksToBounds=true
        setupViews()
    }
    
    func setData(title: String, img: UIImage?, price: Int) {
        lblTitle.text = title
        imgView.image = img
        imgView.contentMode = .scaleAspectFill
        lblTitle.textColor = Colors.DarkBlue
        lblTitle.backgroundColor = .white
     
      //  lblPrice.text = "$\(price)"
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
     
        
        addSubview(imgView)
        imgView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        imgView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
        imgView.addSubview(overLayView)
        overLayView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive=true
        overLayView.bottomAnchor.constraint(equalTo:bottomAnchor, constant: 0).isActive=true
        overLayView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive=true
        overLayView.heightAnchor.constraint(equalToConstant: 35).isActive=true
    
        overLayView.addSubview(lblTitle)
        
        lblTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive=true
        lblTitle.bottomAnchor.constraint(equalTo:bottomAnchor, constant: 0).isActive=true
        lblTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 35).isActive=true
        
     
    }
    
    let containerView: UIView = {
        let v=UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.image=#imageLiteral(resourceName: "banner")
        v.contentMode = .scaleAspectFill
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "oihiugiugiugiougiugiougiougiougiugiougiugiu"
        lbl.font=UIFont(name: "Tajawal-Medium", size: 16)
        lbl.backgroundColor = .clear
        lbl.textColor = UIColor.black
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let overLayView: UIView = {
        let Vw=UIView()
        Vw.backgroundColor = .black
       
        Vw.translatesAutoresizingMaskIntoConstraints=false
        return Vw
    }()
    
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
