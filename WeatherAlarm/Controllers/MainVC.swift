//
//  MainVC.swift
//  WeatherAlarm
//
//  Created by Abed on 14.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var weather : Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData()
        // Do any additional setup after loading the view.
    }
    
    struct Weather: Decodable {
        let list: [List]
    }
    struct List: Decodable {
        let dt: Double
        let temp: Temperature
    }
    struct Temperature: Decodable {
        let day: Float
        let min: Float
        let max: Float
    }
    
    
    
    
    
    
    
    
    //
    // FUNCTIONS
    //
    
    // Get the weather forcast
    func getWeatherData(){
        let dayUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=50.35357&lon=7.57883&cnt=10&appid=e1322918754fc48f7f5806937b582e85"
        let currentWeatherUrl = "http://api.openweathermap.org/data/2.5/weather?lat=50.35357&lon=139&appid=e1322918754fc48f7f5806937b582e85"
        let url = URL(string: dayUrl)!
        
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let data = data else{ return }
                
                do{
                    let decoder = JSONDecoder()
                    self.weather = try decoder.decode(Weather.self, from: data)
                    // Format the date of 'time Since 1970' to readable date
                    let unixConvertedDate = Date(timeIntervalSince1970: self.weather.list[0].dt)
                    let date = unixConvertedDate.getDayOfWeekAndDayOfMonth()
                    print("\((self.weather.list[0].temp.max - 273.15).rounded()) time= \(date)")
                    
                }catch let error{
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }


}

