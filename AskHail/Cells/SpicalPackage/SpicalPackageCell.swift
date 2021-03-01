//
//  SpicalPackageCell.swift
//  AskHail
//
//  Created by bodaa on 12/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class SpicalPackageCell: UITableViewCell {
    
    @IBOutlet weak var packageName: UILabel!
    @IBOutlet weak var Rimage: UIImageView!
    @IBOutlet weak var LImage: UIImageView!
    @IBOutlet weak var PackagePrice: UILabel!
    @IBOutlet weak var PackageTime: UILabel!
    @IBOutlet weak var packageDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24))
    }
    
}
