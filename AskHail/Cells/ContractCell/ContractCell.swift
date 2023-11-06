//
//  ContractCell.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/2/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ContractCell: UITableViewCell {
    
    @IBOutlet weak var contreactTitle: UILabel!
    @IBOutlet weak var Datelbl: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var LineView: UIView!
    
    @IBOutlet weak var DatetitleLabel: UILabel!
    
    
    var DownloadFile : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if L102Language.currentAppleLanguage() == englishLang {
            DatetitleLabel.text = "add date : "
        }else {
            DatetitleLabel.text = "تاريخ الإضافة : "
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func DownloadAction(_ sender: Any) {
        
        DownloadFile?()
        
    }
}
