//
//  TodayForecastVC.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit

class TodayForecastVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var imgWeatherIcon: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblMinMaxTemp: UILabel!
    @IBOutlet weak var lblVisibility: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblCloud: UILabel!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWeatherDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Button Actions
    @IBAction func refreshTapped(_ sender: UIBarButtonItem) {
        getWeatherDetails()
    }
    
    // MARK: - Api Methods
    func getWeatherDetails() {
        showProgressView()
        weak var weakSelf = self
        LocationManager.sharedInstance.getCurrentLocation { (authorizationStatus, userLocation) in
            if authorizationStatus == .denied {
                weakSelf?.hideProgressView()
                weakSelf?.showAlertFor(Message: "Please enable location service from Settings to get Weather forecast.")
                return
            }
            guard let location = userLocation else {
                weakSelf?.showProgressView("Fetching location...")
                return
            }
            WeatherService.getCurrentWeatherFor(Location: location, success: {(weather) in
                weakSelf?.hideProgressView()
                weakSelf?.showWeatherDetails(weather: weather)
            }) { (error) in
                weakSelf?.hideProgressView()
                if let error = error {
                    weakSelf?.showAlertFor(Message: error.localizedDescription)
                } else {
                    weakSelf?.showAlertFor(Message: "Please check your internet connection.")
                }
            }
        }
    }
    
    func showWeatherDetails(weather: TodayWeather) {
        lblCity.text = weather.name
        lblWeather.text = weather.weather.main
        lblTemp.text = weather.temp.stringFormat + "°C"
        imgWeatherIcon.setImage(withUrlString: ServerConfiguration.imageBaseUrl + "\(weather.weather.icon!).png", placeHolderImage: nil)
        lblDate.text = weather.date.string(format: "EEEE, dd MMMM")
        lblPressure.text = weather.pressure.stringFormat + " hpa"
        lblCloud.text = "\(weather.clouds)%"
        lblWind.text = weather.windSpeed.stringFormat + " km/hr"
        lblMinMaxTemp.text = "\(weather.tempMax.stringFormat)°C/\(weather.tempMin.stringFormat)°C"
        lblHumidity.text = "\(weather.humidity)%"
        lblVisibility.text = "\(weather.visibility) km"
    }
}
