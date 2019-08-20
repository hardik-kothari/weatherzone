//
//  LoginVC.swift
//  WeatherZone
//
//  Created by Hardik.Kothari on 20/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import SwiftyJSON
import FBSDKCoreKit
import FBSDKLoginKit

class LoginVC: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    
    // MARK: - Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0, animations: {
            self.logoTopConstraint.constant = 75.0
            self.view.layoutIfNeeded()
        }) { (completion) in
            UIView.animate(withDuration: 0.7, animations: {
                self.loginView.alpha = 1.0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Button Actions
    @IBAction func skipTapped(_ sender: UIButton) {
        if let tabbarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") {
            navigationController?.viewControllers = [tabbarController]
        }
    }
    
    @IBAction func fbLoginTapped(_ sender: UIButton) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                if (result?.isCancelled)! {
                    return
                }
                if(fbloginresult.grantedPermissions.contains("public_profile")) {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData() {
        weak var weakSelf = self
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "name, first_name, last_name, picture.type(large)"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
                    UserDefaults.standard.set(result, forKey: "UserProfile")
                    UserDefaults.standard.synchronize()
                    if let tabbarController = weakSelf?.storyboard?.instantiateViewController(withIdentifier: "TabBarController") {
                        weakSelf?.navigationController?.viewControllers = [tabbarController]
                    }
                }
            })
        }
    }
}
