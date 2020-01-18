//
//  HomeViewController.swift
//  Loc4U
//
//  Created by Rishi pal on 18/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    let locationViewModel = LocationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        getCurrentLocation()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func uiSetup() {
        self.navigationItem.setHidesBackButton(true, animated:true);
        addLogoutButton()
    }
    
    func addLogoutButton() {
        let logoutItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem  = logoutItem
    }
    
    @objc private func logout() {
        LogoutManager.logout()
        DispatchQueue.main.async {
            Indexer().setWelcomeAsRoot()
        }
    }
}

extension HomeViewController : LocationViewModelDelegate {
    func getCurrentLocation() {
        locationViewModel.delegate = self
        locationViewModel.getCurrentLocation()
    }
    
    func currentLocationDidUpdate(with location: CLLocation) {
        setLocationOnMap(with: location)
    }
    
    func locationPermissionDidChanged(with status: Bool) {
        //do that you need when permission is changed
    }
    
    func setLocationOnMap(with location:CLLocation) {
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
    }
    
}






