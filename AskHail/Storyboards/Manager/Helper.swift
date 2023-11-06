//
//  Helper.swift
//  AskHail
//
//  Created by MOHAB on 2/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

import UIKit

class Helper: NSObject {
    
    
    
    
    
    // Save isFirst
  
    class func isFirst()->String {
        let api_token = "isFirst"
        return api_token
    }
    
    class func SaveisFirst(token : String?){
        let def = UserDefaults.standard
        def.setValue(token, forKey: isFirst())
        def.synchronize()
    }
    
    class func getisFirst()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: isFirst()) as? String
    }
    
   
    
    
    //User notification
    
    class func user_notification()->String {
        let user_notification = "user_notification"
        return user_notification
    }
    
    class func Saveuser_notification(notification : String?){
        let def = UserDefaults.standard
        def.setValue(notification, forKey: user_notification())
        def.synchronize()
    }
    
    class func getNotification()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: user_notification()) as? String
        
    }
    
    
    
    
    
    //save firebase token
    
    class func Fcm_toket()->String {
        let Fcm_token = "Fcmtoken"
        return Fcm_token
    }
    
    class func SaveFcmtoken(Fcmtoken : String?){
        let def = UserDefaults.standard
        def.setValue(Fcmtoken, forKey: Fcm_toket())
        def.synchronize()
    }
    
    class func getFcmtoken()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: Fcm_toket()) as? String
    }
    
    //MARK: Lat
        
        class func User_lat()->String {
            let User_lat = "User_lat"
            return User_lat
        }
        
        class func SaveUser_lat(phone : String?){
            let def = UserDefaults.standard
            def.setValue(phone, forKey: User_lat())
            def.synchronize()
        }
        
        class func getUser_lat()->String? {
            let def = UserDefaults.standard
            return def.object(forKey: User_lat()) as? String
        }
    
    
        //MARK: Lng
        
        class func User_Lng()->String {
            let User_lat = "User_Lng"
            return User_lat
        }
        
        class func SaveUser_Lng(phone : String?){
            let def = UserDefaults.standard
            def.setValue(phone, forKey: User_Lng())
            def.synchronize()
        }
        
        class func getUser_Lng()->String? {
            let def = UserDefaults.standard
            return def.object(forKey: User_Lng()) as? String
        }
    
    
    //MARK: Save Chat Type
    class func Chat_State()->String {
        let Package_Id = "ChatState"
        return Package_Id
    }
    
    class func SaveChatType(ChatState : String?){
        let pId = UserDefaults.standard
        pId.setValue(ChatState, forKey: Chat_State())
        pId.synchronize()
    }
    
    class func getChateType()->String? {
        let pId = UserDefaults.standard
        return pId.object(forKey: Chat_State()) as? String
    }
    
    
    class func restartApp(_ id : String){
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
    
}
