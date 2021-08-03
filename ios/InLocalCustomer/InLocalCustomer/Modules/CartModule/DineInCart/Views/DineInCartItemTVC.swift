//
//  DineInCartItemTVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 10/06/21.
//

import UIKit

class DineInCartItemTVC: UITableViewCell {

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
    
    @IBAction func onClickOrder(_ sender: UIButton) {
        sender.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        sender.setTitle("Ordered", for: .normal)
        sender.setImage(UIImage(named: "order_tick_white"), for: .normal)
    }
    
}
