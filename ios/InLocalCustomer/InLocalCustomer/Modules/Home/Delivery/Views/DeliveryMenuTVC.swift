//
//  DeliveryMenuTVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//

import UIKit

class DeliveryMenuTVC: UITableViewCell {

    @IBOutlet weak var viewCellBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCellBackground.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
