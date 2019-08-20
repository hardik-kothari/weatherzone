//
//  UIViewFactory.swift
//  OpenWeather
//
//  Created by Hardik on 25/07/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit

class UIViewFactory: NSObject {
    class func getPlaceholderView(with message: String!, parentView: UIView!) -> UIView! {
        let padding = CGFloat(20.0)
        let label = UILabel(frame: CGRect(x: padding, y: 0, width: parentView.bounds.width - (padding * 2), height: 0))
        label.numberOfLines = 0
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        label.font = UIFont(name: "Helvetica", size: 16)!
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = message
        label.adjustsFontSizeToFitWidth = true
        return label
    }
}
