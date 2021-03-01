//
//  AdvOnMapVC.swift
//  AskHail
//
//  Created by bodaa on 17/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AdvOnMapVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var lat = 0.0
    var lng = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.lock()
        CreateMarker(Lat: lat, lng: lng)

    }
    
    func CreateMarker(Lat : Double , lng : Double){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:Lat, longitude: lng)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
        marker.map = mapView
        marker.icon = #imageLiteral(resourceName: "neighbourhood")
        let cameraPosition = GMSCameraPosition.camera(withLatitude: Lat, longitude: lng, zoom: 15.0)
        mapView.animate(to: cameraPosition)
        view.unlock()
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

