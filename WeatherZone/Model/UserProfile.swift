//
//  UserProfile.swift
//  WeatherZone
//
//  Created by Hardik.Kothari on 20/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserProfile: NSObject {
    var id: String!
    var name: String!
    var picture: String!
}

extension UserProfile {
    convenience init(json: JSON) {
        self.init()
        id = json["id"].stringValue
        name = json["name"].stringValue
        picture = json["picture"]["data"]["url"].stringValue
    }
}
