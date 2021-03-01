//
//  viewController+Extention.swift
//  AskHail
//
//  Created by Mohab on 3/15/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit



extension UIViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func showAllImageToChose(){
          let picker = UIImagePickerController()
          picker.sourceType = .photoLibrary
          picker.delegate = self
          picker.allowsEditing = true
          present(picker, animated: true, completion: nil)
          
          
      }
    
    func validateEmail(_ email:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    func isValidPhone(phone:String) -> Bool {
           let phoneRegEx = "[01]{2}+[0-9]{9}"
           let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
           return phoneTest.evaluate(with: phone)
       }
    

    
    

    
}
