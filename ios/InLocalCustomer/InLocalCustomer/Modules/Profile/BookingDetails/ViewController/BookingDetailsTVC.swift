//
//  BookingDetailsTVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 09/06/21.
//

import UIKit

class BookingDetailsTVC: UITableViewCell {

    static let identifier = "BookingDetailsTVC"
    @IBOutlet weak var btnSelect: UIButton!
    
    @IBOutlet weak var name_Lbl: UILabel!
    @IBOutlet weak var details_Lbl: UILabel!
    @IBOutlet weak var customization_Lbl: UILabel!
    @IBOutlet weak var orderTotal_Lbl: UILabel!
    @IBOutlet weak var finalOrderAmt_Lbl: UILabel!
    @IBOutlet weak var quantity_Lbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectedBackgroundView = UIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
