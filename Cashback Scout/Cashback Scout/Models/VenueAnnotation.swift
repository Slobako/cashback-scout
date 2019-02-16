//
//  VenueAnnotation.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/15/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class VenueAnnotation: NSObject, MKAnnotation {
    let cashback: String
    let name: String
    let city: String
    let coordinate: CLLocationCoordinate2D
    
    init(cashback: String, name: String, city: String, coordinate: CLLocationCoordinate2D) {
        self.cashback = cashback
        self.name = name
        self.city = city
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return cashback
    }
    
    var title: String? {
        return "\(name), \(city)"
    }
    
    // Annotation right callout accessory opens this mapItem
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
