//
//  AppFonts.swift
//  InnoShuttle
//
//  Created by Writayan Das on 18/11/19.
//  Copyright © 2019 Innofied Solution Pvt. Ltd. All rights reserved.
//

import UIKit

enum AppFont {
    
    case AvenirBlack(ofSize: CGFloat)
    case AvenirBook(ofSize: CGFloat)
    case AvenirRoman(ofSize: CGFloat)
   
    
    var font: UIFont {
        
        switch self {
            
        case .AvenirBlack(let size):
            return UIFont(name: "AvenirLTStd-Black", size: size)!
        case .AvenirBook(let size):
            return UIFont(name: "AvenirLTStd-Book", size: size)!
        case .AvenirRoman(let size):
            return UIFont(name: "AvenirLTStd-Roman", size: size)!
        }
    }
}
