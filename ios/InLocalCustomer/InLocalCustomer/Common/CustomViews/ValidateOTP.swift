//
//  ValidateOTP.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//

import UIKit

class ValidateOTP: UIView {

    @IBOutlet weak var viewBckGrnd: UIView!
    @IBOutlet weak var imgViewBckGrnd: UIImageView!
    
    class func instanceFromNib() -> ValidateOTP{
        return UINib(nibName: "ValidateOTP", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ValidateOTP
    }

}
