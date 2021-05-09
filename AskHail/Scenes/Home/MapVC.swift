//
//  MapVC.swift
//  AskHail
//
//  Created by Mohab on 10/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import Alamofire

extension MapVC: CLLocationManagerDelegate {
    
  
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
            if isUpadte {
               
                getLocation(location.coordinate.latitude, location.coordinate.longitude)
                getAllAdvOnmao()
                isUpadte = false
            }
            
        }
        
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            
            let alertController = UIAlertController(title: "Ask Hail", message: "Ask Hail would like to access your Location to get Listings and search properties Near your Location", preferredStyle: .alert)

                let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                     }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (_) -> Void in
                    self.navigationController?.popViewController(animated: true)
                }

                alertController.addAction(cancelAction)
                alertController.addAction(settingsAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways:
            
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
                print("locations = \(locValue.latitude) \(locValue.longitude)")
            let camera = GMSCameraPosition.camera(withLatitude: Double(locValue.latitude),longitude: Double(locValue.longitude),zoom: self.zoomLevel)
            
            mapView.animate(to: camera)
            print("here")
            
        case .authorizedWhenInUse:
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
                print("locations = \(locValue.latitude) \(locValue.longitude)")
            let camera = GMSCameraPosition.camera(withLatitude: Double(locValue.latitude),longitude: Double(locValue.longitude),zoom: self.zoomLevel)
            mapView.animate(to: camera)
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        lat = mapView.camera.target.latitude
        print(lat)
        
        lon = mapView.camera.target.longitude
        print(lon)
        
        
        // CreateMarker(lat ?? 0.0, lon ?? 0.0)
       // getLocation(lat ?? 0.0, lon ?? 0.0)
        
        
    }
    
    func CreateMarker(Lat : Double , lng : Double){
        let marker = GMSMarker()
        mapView.clear()
        marker.iconView = CustomMarkerView2(frame: CGRect(x: 0, y: 0, width: 36, height: 48), image: #imageLiteral(resourceName: "locationInAds"), borderColor: UIColor.darkGray, tag: 0)
        marker.position = CLLocationCoordinate2D(latitude: Lat, longitude: lng)
        let cameraPosition = GMSCameraPosition.camera(withLatitude: Lat, longitude: lng, zoom: 15.0)
        marker.map = mapView
        mapView.animate(to: cameraPosition)
        
        
    }
    
}

extension MapVC  {
    
    func getLocation(_ latitude: Double,_ longitude : Double) {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(GoogleKey)&language=\(lang)"
        
        print(url)
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                let responseJson = response.result.value! as! NSDictionary
                
                if let results = responseJson.object(forKey: "results")! as? [NSDictionary] {
                    print(results.count)
                    if results.count > 0 {
                        
                        self.addreesLabel.text = results[0]["formatted_address"] as? String
                        self.Address = results[0]["formatted_address"] as? String ?? ""
                        
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


class MapVC: UIViewController, GMSMapViewDelegate {
    
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
  //  let previewDemoData = [(title: "The Polar Junction", img: #imageLiteral(resourceName: "starAdsImage"), price: 10), (title: "The Nifty Lounge", img: #imageLiteral(resourceName: "‏‏NoPath - نسخة (8)"), price: 8), (title: "The Lunar Petal", img: #imageLiteral(resourceName: "ads-image"), price: 12)]
    
    var lat : Double?
    var lon : Double?
    var Category_ids = ""
    var Address = ""
    
    var isAtive = true
    
    var isUpadte = true
    
    @IBOutlet weak var addreesLabel: UILabel!
    
    @IBOutlet weak var addressView: UIView!
    
    
    
    //  @IBOutlet weak var IMGView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    var markers = [GMSMarker]()
    var london: GMSMarker?
    
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 12
    
    var WorkersArray = [OneAdvOnMap]()
    
    var Section_id = ""
    var lang = ""
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    override func viewWillAppear(_ animated: Bool) {
        if L102Language.currentAppleLanguage() == englishLang{
            lang = "en"
        }else{
            lang = "ar"
        }
    }
    
    private func styleGoogleMaps(){
            
            do {
             
                if let StyleUrl = Bundle.main.url(forResource: "style", withExtension: "json")
                {
                    mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: StyleUrl)
                    
                }else {
                    
                    print("(unable to find sryle file")
                    
                }
                
            }catch {
                
                
                print("failed to load json")
            }
            
            
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleGoogleMaps()
        
        restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 20, y: 20, width: self.view.frame.width - 40, height: 190))
        
        self.mapView.addSubview(addressView)
        
        
        //   mapView.addSubview(IMGView)
        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        placesClient = GMSPlacesClient.shared()
                
        self.getAllAdvOnmao()
        
        
    }
    
    func showPartyMarkers() {
        mapView.clear()
        var x = 0
        for item in WorkersArray {
            let randNum=Double(arc4random_uniform(30))/10000
            let marker=GMSMarker()
            
            var adv_image = UIImageView()
            adv_image.loadImage(URL(string: item.adv_promotional_image ?? ""))
            
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: adv_image.image, borderColor: UIColor.darkGray, tag: x)
            marker.iconView=customMarker
            let randInt = arc4random_uniform(4)
            if randInt == 0 {
                marker.position = CLLocationCoordinate2D(latitude: (Double(item.adv_lat ?? "") ?? 0.0) + randNum, longitude: (Double(item.adv_lng ?? "") ?? 0.0) - randNum)
            } else if randInt == 1 {
                marker.position = CLLocationCoordinate2D(latitude: (Double(item.adv_lat ?? "") ?? 0.0) - randNum, longitude: (Double(item.adv_lng ?? "") ?? 0.0) + randNum)
            } else if randInt == 2 {
                marker.position = CLLocationCoordinate2D(latitude: (Double(item.adv_lat ?? "") ?? 0.0) - randNum, longitude: (Double(item.adv_lng ?? "") ?? 0.0) - randNum)
            } else {
                marker.position = CLLocationCoordinate2D(latitude: (Double(item.adv_lat ?? "") ?? 0.0) + randNum, longitude: (Double(item.adv_lng ?? "") ?? 0.0) + randNum)
            }
            marker.map = self.mapView
            x = x + 1
        }
    }
    
    
    
