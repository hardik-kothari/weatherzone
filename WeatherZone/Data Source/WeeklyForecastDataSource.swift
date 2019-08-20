//
//  WeeklyForecastDataSource.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit

class WeeklyForecastDataSource: NSObject {
    
    // MARK: - Variables
    var expandedCellIndex: Int = -1
    fileprivate var tableView: UITableView!
    lazy var forecastList: [Forecast] = []
    
    // MARK: - Initialization method
    convenience init(with tableView: UITableView) {
        self.init()
        tableView.register(UINib.init(nibName: "WeeklyForecastCell", bundle: nil), forCellReuseIdentifier: "WeeklyForecastCell")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        self.tableView = tableView
    }
}

// MARK: - TableView Datasource
extension WeeklyForecastDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension WeeklyForecastDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyForecastCell") as? WeeklyForecastCell {
            cell.showForecastDetails(forecastList[indexPath.row])
            cell.btnHeader.tag = indexPath.row
            cell.btnHeader.addTarget(self, action: #selector(cellOpened(sender:)), for: .touchUpInside)
            if indexPath.row == expandedCellIndex {
                cell.vwDetails.isHidden = false
                cell.vwDetails.alpha = 1.0
            } else {
                cell.vwDetails.isHidden = true
                cell.vwDetails.alpha = 0
            }
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func cellOpened(sender: UIButton) {
        tableView.beginUpdates()
        if expandedCellIndex >= 0 {
            if let previousCell = tableView.cellForRow(at: IndexPath(row: expandedCellIndex, section: 0)) as? WeeklyForecastCell {
                previousCell.animate(duration: 0.2)
            }
        }
        
        if sender.tag != expandedCellIndex {
            expandedCellIndex = sender.tag
            if let toExpandCell = tableView.cellForRow(at: IndexPath(row: expandedCellIndex, section: 0)) as? WeeklyForecastCell {
                toExpandCell.animate(duration: 0.2)
            }
        } else {
            expandedCellIndex = -1
        }
        tableView.endUpdates()
    }
}
