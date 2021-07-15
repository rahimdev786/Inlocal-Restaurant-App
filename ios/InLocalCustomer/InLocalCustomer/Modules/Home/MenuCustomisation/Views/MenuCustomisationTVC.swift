//
//  menuCustomisationTVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 11/06/21.
//

import UIKit

class MenuCustomisationTVC: UITableViewCell {

    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var btnFirst: UIButton!
    @IBOutlet weak var btnSecond: UIButton!
    
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onClickFirst(_ sender: Any) {
        btnFirst.setImage(#imageLiteral(resourceName: "tick_round_blue"), for: .normal)
        btnSecond.setImage(#imageLiteral(resourceName: "untick_round_blue"), for: .normal)
    }
    
    @IBAction func onClickSecond(_ sender: Any) {
        btnFirst.setImage(#imageLiteral(resourceName: "untick_round_blue"), for: .normal)
        btnSecond.setImage(#imageLiteral(resourceName: "tick_round_blue"), for: .normal)
    }
}
