//
//  UIImage+Utilities.swift
//  Busapp
//
//  Created by Writayan Das on 09/11/18.
//  Copyright © 2018 Innofied Solution Pvt. Ltd. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setFadeInImage(image: UIImage, duration: TimeInterval) {
        
        DispatchQueue.main.async { [unowned self] in
            // Adding image with Fade In Animation
            UIView.transition(with: self,
                              duration: duration,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.image = image
            },
                              completion: nil)
        }
    }
}

extension UIImage {
    
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            guard let cgImage = cgImage else {
                return nil
            }
            context.draw(cgImage, in: newRect)
            let newImage = UIImage(cgImage: context.makeImage()!)
            UIGraphicsEndImageContext()
            return newImage
        }
        return nil
    }
    
    func fixOrientation() -> UIImage {
            if self.imageOrientation == UIImage.Orientation.up {
                return self
            }
            
            UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
            self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
            let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            return normalizedImage;
        }
}
