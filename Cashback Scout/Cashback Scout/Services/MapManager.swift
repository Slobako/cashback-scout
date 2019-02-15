//
//  MapManager.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/15/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import Foundation
import MapKit

struct MapManager {
    
    static let shared = MapManager()
    
    let regionRadius: CLLocationDistance = 1000
    
    func centerMap(mapView: MKMapView, on location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
