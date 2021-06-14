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
        delegate?.storyTapped()
    }
    
    @IBAction func didTapOnPost(_ sender: UIButton) {
        delegate?.postTapped()
    }
    
    
}
