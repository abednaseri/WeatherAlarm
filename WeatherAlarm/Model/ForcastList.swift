//
//  ForcastList.swift
//  WeatherAlarm
//
//  Created by Abed on 17.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//

struct ForcastList: Decodable {
    let dt: Double
    let temp: Temperature
    let weather: [WeatherObject]
}
