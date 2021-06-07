//
//  MenuCategoryCVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//

import UIKit



class MenuCategoryCVC: UICollectionViewCell {
    
    @IBOutlet weak var viewLblBackground: UIView!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
        viewLblBackground.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 5)
    }
}
