//
//  WelcomeVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class WelcomeVC: UIViewController , GMSMapViewDelegate {
    
    
    @IBOutlet weak var lines: UIImageView!
    @IBOutlet weak var loginImageBg: UIImageView!
    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var RegisterView: UIView!
    @IBOutlet weak var VisitoView: UIView!
    @IBOutlet weak var LogInBtn: UIButton!
    @IBOutlet weak var CreateAccountBtn: UIButton!
    @IBOutlet weak var VisitorVC: UIButton!
    
    @IBOutlet weak var loginLogo: UIImageView!
    @IBOutlet weak var registerLogo: UIImageView!
    @IBOutlet weak var visitorLogo: UIImageView!
    @IBOutlet weak var WelcomeText: UILabel!
    
    var lat : Double?
    var lon : Double?
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var alertController = UIAlertController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WelcomeText.font = UIFont(name: "Tajawal-Regular", size: 16)
        if L102Language.currentAppleLanguage() == englishLang{
            WelcomeText.text = "God bless you in the Ask Hail application, everything you need to know about Hail (real estate, tourist attractions, events, places of entertainment)"
            lines.image = #imageLiteral(resourceName: "lines-eng")
            loginImageBg.image = #imageLiteral(resourceName: "curves-eng")
            loginLogo.image = #imageLiteral(resourceName: "auth_login_eng")
            registerLogo.image = #imageLiteral(resourceName: "auth_new_user")
            visitorLogo.image = #imageLiteral(resourceName: "auth_skip_eng")
        }
        
        setShadow(view: LoginView, width: 0, height: 2, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        setShadow(view: RegisterView, width: 0, height: 2, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        setShadow(view: VisitoView, width: 0, height: 2, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        
        if let coor = locationManager.location?.coordinate {
            
            
            let camera = GMSCameraPosition.camera(withLatitude: coor.latitude,
                                                  longitude: coor.longitude,
                                                  zoom: zoomLevel)
            
            Helper.SaveUser_lat(phone: "\(self.lat ?? 0)")
            Helper.SaveUser_Lng(phone: "\(self.lon ?? 0)")
            
        }
    }
    
    func mustEnableLocation() {
        alertController = UIAlertController(title: "Access location required".localized, message: "Kindly activate location access in settings".localized, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Settings".localized, style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
                break
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
                break
            default:
                break
            }
        } else {
            hasPermission = false
        }
        return hasPermission
    }
    
    
    @IBAction func LoginAction(_ sender: Any) {
        
        if !self.hasLocationPermission() {
            self.mustEnableLocation()
            return
        }
        
        let storyboard = UIStoryboard(name: Authontication, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func CreateAccountAction(_ sender: Any) {
        
        if !self.hasLocationPermission() {
            self.mustEnableLocation()
            return
        }
        
        let storyboard = UIStoryboard(name: Authontication, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "CreateAccount_1") as! CreateAccount_1
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func VisitorAction(_ sender: Any) {
        
        if !self.hasLocationPermission() {
            self.mustEnableLocation()
            return
        }
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
        
        
        print(" Visitor ")
        
    }
    
}
extension WelcomeVC : CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        Helper.SaveUser_lat(phone: "\(location.coordinate.latitude)")
        Helper.SaveUser_Lng(phone: "\(location.coordinate.longitude)")
        
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
    
    
}


