//
//  Extensions.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

extension UIViewController {
    func showProgressView(_ message: String = "") {
        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: false)
            let hud = MBProgressHUD.showAdded(to: ((UIApplication.shared.delegate?.window)!)!, animated: true)
            hud.label.text = message
            hud.contentColor = UIColor.white
            hud.bezelView.alpha = 1.0
            hud.bezelView.color = UIColor.clear
            hud.bezelView.style = .solidColor
            hud.backgroundView.color = UIColor.black
            hud.backgroundView.alpha = 0.6
            hud.backgroundView.style = .solidColor
        })
    }
    
    func hideProgressView() {
        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
        })
    }
    
    func showAlertFor(Message message:String) {
        let alertView: UIAlertController = UIAlertController(title: "WeatherZone", message: message, preferredStyle: .alert)
        let okButton: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(okButton)
        present(alertView, animated: true, completion: nil)
    }
}

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Float {
    var stringFormat: String {
        return String(format: "%.0f", self)
    }
}

extension UIImageView {
    func setImage(withUrlString url: String, placeHolderImage: UIImage?) {
        if let image = placeHolderImage {
            self.sd_setImage(with: URL(string: url), placeholderImage: image)
        } else {
            self.sd_setImage(with: URL(string: url))
        }
    }
}
