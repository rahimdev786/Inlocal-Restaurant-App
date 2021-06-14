//
//  FollowingTVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 09/06/21.
//

import UIKit

class FollowingTVC: UITableViewCell {

    static let identifier = "FollowingTVC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectedBackgroundView = UIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapOnFriendReq(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    
    

}
