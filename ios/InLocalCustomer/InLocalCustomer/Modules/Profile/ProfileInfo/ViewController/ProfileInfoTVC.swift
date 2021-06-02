//
//  ProfileInfoTVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//

import UIKit

class ProfileInfoTVC: UITableViewCell {

    static let identifier = "ProfileInfoTVC"
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewContent.applyLightShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
