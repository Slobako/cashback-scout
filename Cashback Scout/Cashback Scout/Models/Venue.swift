//
//  Venue.swift
//  Cashback Scout
//
//  Created by Slobodan Kovrlija on 2/15/19.
//  Copyright © 2019 Slobodan Kovrlija. All rights reserved.
//

import Foundation

struct Venue {
    var cashback: Float
    var city = "new york"
    var name: String
    var lat: Float
    var long: Float
}

extension Venue {
    
    init?(json: [String: AnyObject]) {
        guard let cashback = json["cashback"] as? Float,
            let city = json["city"] as? String,
            let name = json["name"] as? String,
            let lat = (json["lat"] as? NSNumber)?.floatValue,
            let long = (json["long"] as? NSNumber)?.floatValue

            else { return nil }
        
        self.cashback = cashback
        self.city = city
        self.name = name
        self.lat = lat
        self.long = long
    }
}
