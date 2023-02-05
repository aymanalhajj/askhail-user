//
//  SplashVC.swift
//  AskHailBusiness
//
//  Created by Mohab on 1/20/21.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit
import Lottie
import CoreLocation
import GoogleMaps
import GooglePlaces

class SplashVC: UIViewController {
    let animationView = AnimationView()
    let animationView1 = AnimationView()
    var alertController = UIAlertController()

    @IBOutlet weak var imageView: UIView!
    
    @IBOutlet weak var imageview1: UIView!
    
    @IBOutlet var BAckGround: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        BAckGround.backgroundColor = Colors.ViewBackGroundColoer
        super.viewDidAppear(animated)
        
        
        animationView.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.playOnce,
                           completion: { (finished) in
                            if finished {
                                
                                if !self.hasLocationPermission() {
                                    self.mustEnableLocation()
                                    self.requestLocation = true
                                    return
                                }
                                
                                self.startNavigate()
                            } else {
                                print("Animation cancelled")
                            }
                           })
        
    }
    
    var lat : Double?
    var lon : Double?
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var requestLocation = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animation = Animation.named("splacsh2", subdirectory: "TestAnimations")
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
        imageView.addSubview(animationView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: imageView.layoutMarginsGuide.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        
        animationView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        animationView.trailingAnchor.constraint(equalTo: imageView .trailingAnchor).isActive = true
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        
        if let coor = locationManager.location?.coordinate{
            
            
            let camera = GMSCameraPosition.camera(withLatitude: coor.latitude,
                                                  longitude: coor.longitude,
                                                  zoom: zoomLevel)
            
            self.lat = coor.latitude
            self.lon = coor.longitude
            
            Helper.SaveUser_lat(phone: "\(self.lat ?? 0)")
            
            Helper.SaveUser_Lng(phone: "\(self.lon ?? 0)")
            
            
        }
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        NotificationCenter.default.removeObserver(self, name: Notification.Name("reloadPermission"), object: nil)
        NotificationCenter.default.removeObserver(self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("reloadPermission"), object: nil)

    }
    
    func startNavigate() {
        guard let window = UIApplication.shared.keyWindow else { return }
        if AuthService.userData?.advertiser_api_token != nil {
            
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        }else {
            let sb = UIStoryboard(name: Authontication, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "WelcomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        }
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        if self.requestLocation == true {
            if self.hasLocationPermission() {
                startNavigate()
            }else {
                self.mustEnableLocation()
                self.requestLocation = true
            }
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
    
}
extension SplashVC : CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        self.lat = location.coordinate.latitude
        self.lon = location.coordinate.longitude
        
        Helper.SaveUser_lat(phone: "\(self.lat ?? 0)")
        Helper.SaveUser_Lng(phone: "\(self.lon ?? 0)")
        
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
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location status is OK.")
            alertController.dismiss(animated: false, completion: nil)
            if self.requestLocation == true {
                self.startNavigate()
            }
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
    
    
}


