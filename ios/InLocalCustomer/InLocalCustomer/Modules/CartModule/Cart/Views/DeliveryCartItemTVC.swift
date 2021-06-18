//
//  DeliveryCartItemTVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 09/06/21.
//

import UIKit

class DeliveryCartItemTVC: UITableViewCell {

    
    @IBOutlet weak var viewBackCell: UIView!
    @IBOutlet weak var btnCount: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBackCell.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 20)
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
