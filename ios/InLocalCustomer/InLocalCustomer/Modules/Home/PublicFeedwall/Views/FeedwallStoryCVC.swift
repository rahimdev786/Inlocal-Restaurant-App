//
//  FeedwallStoryCVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 03/06/21.
//

import UIKit

class FeedwallStoryCVC: UICollectionViewCell {
    
    @IBOutlet weak var imageViewStory: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewStory.layer.cornerRadius = 20
        imageViewStory.layer.masksToBounds = false
        imageViewStory.clipsToBounds = true
    }

}
