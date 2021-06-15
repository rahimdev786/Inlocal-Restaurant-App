//
//  CustomCameraOverlay.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 13/06/21.
//

import UIKit

protocol CustomCameraOverlayProtocol: AnyObject {
    
    func cameraTapped(isSelected:Bool)
    func cameraCancelled()
    func galleryTapped()
    func flashTapped()
    func storyTapped()
    func postTapped()
}
class CustomCameraOverlay: UIView {

    weak var delegate: CustomCameraOverlayProtocol?
    
    @IBOutlet weak var btnStory: UIButton!
    @IBOutlet weak var btnPost: UIButton!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        btnStory.isSelected = true
        btnStory.titleLabel?.textColor = .white
        btnStory.backgroundColor = .blue
        delegate?.postTapped()
    }
    
    @IBAction func didTapOnCamera(_ sender: UIButton) {
        //sender.isSelected = !sender.isSelected
        delegate?.cameraTapped(isSelected:sender.isSelected)
    }
    
    @IBAction func didTapOnCancel(_ sender: UIButton) {
        delegate?.cameraCancelled()
    }
    @IBAction func didTapOnGallery(_ sender: UIButton) {
        delegate?.galleryTapped()
    }
    
    @IBAction func didTapOnFlash(_ sender: UIButton) {
        
        delegate?.flashTapped()
    }
    
    @IBAction func didTapOnStory(_ sender: UIButton) {
        sender.isSelected = true
        sender.titleLabel?.textColor = .white
        sender.backgroundColor = .blue
        btnPost.backgroundColor = UIColor(hexString: "333333")
        btnPost.titleLabel?.textColor = .white
        btnPost.isSelected = false
        
        delegate?.storyTapped()
    }
    
    @IBAction func didTapOnPost(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.backgroundColor = .blue
        btnStory.backgroundColor = UIColor(hexString: "333333")
        btnStory.titleLabel?.textColor = .white
        btnStory.isSelected = false
        
        delegate?.postTapped()
    }
    
    
}
