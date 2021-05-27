
import Foundation
import UIKit

extension UIView {
    
    func  applyBottomShadow(color:UIColor) {
        
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 3.0
    }
    
    func  applyLightShadow() {
        
        layer.shadowColor = UIColor(white: 0.0, alpha: 0.2).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2.0
    }
    
    func applyAllAroundShadow() {
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 8
    }
    
    func applyLightAllAroundShadow() {
        
        layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5
    }
    
    func applyCommonShadow() {
        
        layer.shadowColor = UIColor(white: 0.0, alpha: 0.4).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.8)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
    }
    
    func applyDarkAllAroundShadow() {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 1.0
    }
    
    func removeShadow() {
        
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.0
        layer.shadowRadius = 0.0
    }
}
