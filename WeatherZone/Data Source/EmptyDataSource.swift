//
//  EmptyDataSource.swift
//  WeatherZone
//
//  Created by Hardik on 18/02/18.
//  Copyright © 2018 Hardik Kothari. All rights reserved.
//

import UIKit

class EmptyDataSource: NSObject {
    var placeholderMessage: String! = ""
}

extension EmptyDataSource : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIViewFactory.getPlaceholderView(with: placeholderMessage, parentView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableView.frame.height
    }
}

