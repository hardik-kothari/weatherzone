//
//  WeeklyForecastVC.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit
import CoreLocation

class WeeklyForecastVC: UIViewController {
    
    // MARK: - Stored Properties
    var refreshControl: UIRefreshControl?
    
    // MARK: - Outlets
    @IBOutlet var tblForecast: UITableView!
    
    // MARK: - Variables
    var forecastList: [Forecast] = []
    var datasource: WeeklyForecastDataSource!
    lazy var emptyDatasource: EmptyDataSource = EmptyDataSource()
    
    // MARK: - Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = WeeklyForecastDataSource(with: tblForecast)
        addPullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWeeklyForecast()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Api Methods
    func getWeeklyForecast(_ showIndecator: Bool = true) {
        weak var weakSelf = self
        LocationManager.sharedInstance.getCurrentLocation { (authorizationStatus, userLocation) in
            if authorizationStatus == .denied {
                DispatchQueue.main.async {
                    weakSelf?.refreshControl?.endRefreshing()
                    weakSelf?.hideProgressView()
                    weakSelf?.showAlertFor(Message: "Please enable location service from Settings to get Weather forecast.")
                }
                return
            }
            guard let location = userLocation else {
                weakSelf?.showProgressView("Fetching location...")
                return
            }
            if showIndecator {
                weakSelf?.showProgressView()
            }
            WeatherService.getWeatherForecastFor(Location: location, NumberOfDays: 5, success: {(forecastArray) in
                weakSelf?.hideProgressView()
                weakSelf?.forecastList = forecastArray
                weakSelf?.reloadTable()
            }) { (error) in
                weakSelf?.hideProgressView()
                weakSelf?.refreshControl?.endRefreshing()
                if let error = error {
                    weakSelf?.showAlertFor(Message: error.localizedDescription)
                } else {
                    weakSelf?.showAlertFor(Message: "Please check your internet connection.")
                }
            }
        }
    }
    
    // MARK: - Pull To Refresh
    func addPullToRefresh() {
        if self.refreshControl != nil {
            self.refreshControl?.removeFromSuperview()
            refreshControl = nil
        }
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.isHidden = false
        self.refreshControl?.tintColor = UIColor.white
        self.refreshControl!.attributedTitle = NSAttributedString(string: "")
        self.refreshControl!.addTarget(self, action: #selector(WeeklyForecastVC.refreshForecastData), for: UIControlEvents.valueChanged)
        tblForecast.insertSubview(refreshControl!, at: 0)
    }
    
    @objc func refreshForecastData() {
        forecastList.removeAll()
        tblForecast.setContentOffset(CGPoint(x:0, y:self.tblForecast.contentOffset.y - self.refreshControl!.frame.size.height), animated: true)
        refreshControl?.beginRefreshing()
        getWeeklyForecast(false)
    }
    
    // MARK: - Update UI Methods
    func reloadTable() {
        refreshControl?.endRefreshing()
        if forecastList.isEmpty {
            var placeHolderMessage: String = ""
            placeHolderMessage = "No forecast data available."
            emptyDatasource.placeholderMessage = placeHolderMessage
            tblForecast.delegate = emptyDatasource
            datasource.forecastList = []
        } else {
            datasource.forecastList = forecastList
            tblForecast.dataSource = datasource
            tblForecast.delegate = datasource
        }
        tblForecast.reloadData()
    }
}
