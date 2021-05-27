//
//  UITableviewCell.swift
//  InnoShuttle
//
//  Created by Sudipta Patel on 26/11/19.
//  Copyright © 2019 Innofied Solution Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
//    var tableView: UITableView? {
//        return next(UITableView.self)
//    }
//
//    var indexPath: IndexPath? {
//        return tableView?.indexPath(for: self)
//    }
    
    func applyConfig(for indexPath: IndexPath, numberOfCellsInSection: Int, radius: CGFloat) {
        switch indexPath.row {
        case numberOfCellsInSection - 1:
            // This is the case when the cell is last in the section,
            // so we round to bottom corners
            self.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: radius)
            
            // However, if it's the only one, round all four
            if numberOfCellsInSection == 1 {
                self.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: radius)
            }
            
        case 0:
            // If the cell is first in the section, round the top corners
            self.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: radius)
            
        default:
            // If it's somewhere in the middle, round no corners
            self.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 0.0)
        }
    }
}

