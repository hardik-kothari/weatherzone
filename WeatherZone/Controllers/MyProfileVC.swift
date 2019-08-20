//
//  MyProfileVC.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import SwiftyJSON
import FBSDKCoreKit
import FBSDKLoginKit

class MyProfileVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnLogin: UIButton!

    // MARK: - Variables
    var userProfile: UserProfile?
    
    // MARK: - Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let userDetails = UserDefaults.standard.value(forKey: "UserProfile") {
            userProfile = UserProfile.init(json: JSON(userDetails))
        }
        showUserProfileData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Button Actions
    @IBAction func loginTapped(_ sender: UIButton) {
        if userProfile != nil {
            let alertController: UIAlertController = UIAlertController(title: "WeatherZone", message: "Are you sure you want to Logout?", preferredStyle: .alert)
            let logoutAction: UIAlertAction = UIAlertAction(title: "Logout", style: .destructive, handler: { (action) in
                let fbLoginManager : LoginManager = LoginManager()
                fbLoginManager.logOut()
                UserDefaults.standard.removeObject(forKey: "UserProfile")
                self.navigateToLogin()
            })
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(logoutAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            navigateToLogin()
        }
    }
    
    func navigateToLogin() {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let rootNavigationController = appDelegate.window!.rootViewController as! UINavigationController
        if let loginController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") {
            rootNavigationController.setViewControllers([loginController], animated: true)
        }
    }
    
    func showUserProfileData() {
        imgUserProfile.layer.cornerRadius = imgUserProfile.frame.size.height / 2.0
        if userProfile != nil {
            lblUserName.text = userProfile!.name
            imgUserProfile.setImage(withUrlString: "http://graph.facebook.com/\((userProfile!.id)!)/picture?type=large", placeHolderImage: #imageLiteral(resourceName: "default_profile"))
            btnLogin.setTitle("Logout", for: .normal)
            btnLogin.setTitle("Logout", for: .selected)
        } else {
            lblUserName.text = "Guest"
            btnLogin.setTitle("Login", for: .normal)
            btnLogin.setTitle("Login", for: .selected)
        }
    }
}
