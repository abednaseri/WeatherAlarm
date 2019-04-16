//
//  DateExtensions.swift
//  WeatherAlarm
//
//  Created by Abed on 15.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//

import Foundation

extension Date{
    func getDayOfWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
