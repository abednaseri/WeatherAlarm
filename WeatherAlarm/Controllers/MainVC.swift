//
//  MainVC.swift
//  WeatherAlarm
//
//  Created by Abed on 14.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var weather: Weather!
    var weatherForcastArray: [ForcastList] = []

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getWeatherData()
        // Do any additional setup after loading the view.
    }
    

    
    
    
    //
    // FUNCTIONS
    //
    
    // Get the weather forcast
    func getWeatherData(){
        let dayUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=50.35357&lon=7.57883&cnt=10&appid=e1322918754fc48f7f5806937b582e85"
        
        let url = URL(string: dayUrl)!
        
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let data = data else{ return }
                
                do{
                    let decoder = JSONDecoder()
                    self.weather = try decoder.decode(Weather.self, from: data)
                    self.weatherForcastArray = self.weather.list
                    self.tableView.reloadData()
                    
                }catch let error{
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForcastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForcastCell", for: indexPath) as? ForcastCell{
            
            let forcast = weatherForcastArray[indexPath.row]
            
            cell.dayOfWeekLabel.text = Date(timeIntervalSince1970: forcast.dt).getDayOfWeek()
            cell.maxTempLabel.text = "\(Int((forcast.temp.max - 273.15).rounded()))"
            cell.minTempLabel.text = "\(Int((forcast.temp.min - 273.15).rounded()))"
            
            return cell
        }
        return UITableViewCell()
    }

    
    
    
    struct Weather: Decodable {
        let list: [ForcastList]
    }
    struct ForcastList: Decodable {
        let dt: Double
        let temp: Temperature
    }
    struct Temperature: Decodable {
        let day: Float
        let min: Float
        let max: Float
    }

}

