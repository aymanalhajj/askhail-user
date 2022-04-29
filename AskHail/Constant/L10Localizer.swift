//
//  L10Localizer.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/6/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import Cosmos
import STTabbar

extension UIApplication {
    class func isRTL() -> Bool{
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}

class L102Localizer: NSObject {
    class func DoTheMagic() {
        
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
//        MethodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.layoutSubviews), overrideSelector: #selector(UITextField.cstmlayoutSubviews))
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
        
        
    }
    class func editLocalizationView(){
        if L102Language.currentAppleLanguage() == arabicLang {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UIStackView.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
            CosmosView.appearance().semanticContentAttribute = .forceLeftToRight
        }else {
            UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UIStackView.appearance().semanticContentAttribute = .forceRightToLeft
            UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
            CosmosView.appearance().semanticContentAttribute = .forceRightToLeft
           
            
        }
    }
}


extension UILabel {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            return // handle special case with uitextfields
        }
        if self.tag <= 0  {
            if UIApplication.isRTL()  {
                if self.textAlignment == .center { return }
                if self.textAlignment == .right {
                    return
                }
            } else {
                if self.textAlignment == .center { return }
                if self.textAlignment == .left {
                    return
                }
            }
        }
        if self.tag <= 0 {
            if UIApplication.isRTL()  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
}


extension UITextField {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.tag <= 0 {
            if UIApplication.isRTL()  {
                if self.textAlignment == .center { return }
                if self.textAlignment == .right { return }
                self.textAlignment = .right
            } else {
                if self.textAlignment == .center { return }
                if self.textAlignment == .left { return }
                self.textAlignment = .left
            }
        }
    }
}

var numberoftimes = 0
extension UIApplication {
    @objc var cstm_userInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if L102Language.currentAppleLanguage() == "ar" {
                direction = .rightToLeft
            }
            return direction
        }
    }
}
extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            let currentLanguage = L102Language.currentAppleLanguage()
            var bundle = Bundle();
            if let _path = Bundle.main.path(forResource: L102Language.currentAppleLanguageFull(), ofType: "lproj") {
                bundle = Bundle(path: _path)!
            }else
                if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                    bundle = Bundle(path: _path)!
                } else {
                    let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                    bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}


/// Exchange the implementation of two methods of the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}
