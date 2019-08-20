//
//  TodayWeather.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import SwiftyJSON

class TodayWeather: NSObject {
    var weather: Weather!
    var temp: Float = 0.0
    var pressure: Float = 0
    var humidity: Int = 0
    var tempMin: Float = 0.0
    var tempMax: Float = 0.0
    var visibility: Float = 0.0
    var windSpeed: Float = 0.0
    var windDeg: Int = 0
    var clouds: Int = 0
    var date: Date!
    var sunrise: Date!
    var sunset: Date!
    var name: String!
}

extension TodayWeather {
    convenience init(json: JSON) {
        self.init()
        weather = Weather.init(json: json["weather"][0])
        temp = json["main"]["temp"].floatValue
        pressure = json["main"]["pressure"].floatValue
        humidity = json["main"]["humidity"].intValue
        tempMin = json["main"]["temp_min"].floatValue
        tempMax = json["main"]["temp_max"].floatValue
        visibility = (Float(json["visibility"].intValue) / 1000.0)
        windSpeed = (json["wind"]["speed"].floatValue * 18.0) / 5.0
        windDeg = json["wind"]["deg"].intValue
        clouds = json["clouds"]["all"].intValue
        date = Date.init(timeIntervalSince1970: json["dt"].doubleValue)
        sunrise = Date.init(timeIntervalSince1970: json["sys"]["sunrise"].doubleValue)
        sunset = Date.init(timeIntervalSince1970: json["sys"]["sunset"].doubleValue)
        name = json["name"].stringValue
    }
}
