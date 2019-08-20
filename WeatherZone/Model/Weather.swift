//
//  WeatherZone.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import SwiftyJSON

class Weather: NSObject {
    var main: String!
    var desc: String!
    var icon: String!
}

extension Weather {
    convenience init(json: JSON) {
        self.init()
        main = json["main"].stringValue
        desc = json["description"].stringValue
        icon = json["icon"].stringValue
    }
}
