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
//        let name: String
//        let base: String
        let list: [List]
    }
    struct List: Decodable {
        let pressure: Float
        let clouds: Int
    }
    
    
    //
    // FUNCTIONS
    //
    
    // Get the weather forcast
    func getWeatherData(){
        let dayUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=e1322918754fc48f7f5806937b582e85"
        let currentWeatherUrl = "http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=e1322918754fc48f7f5806937b582e85"
        let url = URL(string: dayUrl)!
        
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let data = data else{ return }
                
                do{
                    let decoder = JSONDecoder()
                    self.weather = try decoder.decode(Weather.self, from: data)
                    print(self.weather.list[0].clouds)
                    
                }catch let error{
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }


}

