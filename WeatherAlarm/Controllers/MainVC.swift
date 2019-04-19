//
//  MainVC.swift
//  WeatherAlarm
//
//  Created by Abed on 14.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//

import UIKit
import CoreLocation

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager!
    var weather: Weather!
    var weatherForcastArray: [ForcastList] = []
    var didFindLocation = false

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    

    
    
    
    
    
    //
    // MARK: - FUNCTIONS
    //
    
    // Get the weather forcast
    func getWeatherData(){
        guard let url = URL(string: FORCAST_URL) else { return }
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
    
    // Show an alert
    func showAlert(withMessage message: String, withTitle title: String, actionTitle: String? = "OK"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    //
    // MARK: - DELEGATES
    //
    
    
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

    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.locationServicesEnabled(){
            switch status {
            case .authorizedWhenInUse:
                didFindLocation = false
                locationManager.startUpdatingLocation()
                break
            case .denied, .restricted:
                // Show alert or block user
                showAlert(withMessage: "Oopsie! I'm not sure if I can show you any weather information, if I don't know where you are located", withTitle: "No location, no Weather!")
                break
            default:
                locationManager.requestWhenInUseAuthorization()
            }
        }else{
            // Alert enable location services
            showAlert(withMessage: "Please go to your device Settings -> Privacy -> Location and enable your Location Services.", withTitle: "Location Services is disabled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last{
            // If locations is not still taken
            if !didFindLocation{
                Location.sharedInstance.Latitude = lastLocation.coordinate.latitude
                Location.sharedInstance.Longitude = lastLocation.coordinate.longitude
                getWeatherData()
                didFindLocation = true
                locationManager.stopUpdatingLocation()
            }else{
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    

}

