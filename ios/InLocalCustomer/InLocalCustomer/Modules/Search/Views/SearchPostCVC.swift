//
//  SearchPostCVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 02/06/21.
//

import UIKit

class SearchPostCVC: UICollectionViewCell {
    @IBOutlet weak var imgViewUserPost: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgViewUserPost.layer.cornerRadius = 10
        imgViewUserPost.layer.masksToBounds = false
        imgViewUserPost.clipsToBounds = true
    }

}
