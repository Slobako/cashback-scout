//
//  MapViewController.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/14/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

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
        
        mapView.register(VenuePinView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
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
            APIManager.shared.fetchVenuesIn(city: "New York") { (flag, arrayOfVenues) in
                if flag {
                    print("Venues fetched") // set annotations for all of them too
                    DispatchQueue.main.async {
                        for venue in arrayOfVenues {
                            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(venue.lat),
                                                                    longitude: CLLocationDegrees(venue.long))
                            let venueIndicator = VenueAnnotation(cashback: String(describing: venue.cashback),
                                                                                  name: venue.name,
                                                                                  city: venue.city,
                                                                                  coordinate: coordinate)
                            self.mapView.addAnnotation(venueIndicator)
                        }
                    }
                } else {
                    print("Error fetching venues")
                }
            }
        }
    }

    // MARK: - MKMapView Delegate
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! VenueAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
