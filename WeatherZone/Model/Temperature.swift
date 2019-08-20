//
//  Temperature.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import SwiftyJSON

class Temperature: NSObject {
    var day: Float = 0
    var min: Float = 0
    var max: Float = 0
    var night: Float = 0
    var eve: Float = 0
    var morn: Float = 0
    
}

extension Temperature {
    convenience init(json: JSON) {
        self.init()
        day = json["day"].floatValue
        min = json["min"].floatValue
        max = json["max"].floatValue
        night = json["night"].floatValue
        eve = json["eve"].floatValue
        morn = json["morn"].floatValue
    }
}

