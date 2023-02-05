//
//  AppDelegate.swift
//  AskHail
//
//  Created by MOHAB on 2/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging
import UserNotifications
import GoogleMaps
import GooglePlaces
import FirebaseDynamicLinks
import Cosmos

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {
    
    var window: UIWindow?
    
    let gcmMessageIDKey = "gcm.message_id"
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        print(Helper.getFcmtoken())
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        UIApplication.shared.statusBarStyle = .lightContent
        
        GMSServices.provideAPIKey(GoogleKey)
        GMSPlacesClient.provideAPIKey(GoogleKey)
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerForNotifications()
        L102Localizer.DoTheMagic()
        L102Localizer.editLocalizationView()
        
        if #available(iOS 10.0, *) {
            
            
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
      
        
        if Helper.getisFirst() == nil {
            
            Helper.SaveisFirst(token: "true")
            
            L102Language.setAppleLAnguageTo(lang: arabicLang)
            L102Localizer.editLocalizationView()
            
            
            
        }
        
        
     
//
//        if Helper.getapitoken() != nil {
//
//
//
//            let sb = UIStoryboard(name: Home, bundle: nil)
//            var vc : UIViewController
//            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
//            window!.rootViewController = vc
//            UIView.transition(with: window!, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
//        }
        
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore{
            var subscribeTopic = "normal_advertisers_en"
            var unsubscribeTopic = "normal_advertisers_ar"
            let languageKey = L102Language.currentAppleLanguage()
            if languageKey == "ar"{
                subscribeTopic = "normal_advertisers_ar"
                unsubscribeTopic = "normal_advertisers_en"
            }
            Messaging.messaging().unsubscribe(fromTopic: unsubscribeTopic)
            Messaging.messaging().subscribe(toTopic: subscribeTopic)
            
            
            var allsubscribeTopic = "all_advertisers_en"
            var allunsubscribeTopic = "all_advertisers_ar"
            
            if languageKey == "ar"{
                subscribeTopic = "all_advertisers_ar"
                unsubscribeTopic = "all_advertisers_en"
            }
            
            Messaging.messaging().unsubscribe(fromTopic: allunsubscribeTopic)
            Messaging.messaging().subscribe(toTopic: allsubscribeTopic)
            
            
        }
        
        return true
    }
    
    
    
    
    
