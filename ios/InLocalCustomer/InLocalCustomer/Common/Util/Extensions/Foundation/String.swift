//
//  String.swift
//  Bedcoin
//
//  Created by Sudipta Patel on 08/01/20.
//  Copyright © 2020 Sudipta Patel. All rights reserved.
//

import Foundation
import UIKit

extension String{
    func isNullString() -> Bool {
        
        let outputString = self
        
        let x: AnyObject = NSNull()
        
        if ((outputString == x as? String) || (outputString.count == 0) || (outputString == " ") || (outputString == "") || (outputString == "(NULL)") || (outputString == "<NULL>") || (outputString == "<null>") || (outputString == "(null)")) {
            return true
        } else {
            return false
        }
    }
    
    func attributedString(stringToBeChanged: String, color: UIColor, font: UIFont?) -> NSMutableAttributedString {
        let newStr = NSMutableAttributedString(string: self)
        let nsRange = NSString(string: self).range(of: stringToBeChanged, options: String.CompareOptions.caseInsensitive)
        if let fnt = font{
            newStr.addAttribute(NSAttributedString.Key.font, value: fnt, range: nsRange)
        }
        newStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: nsRange)
        return newStr
    }
    
    func strikeThrough(stringToBeChanged: String, strikeColor: UIColor) -> NSMutableAttributedString {
        let newStr = NSMutableAttributedString(string: self)
        let nsRange = NSString(string: self).range(of: stringToBeChanged, options: String.CompareOptions.caseInsensitive)
        newStr.addAttributes([
                              NSAttributedString.Key.strikethroughStyle:
                                  NSUnderlineStyle.single.rawValue,
                              NSAttributedString.Key.strikethroughColor:
                               strikeColor], range: nsRange)
        return newStr
    }
    
}