    @IBAction func backAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
 
    
  
    // MARK: GOOGLE MAP DELEGATE
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
        print(WorkersArray[customMarkerView.tag].adv_promotional_image ?? "")
        let img = customMarkerView.img!
        
        var adv_image = UIImageView()
        adv_image.loadImage(URL(string: WorkersArray[customMarkerView.tag].adv_promotional_image ?? ""))
        
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: adv_image.image, borderColor: UIColor.white, tag: customMarkerView.tag)
        
        marker.iconView = customMarker
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
       let data = WorkersArray[customMarkerView.tag]
        var img_ads = UIImageView()
        img_ads.loadImage(URL(string: data.adv_promotional_image ?? ""))
        
        
        restaurantPreviewView.setData(title: data.adv_title ?? "", img: img_ads.image, price: 0)
        return restaurantPreviewView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let tag = customMarkerView.tag
        restaurantTapped(tag: tag)
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let img = customMarkerView.img!
        
        var adv_image = UIImageView()
        adv_image.loadImage(URL(string: WorkersArray[customMarkerView.tag].adv_promotional_image ?? ""))
        
        
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image:adv_image.image , borderColor: UIColor.darkGray, tag: customMarkerView.tag)
        marker.iconView = customMarker
    }
    @objc func btnMyLocationAction() {
        let location: CLLocation? = myMapView.myLocation
        if location != nil {
            myMapView.animate(toLocation: (location?.coordinate)!)
        }
    }
    
    @objc func restaurantTapped(tag: Int) {
        
        print(tag)
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
        vc.AdId = "\(WorkersArray[tag].adv_id ?? 0)"
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
//        let v=DetailsVC()
//        v.passedData = previewDemoData[tag]
//        self.navigationController?.pushViewController(v, animated: true)
    }
    
    
  
    
    
   
    
    
    func setupViews() {
        view.addSubview(myMapView)
        myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60).isActive=true
        
        self.view.addSubview(txtFieldSearch)
        txtFieldSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive=true
        txtFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive=true
        txtFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive=true
        txtFieldSearch.heightAnchor.constraint(equalToConstant: 35).isActive=true
      //  setupTextField(textField: txtFieldSearch, img: #imageLiteral(resourceName: "map_Pin"))
        
        restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190))
        
        self.view.addSubview(btnMyLocation)
        btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive=true
        btnMyLocation.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive=true
        btnMyLocation.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
    }
    
    let myMapView: GMSMapView = {
        let v=GMSMapView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let txtFieldSearch: UITextField = {
        let tf=UITextField()
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.placeholder="Search for a location"
        tf.translatesAutoresizingMaskIntoConstraints=false
        return tf
    }()
    
    let btnMyLocation: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.white
        btn.setImage(#imageLiteral(resourceName: "distance-1"), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.gray
        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    var restaurantPreviewView: RestaurantPreviewView = {
        let v=RestaurantPreviewView()
        return v
    }()
}



extension MapVC {
    
    func focusMapToShowAllMarkers() {
        
        var bounds = GMSCoordinateBounds()
        for location in WorkersArray
        {
            let latitude = Double(location.adv_lat ?? "0.0") ?? 0.0
            let longitude = Double(location.adv_lng ?? "0.0") ?? 0.0
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude:latitude, longitude:longitude)
            ///  marker.map = self.mapView
            bounds = bounds.includingCoordinate(marker.position)
            
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude,longitude: coordinate.longitude,zoom: zoomLevel)
        
        self.lat = coordinate.latitude
        self.lon = coordinate.longitude
        
        if mapView.isHidden {
            
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            
            mapView.animate(to: camera)
         //   CreateMarker(Lat: lat ?? 0.0, lng: lon ?? 0.0)
            getLocation(self.lat ?? 0.0, self.lon ?? 0.0)
            getAllAdvOnmao()
            
        }
    }

    
}

//MARK:-API
extension MapVC {
    
    func getAllAdvOnmao(){
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType:.get, parameters: nil, url: "\(hostName)sub-section-map-advertisements/\(Section_id)?lat=\(self.lat ?? 0.0)&lng=\(self.lon ?? 0.0)") { (data : AdvOnMapModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.WorkersArray = data.data?.data ?? []
                self.showPartyMarkers()
                
             
                
                print(data)
                
                
            }
        }
        
    }
    
}

