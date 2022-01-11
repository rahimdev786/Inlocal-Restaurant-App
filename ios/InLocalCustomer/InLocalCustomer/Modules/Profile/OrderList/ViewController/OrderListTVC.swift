//
//  OrderListTVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//

import UIKit



class OrderListTVC: UITableViewCell {

    @IBOutlet weak var resturantDineInLabelOutlet: UILabel!
    static let identifier = "OrderListTVC"
    
    @IBOutlet weak var cusineNameOutlet: UILabel!
    @IBOutlet weak var orderDateLabelOutlet: UILabel!
    @IBOutlet weak var priceLabelOutlet: UILabel!
    @IBOutlet weak var orderIdLabelOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
