//
//  UITableView + Header + Footer.swift
//  Traxsource
//
//  Created by Dipayan Ghose on 1/10/18.
//  Copyright © 2018 Traxsource. All rights reserved.
//

import Foundation
import  UIKit

extension UITableView {
  //set the tableHeaderView so that the required height can be determined, update the header's frame and set it again
  func setLayoutTableHeaderView() {
    if let headerView = self.tableHeaderView {
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
      var headerFrame = headerView.frame
      //Comparison necessary to avoid infinite loop
      if height != headerFrame.size.height {
        headerFrame.size.height = height
        headerView.frame = headerFrame
        self.tableHeaderView = headerView
      }
    }
  }
  
  func setLayoutTableFooterView() {
    if let footerView = self.tableFooterView {
        let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
      var footerFrame = footerView.frame
      
      //Comparison necessary to avoid infinite loop
      if height != footerFrame.size.height {
        footerFrame.size.height = height
        footerView.frame = footerFrame
        self.tableFooterView = footerView
      }
    }
  }
  
  
  func layoutTableHeaderView() {
    
    guard let headerView = self.tableHeaderView else { return }
    headerView.translatesAutoresizingMaskIntoConstraints = false
    
    let headerWidth = headerView.bounds.size.width;
    let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
    
    headerView.addConstraints(temporaryWidthConstraints)
    
    headerView.setNeedsLayout()
    headerView.layoutIfNeeded()
    
    let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    let height = headerSize.height
    var frame = headerView.frame
    
    frame.size.height = height
    headerView.frame = frame
    
    self.tableHeaderView = headerView
    
    headerView.removeConstraints(temporaryWidthConstraints)
    headerView.translatesAutoresizingMaskIntoConstraints = true
    
  }
    
    
    func layoutTableFooterView() {
        
        guard let footerView = self.tableFooterView else { return }
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        let footerWidth = footerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[footerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": footerWidth], views: ["footerView": footerView])
        
        footerView.addConstraints(temporaryWidthConstraints)
        
        footerView.setNeedsLayout()
        footerView.layoutIfNeeded()
        
        let footerSize = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = footerSize.height
        var frame = footerView.frame
        
        frame.size.height = height
        footerView.frame = frame
        
        self.tableFooterView = footerView
        
        footerView.removeConstraints(temporaryWidthConstraints)
        footerView.translatesAutoresizingMaskIntoConstraints = true
        
    }
  
}
