//
//  LocationManager.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    let manager: CLLocationManager
    var userLocation: CLLocation!
    var closure: ((_ authorizationStatus:CLAuthorizationStatus, _ userLocation:CLLocation?) -> Void) = {_,_ in }

    // MARK: - Initialize Methods
    class var sharedInstance: LocationManager {
        struct Static {
            static var instance: LocationManager?
            static var token: Int = 0
        }
        if Static.instance == nil {
            Static.instance = LocationManager()
        }
        return Static.instance!
    }
    
    override init() {
        self.manager = CLLocationManager()
        super.init()
        self.manager.delegate = self
    }

    func getCurrentLocation(_ clouser: @escaping((_ authorizationStatus:CLAuthorizationStatus, _ userLocation:CLLocation?) -> Void)) {
        self.closure = clouser
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .notDetermined {
                manager.requestWhenInUseAuthorization()
            } else if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied {
                clouser(CLLocationManager.authorizationStatus(), userLocation)
            } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                manager.startUpdatingLocation()
                clouser(CLLocationManager.authorizationStatus(), userLocation)
            }
        }
    }
}

//MARK: CLLocationManager Delegate methods
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
        if status != .notDetermined {
            closure(CLLocationManager.authorizationStatus(), userLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if userLocation == nil {
            closure(CLLocationManager.authorizationStatus(), locations.last)
        }
        userLocation = locations.last
    }
}
