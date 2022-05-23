//
//  ShowDetailsCell.swift
//  AskHail
//
//  Created by bodaa on 17/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class ShowDetailsCell: UICollectionViewCell {

    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellAnswer: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
extension UILabel {
    
 
    // MARK: - spacingValue is spacing that you need
    func addInterlineSpacing(isCentered:Bool = true) {

        // MARK: - Check if there's any text
        guard let textString = text else { return }

        // MARK: - Create "NSMutableAttributedString" with your text
        let attributedString = NSMutableAttributedString(string: textString)

        // MARK: - Create instance of "NSMutableParagraphStyle"
        let paragraphStyle = NSMutableParagraphStyle()
     
        if isCentered == true {
            paragraphStyle.alignment = .center
        }
           
      
        // MARK: - Actually adding spacing we need to ParagraphStyle
        paragraphStyle.lineSpacing = 5

        
        // MARK: - Adding ParagraphStyle to your attributed String
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))

        // MARK: - Assign string that you've modified to current attributed Text
        attributedText = attributedString
        
    }

}
