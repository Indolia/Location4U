//
//   BackgoundLocationFetchManager.swift
//  Loc4U
//
//  Created by Rishi pal on 18/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation
import CoreLocation
protocol BackgroundLocationFetchManagerDelegate:class {
    func userLocationDidUdpate(with location: CLLocation)
}

class BackgroundLocationFetchManager {
    
    static var shared = BackgroundLocationFetchManager()
    weak var delegate: BackgroundLocationFetchManagerDelegate?
    private var timer: Timer?
    private var locationManager: LocationManager?
    
    private init() {
        locationManager = LocationManager()
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 13, repeats: true, block: { [weak self] (timer) in
            self?.fetchLocation()
        })
    }

    func fetchLocation() {
        print("fetchLocation")
        locationManager?.currentLocation(location: {[weak self] (location) in
            self?.delegate?.userLocationDidUdpate(with: location)
        }, permission: { (permission) in
            // do what you want to do
        })
    }
    
    func stopTimer() {
        if let someTimer = timer,  someTimer.isValid {
            someTimer.invalidate()
            timer = nil
            delegate = nil
        }
    }
    
}
