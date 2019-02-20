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
    private var mapChangedFromUserInteraction = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        mapView.register(VenuePinView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.showsUserLocation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let currentLocation = currentLocation {
            MapManager.shared.centerMap(mapView: mapView, on: currentLocation)
        }
        
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
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Error fetching veues.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    // MARK: - CLLocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) ||
            (CLLocationManager.authorizationStatus() == .authorizedAlways) {
            guard let newLocation = locations.last else { return }
            if newLocation == currentLocation {
                return
            }
            currentLocation = newLocation
        }
    }

    // MARK: - MKMapView Delegate
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! VenueAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if mapChangedFromUserInteraction {
            mapView.removeAnnotations(mapView.annotations)
            APIManager.shared.fetchVenuesIn(city: "New York") { [unowned self] (flag, arrayOfVenues) in
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
                            if let currentCoordinate = self.currentLocation?.coordinate {
                                if (coordinate.latitude == currentCoordinate.latitude) && (coordinate.longitude == currentCoordinate.longitude) {
                                    return
                                } else {
                                    self.mapView.addAnnotation(venueIndicator)
                                }
                            }
                        }
                    }
                } else {
                    print("Error fetching venues")
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "Error fetching veues.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    private func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = self.mapView.subviews[0]
        //  Look through gesture recognizers to determine whether this region change is from user interaction
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if( recognizer.state == .began || recognizer.state == .ended ) {
                    return true
                }
            }
        }
        return false
    }

}
