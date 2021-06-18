//
//  DeliveryMenuTVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//

import UIKit

class DeliveryMenuTVC: UITableViewCell {

    @IBOutlet weak var viewCellBackground: UIView!
    @IBOutlet weak var btnCustomizable: UIButton!
    
    @IBOutlet weak var btnCount: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCellBackground.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onClickPlus(_ sender: Any) {
        var count = Int((btnCount.titleLabel?.text!)!)
        count = count! + 1
        btnCount.setTitle(String(count!), for: .normal)
    }
    
    @IBAction func onClickMinus(_ sender: Any) {
        var count = Int((btnCount.titleLabel?.text!)!)!
        if count > 1{
            count = count - 1
            btnCount.setTitle(String(count), for: .normal)
        }
    }
    
}
