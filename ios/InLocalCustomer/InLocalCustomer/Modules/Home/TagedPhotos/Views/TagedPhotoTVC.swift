//
//  TagedPhotoTVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//

import UIKit

class TagedPhotoTVC: UITableViewCell {

    @IBOutlet weak var viewMenuContainer: UIView!
    @IBOutlet weak var widthMenuView: NSLayoutConstraint!
    @IBOutlet weak var imgViewPost: UIImageView!
    @IBOutlet weak var widthStackView: NSLayoutConstraint!
    
    var isMenuOpen = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewMenuContainer.roundCorners([.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: 20.0)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgViewPost.isUserInteractionEnabled = true
        imgViewPost.addGestureRecognizer(tapGestureRecognizer)
        
        if isMenuOpen{
            self.widthMenuView.constant = 54
            self.widthStackView.constant = 38
        } else{
            self.widthMenuView.constant = 0
            self.widthStackView.constant = 0
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        // Your action
        if isMenuOpen{
            UIView.animate(withDuration: 0.3) {
                self.widthMenuView.constant = 0
                self.widthStackView.constant = 0
                self.layoutIfNeeded()
            } completion: { [self] (state) in
                isMenuOpen = false
            }
        } else{
            UIView.animate(withDuration: 0.3) {
                self.widthMenuView.constant = 54
                self.widthStackView.constant = 38
                self.layoutIfNeeded()
            } completion: { [self] (state) in
                isMenuOpen = true
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
