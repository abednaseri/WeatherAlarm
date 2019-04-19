//
//  Weather.swift
//  WeatherAlarm
//
//  Created by Abed on 17.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//


struct ForcastWeather: Decodable {
    let city: City
    let list: [ForcastList]
}
