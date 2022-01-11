//
//  NotificationTVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 02/06/21.
//

import UIKit

class NotificationTVC: UITableViewCell {

    
    @IBOutlet weak var deliveryTitle_Lbl: UILabel!
    @IBOutlet weak var deliveryDetails_Lbl: UILabel!
    @IBOutlet weak var day_Lbl: UILabel!
    @IBOutlet weak var date_Lbl: UILabel!
    @IBOutlet weak var deliveryImgView: UIImageView!
    
    
    
    @IBOutlet weak var imgViewNewNotification: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
