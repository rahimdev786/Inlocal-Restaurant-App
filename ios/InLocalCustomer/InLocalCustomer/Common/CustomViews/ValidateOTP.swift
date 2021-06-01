//
//  ValidateOTP.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//

import UIKit
import OTPFieldView

class ValidateOTP: UIView {

    @IBOutlet weak var viewBckGrnd: UIView!
    @IBOutlet weak var imgViewBckGrnd: UIImageView!
    @IBOutlet var otpTextFieldView: OTPFieldView!
    
    
    class func instanceFromNib() -> ValidateOTP{
        let view = UINib(nibName: "ValidateOTP", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ValidateOTP
        view.setupOtpView()
        return view
    }

    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 6
        self.otpTextFieldView.fieldBorderWidth = 2
        self.otpTextFieldView.defaultBorderColor = UIColor.lightGray
        self.otpTextFieldView.filledBorderColor = UIColor.darkGray
        self.otpTextFieldView.cursorColor = UIColor.black
        self.otpTextFieldView.displayType = .square
        self.otpTextFieldView.fieldSize = 50
        self.otpTextFieldView.separatorSpace = 10
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
            //self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }

}
