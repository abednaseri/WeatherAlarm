//
//  Constants.swift
//  WeatherAlarm
//
//  Created by Abed on 15.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//

let BASE_API_URL = "http://api.openweathermap.org/data/2.5"
let FORCAST_PREFIX_URL = "/forecast/daily?"
let LATITUDE_URL = "lat="
let LONGITUDE_URL = "&lon="
let APP_ID = "&appid="
let API_KEY = "e1322918754fc48f7f5806937b582e85"

let FORCAST_URL = "\(BASE_API_URL)\(FORCAST_PREFIX_URL)\(LATITUDE_URL)\(Location.sharedInstance.Latitude)\(LONGITUDE_URL)\(Location.sharedInstance.Longitude)&cnt=11\(APP_ID)\(API_KEY)"
