//
//  LocationModelView.swift
//  Loc4U
//
//  Created by Rishi pal on 18/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationViewModelDelegate: class  {
    func currentLocationDidUpdate(with location: CLLocation)
    func locationPermissionDidChanged(with status:Bool)
}

class LocationViewModel {
    weak var delegate: LocationViewModelDelegate?
    lazy var BLFetchManager = BackgroundLocationFetchManager.shared
     var networkManager = NetworkManager.shared
    
      init() {
        BLFetchManager.delegate = self
        networkManager.delegate = self
       
    }
    deinit {
        BLFetchManager.delegate = nil
    }
    
    func getCurrentLocation() {
         BLFetchManager.startTimer()
    }
    
    func saveUpdatedLocationInLocal(_ location: CLLocation) {
        UserLocation.save(with: location, appState: AppDelegate.applicationState)
    }
}

extension LocationViewModel : BackgroundLocationFetchManagerDelegate {
    func userLocationDidUdpate(with location: CLLocation) {
       delegate?.currentLocationDidUpdate(with: location)
       saveUpdatedLocationInLocal(location)
    }
}

extension LocationViewModel : NetworkManagerDelegate {
    func didNetowrkUnreachable() {
        // do what to do
    }
    
    func didNetowrkReachable() {
        UserLocation.updateDataOnServerAndCleanLocalData()
    }

}
