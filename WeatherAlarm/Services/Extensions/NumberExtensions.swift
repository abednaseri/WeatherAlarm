//
//  NumberExtensions.swift
//  WeatherAlarm
//
//  Created by Abed on 19.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//

import Foundation

extension Float{
    func toCelsius() -> String{
        return "\(Int((self - 273.15).rounded()))"
    }
}
