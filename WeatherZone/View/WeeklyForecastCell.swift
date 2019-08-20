//
//  WeeklyForecastCell.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit

class WeeklyForecastCell: UITableViewCell {

    // MARK: - Cell Outlets
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblAvgTemp: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblCloud: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblMinMaxTemp: UILabel!
    @IBOutlet weak var vwDetails: UIView!
    @IBOutlet weak var btnHeader: UIButton!
    @IBOutlet weak var imgArrow: UIImageView!
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Update UI Methods
    func showForecastDetails(_ forecast: Forecast) {
        lblDate.text = forecast.date.string(format: "EEE, dd MMMM")
        lblDesc.text = forecast.weather.desc.capitalized
        lblAvgTemp.text = forecast.temp.day.stringFormat + "°C"
        lblPressure.text = forecast.pressure.stringFormat + " hpa"
        lblCloud.text = "\(forecast.clouds)%"
        lblWind.text = forecast.windSpeed.stringFormat + " km/hr"
        lblMinMaxTemp.text = "\(forecast.temp.max.stringFormat)°C/\(forecast.temp.min.stringFormat)°C"
        imgIcon.setImage(withUrlString: ServerConfiguration.imageBaseUrl + "\(forecast.weather.icon!).png", placeHolderImage: nil)
    }
    
    func animate(duration: Double) {
        if self.vwDetails.alpha == 1 {
            imgArrow?.rotate(CGFloat(0), duration: 0.0)
        } else {
            imgArrow?.rotate(CGFloat(Double.pi / 2), duration: 0.0)
        }
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                self.vwDetails.isHidden = !self.vwDetails.isHidden
                if self.vwDetails.alpha == 1 {
                    self.vwDetails.alpha = 0.5
                } else {
                    self.vwDetails.alpha = 1
                }
            })
        }, completion: nil)
    }
}
