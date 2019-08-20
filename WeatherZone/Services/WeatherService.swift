//
//  WeatherZoneService.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class WeatherService: NSObject {
    class func getCurrentWeatherFor(Location location: CLLocation, success: @escaping (_ weather: TodayWeather) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        NetworkManager.sharedInstance.requestFor(path: "weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)", param: nil, httpMethod: .get, includeHeader: false, success: { (response) in
            if response["error"] != nil {
                failure(nil)
                return
            }
            let currentWeather = TodayWeather.init(json: JSON(response))
            success(currentWeather)
        }) {(error) in
            failure(error)
        }
    }
    
    class func getWeatherForecastFor(Location location: CLLocation, NumberOfDays numberOfDays: Int, success: @escaping (_ forecastList: [Forecast]) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        NetworkManager.sharedInstance.requestFor(path: "forecast/daily?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&cnt=\(numberOfDays)", param: nil, httpMethod: .get, includeHeader: false, success: { (response) in
            debugPrint(response)
            if response["error"] != nil {
                failure(nil)
                return
            }
            var forecastList: [Forecast] = []
            if let forecastArray = response["list"] as? [[String: Any]] {
                for forecastData in forecastArray {
                    forecastList.append(Forecast.init(json: JSON(forecastData)))
                }
                success(forecastList)
            } else {
                failure(nil)
            }
        }) {(error) in
            failure(error)
        }
    }
}
