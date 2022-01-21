//
//  LocationManager.swift
//  Cario
//
//  Created by Nika Topuria on 20.11.21.
//

import CoreLocation
import UIKit
import MapKit

class LocationManager: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var currentUserLocation: CLLocation?
    var didGetLocation: ((CLLocation) -> (Void))?
    
    func configureManager() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    func updateLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentUserLocation = location
            didGetLocation?(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error.localizedDescription)
    }
    
}
