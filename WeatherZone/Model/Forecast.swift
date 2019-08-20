//
//  Forecast.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import SwiftyJSON

class Forecast: NSObject {
    var date: Date!
    var temp: Temperature!
    var pressure: Float = 0
    var humidity: Int = 0
    var weather: Weather!
    var windSpeed: Float = 0
    var windDeg: Int = 0
    var clouds: Int = 0
}

extension Forecast {
    convenience init(json: JSON) {
        self.init()
        date = Date.init(timeIntervalSince1970: json["dt"].doubleValue)
        temp = Temperature.init(json: json["temp"])
        pressure = json["pressure"].floatValue
        humidity = json["humidity"].intValue
        weather = Weather.init(json: json["weather"][0])
        windSpeed = (json["speed"].floatValue * 18.0) / 5.0
        windDeg = json["deg"].intValue
        clouds = json["clouds"].intValue
    }
}
