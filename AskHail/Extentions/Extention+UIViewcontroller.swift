
//  Extention+UIViewcontroller.swift
//  AskHail
//
//  Created by Abdullah Tarek on 1/11/20.
//  Copyright © 2020 MOHAB. All rights reserved.

import Foundation
import UIKit


extension UIViewController {
    
    
    func LogOut() {
        
        Helper.Saveuser_id(user_id: nil)
        Helper.Saveuser_namen(name: nil)
        Helper.Saveuser_Email(email: nil)
        Helper.Saveuser_phone(phone: nil)
        Helper.SaveApitoken(token: nil)
        Helper.SavePackage_Id(PackageId: nil)
        Helper.SaveChatType(ChatState: "")
        
        guard let window = UIApplication.shared.keyWindow else{return}
        
        let sb = UIStoryboard(name: Authontication, bundle: nil)
        var vc : UIViewController
        
        
        vc = sb.instantiateViewController(withIdentifier: "WelcomeVC")
        
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
    func EnableLineAnimite(text : UITextField , ImageView : UIImageView , imageEnable : UIImage  , lineView : UIView , ishidden : Bool )  {
        
        guard text.text?.isEmpty == true else {
            return
        }
        
        UIView.animate(withDuration: 0.06, animations: {
            
            lineView.backgroundColor = Colors.lineView
            lineView.isHidden = ishidden
            ImageView.image = imageEnable
            lineView.center.x = 100
            lineView.frame.size.width = +200
            
        }) { (_) in
            
        }
        
    }
    
    func ErrorLineAnimite(text : UITextField , ImageView : UIImageView , imageEnable : UIImage  , lineView : UIView , ishidden : Bool )  {
        
        UIView.animate(withDuration: 0.06, animations: {
            
            lineView.backgroundColor = Colors.errorLineView
            lineView.isHidden = ishidden
            ImageView.image = ImageView.image?.withTintColor(Colors.errorLineView)
            lineView.center.x = 100
            lineView.frame.size.width = +200
            
        }) { (_) in
            
        }
    }
    
    func EnableLineAnimiteNoimage(text : UITextField , lineView : UIView , ishidden : Bool )  {
        
        guard text.text?.isEmpty == true else {
            return
        }
        UIView.animate(withDuration: 0.06, animations: {
            
            lineView.backgroundColor = Colors.lineView
            lineView.isHidden = ishidden
            lineView.center.x = 100
            lineView.frame.size.width = +200
            
        }) { (_) in
            
        }
    }
    
    func ErrorLineAnimiteNoimage(text : UITextField , lineView : UIView , ishidden : Bool )  {
        
        UIView.animate(withDuration: 0.06, animations: {
            
            lineView.backgroundColor = Colors.errorLineView
            lineView.isHidden = ishidden
            lineView.center.x = 100
            lineView.frame.size.width = +200
            
        }) { (_) in
            
        }
    }
    
    
    func EnableLineAnimiteTextView(text : UITextView , lineView : UIView , ishidden : Bool )  {
        
        guard text.text?.isEmpty == true else {
            return
        }
        
        UIView.animate(withDuration: 0.06, animations: {
            
            lineView.backgroundColor = Colors.lineView
            lineView.isHidden = ishidden
            lineView.center.x = 100
            lineView.frame.size.width = +200
            
        }) { (_) in
            
        }
    }
    
    func ErrorLineAnimiteTextView(text : UITextView , lineView : UIView , ishidden : Bool )  {
        
        UIView.animate(withDuration: 0.06, animations: {
            
            lineView.backgroundColor = Colors.errorLineView
            lineView.isHidden = ishidden
            lineView.center.x = 100
            lineView.frame.size.width = +200
            
        }) { (_) in
            
        }
    }
    
    func changeLanguage(storyBoard: String = "Provider", vcId: storyBoardVCIDs) {
        let transition: UIView.AnimationOptions = .transitionCrossDissolve
        
        if L102Language.currentAppleLanguage() == englishLang {
            L102Language.setAppleLAnguageTo(lang: arabicLang)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
        } else {
            L102Language.setAppleLAnguageTo(lang: englishLang)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            
        }
        
        let mainStry = UIStoryboard(name: Home, bundle: nil)
        let HomeVc =  mainStry.instantiateViewController(identifier: "HomeVC")
        
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        window.rootViewController = HomeVc
        window.makeKeyAndVisible()
        
        let MainWindow = (UIApplication.shared.delegate?.window!)!
        
        MainWindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.60077, alpha: 0.8)
        UIView.transition(with: MainWindow, duration: 0.55001, options: transition, animations: { () -> Void in
              }) { (finished) -> Void in
        
              }
        
    }
    
    // Download file from Api
    func downloadFileFromURL(url:NSURL){
        
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with:url as URL, completionHandler: { [weak self](URL, response, error) -> Void in
            
            
        })
        
        self.alert(msg: "تم تحميل الملف بنجاح".localized)
        downloadTask.resume()
    }
        
}
