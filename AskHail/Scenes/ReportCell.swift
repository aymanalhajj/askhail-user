//
//  ReportCell.swift
//  AskHail
//
//  Created by mohab mowafy on 13/05/2022.
//  Copyright © 2022 MOHAB. All rights reserved.
//

import UIKit

class ReportCell: UITableViewCell {

    @IBOutlet weak var CheckBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var Press_check : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func CheckAction(_ sender: Any) {
        Press_check?()
    }
    
    func ConfigureCell(Model : reportـreasonsـData){
        
        nameLabel.text = Model.report_reason_title
        
    }
    
}
