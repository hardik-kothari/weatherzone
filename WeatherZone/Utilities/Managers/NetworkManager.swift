//
//  NetworkManager.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import Alamofire
import Reachability

class NetworkManager: NSObject {
    // MARK: - Variables
    static var isReachable: Bool = false
    fileprivate var reachability: Reachability?
    
    // MARK: - Initialize Methods
    class var sharedInstance: NetworkManager {
        struct Static {
            static var instance: NetworkManager?
            static var token: Int = 0
        }
        if Static.instance == nil {
            Static.instance = NetworkManager()
        }
        return Static.instance!
    }
    
    override init() {
        super.init()
        reachability = Reachability.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability!.startNotifier()
        } catch {
        }
    }
    
    // MARK: - Request Method
    func requestFor(path: String, param: [String: Any]?, httpMethod: HTTPMethod, includeHeader: Bool, success:@escaping (_ response: [String: Any]) -> Void, failure:@escaping (_ error: Error?) -> Void) {
        
        let completeURL = ServerConfiguration.sharedInstance.serverURL + path + "&appid=\(ServerConfiguration.weatherAPIKey)&units=metric"
        var headerParam: HTTPHeaders?
        if includeHeader {
            headerParam = ["Content-Type": "application/json",
                           "Accept": "application/json"
            ]
        }
        if NetworkManager.isReachable {
            Alamofire.request(completeURL, method: httpMethod, parameters: param, encoding: JSONEncoding.default, headers: headerParam).responseJSON { response in
                switch response.result {
                case .success:
                    if let responseDict = response.result.value as? [String: Any] {
                        success(responseDict)
                    } else {
                        failure(response.result.error)
                    }
                case .failure:
                    failure(response.result.error)
                }
            }
        } else {
            failure(nil)
        }
    }
    
    // MARK: - Rechability
    @objc func reachabilityChanged(_ notification: Notification) {
        if let reachability = notification.object as? Reachability, reachability.connection != .none {
            NetworkManager.isReachable = true
        } else {
            NetworkManager.isReachable = false
        }
    }
}
