//
//  MapViewController.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/14/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }

    // MARK: - CLLocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) ||
            (CLLocationManager.authorizationStatus() == .authorizedAlways) {
            guard let currentLocation = locations.last else { return }
            MapManager.shared.centerMap(mapView: mapView, on: currentLocation)
            let userIndicator = MKPointAnnotation()
            userIndicator.coordinate = currentLocation.coordinate
            mapView.addAnnotation(userIndicator)
            APIManager.shared.fetchVenuesIn(city: "New York") { (flag) in
                if flag {
                    print("Venues fetched") // set annotations for all of them too
                } else {
                    print("Error fetching venues")
                }
            }
        }
    }
}
