//
//  ServerConfiguration.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit

class ServerConfiguration: NSObject {
    
    var serverURL: String = ""
    static let imageBaseUrl = "http://openweathermap.org/img/w/"
    static let weatherAPIKey = "22da8bc80650eb2218103770708f2a50"
    
    // MARK: - Init
    fileprivate override init() {
        self.buildEnvironment = .development
        super.init()
    }
    
    class var sharedInstance: ServerConfiguration {
        struct Static {
            static var instance: ServerConfiguration?
            static var token: Int = 0
        }
        if Static.instance == nil {
            Static.instance = ServerConfiguration()
        }
        return Static.instance!
    }
    
    var buildEnvironment: DevelopmentEnvironment {
        didSet {
            if buildEnvironment == .staging {
                serverURL = "http://api.openweathermap.org/data/2.5/"
            } else if buildEnvironment == .development {
                serverURL = "http://api.openweathermap.org/data/2.5/"
            } else if buildEnvironment == .local {
                serverURL = "http://api.openweathermap.org/data/2.5/"
            }
        }
    }
}
