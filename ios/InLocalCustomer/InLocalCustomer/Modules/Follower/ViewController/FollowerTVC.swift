//
//  FollowerTVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 09/06/21.
//

import UIKit

protocol FollowerTVCProtocol: AnyObject {
    func didTapOnCross()
}

class FollowerTVC: UITableViewCell {
    
    weak var delegate: FollowerTVCProtocol?

    static let identifier = "FollowerTVC"
    
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectedBackgroundView = UIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapOnCross(_ sender: UIButton) {
        
        delegate?.didTapOnCross()
    }
    

}
