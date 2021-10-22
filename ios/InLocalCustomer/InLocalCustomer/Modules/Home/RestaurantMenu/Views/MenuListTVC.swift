//
//  MenuListTVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//

import UIKit

class MenuListTVC: UITableViewCell {

    @IBOutlet weak var viewCellBackground: UIView!
    @IBOutlet weak var imageViewMenu: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!
    @IBOutlet weak var lblMenuDetails: UILabel!
    @IBOutlet weak var lblMenuPrice: UILabel!
    
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
