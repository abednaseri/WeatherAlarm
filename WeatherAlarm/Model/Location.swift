//
//  Location.swift
//  WeatherAlarm
//
//  Created by Abed on 18.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var Longitude = 0.0
    var Latitude = 0.0
}
