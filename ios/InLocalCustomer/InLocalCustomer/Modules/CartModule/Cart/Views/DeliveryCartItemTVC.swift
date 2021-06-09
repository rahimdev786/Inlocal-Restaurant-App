//
//  DeliveryCartItemTVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 09/06/21.
//

import UIKit

class DeliveryCartItemTVC: UITableViewCell {

    
    @IBOutlet weak var viewBackCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBackCell.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
