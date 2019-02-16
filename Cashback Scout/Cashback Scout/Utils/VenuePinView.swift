//
//  VenuePinView.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/15/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import Foundation
import MapKit

class VenuePinView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let venuePin = newValue as? VenueAnnotation else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // 2
            markerTintColor = .blue
            glyphText =  venuePin.cashback // String(venuePin.cashback)
        }
    }
}
