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
    
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnCount: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCellBackground.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 10)
        
        btnMinus.isHidden = true
        btnPlus.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onClickAdd(_ sender: UIButton) {
        sender.setImage(nil, for: .normal)
        btnCount.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        btnCount.setTitle("1", for: .normal)
        btnMinus.isHidden = false
        btnPlus.isHidden = false
        
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