//MARK: - dynamicLinks
    
    //get dynamicLinks
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
         let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url)
         if dynamicLink != nil {
              print("Dynamic link : \(String(describing: dynamicLink?.url))")
            
              return true
         }
        
         return false
    }
    
    //Check on dynamicLinks
    func application(_ application: UIApplication, continue userActivity:
    NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
         guard let inCommingURL = userActivity.webpageURL else { return false }
         print("Incomming Web Page URL: \(inCommingURL)")
         shareLinkHandling(inCommingURL)
         return true
    }
    
    
    //Handel dynamicLinks
    fileprivate func shareLinkHandling(_ inCommingURL: URL) {
       
       _ = DynamicLinks.dynamicLinks().handleUniversalLink(inCommingURL) { (dynamiclink, error) in
           
          guard error == nil else {
          print("Found an error: \(error?.localizedDescription ?? "")")
            
          return
          }
        
          print("Dynamic link : \(String(describing: dynamiclink?.url))")
        
        
        self.handleDynamicLink(dynamiclink: dynamiclink)
        
        
       }
    }
    
    
    func handleDynamicLink(dynamiclink:DynamicLink?){
        
        if dynamiclink != nil{
            
            print(dynamiclink?.url)
             
        guard var dynamicUrl = dynamiclink?.url?.absoluteString else { return }
                  print("dynamicUrldynamicUrl",dynamicUrl)
            
            guard let index = dynamicUrl.lastIndex(of: "/")  else { return }
            let indexAfter = dynamicUrl.index(after: index)
            let ProductId = String((dynamicUrl.suffix(from: indexAfter)))
            
            if dynamicUrl.contains("advert")  {
                
                DynamicLinkModel.Product_id = ProductId
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "AdsV")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
                
            }else if dynamicUrl.contains("order") {
                
                dynamicUrl.removeFirst()
                DynamicLinkModel.Product_id = ProductId
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "OrderVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
                
            }else if dynamicUrl.contains("question"){
                
                dynamicUrl.removeFirst()
                DynamicLinkModel.Product_id = ProductId
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "AskHailDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }
        }
    }
    
    
    func registerForNotifications() {
        // Register for notification: This will prompt for the user's consent to receive notifications from this app.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
        }
    }
    
    func createBackgroundNotificationRequest() -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "askHail"
        content.subtitle = "Just so you are aware."
        content.body = "We'll be waiting for you back in askHail"
        
        let request = UNNotificationRequest(identifier: "BackgroundNotification", content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 200, repeats: false))
        
        return request
    }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            
            var subscribeTopic = "normal_advertisers_en"
            var unsubscribeTopic = "normal_advertisers_ar"
            let languageKey = L102Language.currentAppleLanguage()
            if languageKey == "ar"{
                subscribeTopic = "normal_advertisers_ar"
                unsubscribeTopic = "normal_advertisers_en"
            }
            Messaging.messaging().unsubscribe(fromTopic: unsubscribeTopic)
            Messaging.messaging().subscribe(toTopic: subscribeTopic)
            
            
            var allsubscribeTopic = "all_advertisers_en"
            var allunsubscribeTopic = "all_advertisers_ar"
            
            if languageKey == "ar"{
                subscribeTopic = "all_advertisers_ar"
                unsubscribeTopic = "all_advertisers_en"
            }
            
            Messaging.messaging().unsubscribe(fromTopic: allunsubscribeTopic)
            Messaging.messaging().subscribe(toTopic: allsubscribeTopic)
            
            print("Message ID2: \(messageID)")
        }
        
        
        
        // Print full message.
        print(userInfo)
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID3: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        
        ///You have a new trip request
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        let def = UserDefaults.standard
        def.setValue(token, forKey: "mobileToken")
        def.synchronize()
        Manager.DevicToken = token
        
        
        
       
   var subscribeTopic = "normal_advertisers_en"
          var unsubscribeTopic = "normal_advertisers_ar"
   let languageKey = L102Language.currentAppleLanguage()
                 if languageKey == "ar"{
              subscribeTopic = "normal_advertisers_ar"
              unsubscribeTopic = "normal_advertisers_en"
          }
    
    var allsubscribeTopic = "all_advertisers_en"
           var allunsubscribeTopic = "all_advertisers_ar"
   
                  if languageKey == "ar"{
               subscribeTopic = "all_advertisers_ar"
               unsubscribeTopic = "all_advertisers_en"
           }
    
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        print("When lock Screen")
        
        NotificationCenter.default.post(name: Notification.Name(Notification_lock_Screen), object: nil)
        
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("reloadPermission"), object: nil)
        NotificationCenter.default.removeObserver(self)

        NotificationCenter.default.post(name: Notification.Name("reloadPermission"), object: nil, userInfo: nil)
    }


    
    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name(Notification_Unlock_Screen), object: nil)
        print("First Launch")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        print("applicationWillTerminate")
        
    }
    
    // MARK: - Core Data stack
    
    
    
    
    
    
}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        guard Helper.getNotification() != "false" else {
            return
        }
        
        let userInfo = notification.request.content.userInfo
        
        print(userInfo)
        let dict = userInfo[AnyHashable("aps")] as! [String : Any]
        let al = dict["alert"] as? String
        
        print(al)
        
        let body = userInfo[AnyHashable("type")] as? String
        print(body)
        
        
       
        
        
        
        
        completionHandler([.sound , .alert])
    }
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        print("didReceiveRemoteNotification")
        
        
        
    }
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("didReceiveRemoteNotification")
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let application = UIApplication.shared
        
        let userInfo = response.notification.request.content.userInfo
        
        print(userInfo)
        let dict = userInfo[AnyHashable("aps")] as! [String : Any]
        let al = dict["alert"] as? String
        
        print(al)
        
        let body = userInfo[AnyHashable("type")] as? String
        
        let type_id = userInfo[AnyHashable("type_id")] as? String
        print(body , type_id)
        
    
        
        //
        
        
        if(application.applicationState == .active){
            print("user tapped the notification bar when the app is in foreground")
            
            if body == "public" {
                
                print(body)
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "HomeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "adv" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "AdsV")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "subscription" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: MyProfile, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "MyPackgeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "question" {
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "AskHailDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
                
            }else if body == "chat" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "chatVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }
            
        }
        
        if(application.applicationState == .inactive)
        {
            print("user tapped the notification bar when the app is in backround")
            
            if body == "public" {
                
                print(body)
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "HomeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "adv" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "AdsV")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "subscription" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: MyProfile, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "MyPackgeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "question" {
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "AskHailDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
                
            }else if body == "chat" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "chatVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }
            
            
        }
        
        
        
        
        completionHandler()
    }
    
    
}


extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken)")
        Helper.SaveFcmtoken(Fcmtoken: fcmToken)
        
    }
    
}
