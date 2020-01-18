//
//  LocationManager.swift
//  Loc4U
//
//  Created by Rishi pal on 18/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation

import UIKit
import CoreLocation
import MapKit
class LocationManager:NSObject, CLLocationManagerDelegate {
    
    private let cllocationManager = CLLocationManager()
    var locationFetched: ((CLLocation)->Void)?
    var permission: ((Bool)->Void)?
    
    
    func currentLocation(location fetched: @escaping (CLLocation)->Void, permission grant:@escaping(Bool)->Void) {
        self.locationFetched            = fetched
        self.permission                 = grant
        cllocationManager.requestWhenInUseAuthorization()
        cllocationManager.delegate        = self
        cllocationManager.distanceFilter  = 0 // In meterers
        cllocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        cllocationManager.stopUpdatingLocation()
        cllocationManager.startUpdatingLocation()
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways && CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse {
            if let permission = self.permission {
                permission(false)
            }
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        var granted = false
        switch status {
        case .authorizedAlways:
            granted = true
        case .authorizedWhenInUse:
            granted = true
        default:
            granted = false
        }
        
        // callback with permission
        if let permission = self.permission {
            permission(granted)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Got current location
        if let callback = self.locationFetched {
            if  let location = manager.location {
                callback(location)
            }
        }
    }
}
    
