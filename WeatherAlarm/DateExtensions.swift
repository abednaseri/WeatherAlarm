//
//  DateExtensions.swift
//  WeatherAlarm
//
//  Created by Abed on 15.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//

import Foundation

extension Date{
    func getDayOfWeekAndDayOfMonth() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd"
        return dateFormatter.string(from: self)
    }
}
