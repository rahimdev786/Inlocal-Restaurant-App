//
//  NotificationSettingsTVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/06/21.
//

import UIKit

class NotificationSettingsTVC: UITableViewCell {

    static let identifier = "NotificationSettingsTVC"
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var settingsSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewContent.applyLightShadow()
    }
    
    @IBAction func didTapOnSwitch(_ sender: UISwitch) {
        
    }
    
    

}
