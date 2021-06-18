//
//  ValidateOTP.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//

import UIKit
import OTPFieldView

protocol ValidateOTPDelegate {
    func onClickContinue()
}

class ValidateOTP: UIView{
    
    @IBOutlet weak var viewBckGrnd: UIView!
    @IBOutlet weak var imgViewBckGrnd: UIImageView!
    @IBOutlet var otpTextFieldView: OTPFieldView!
    
    @IBOutlet weak var btnContinue: UIButton!
    
    var delegate : ValidateOTPDelegate!
    
    class func instanceFromNib() -> ValidateOTP{
        let view = UINib(nibName: "ValidateOTP", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ValidateOTP
        view.setupOtpView()
        return view
    }

    func setupOtpView(){
        btnContinue.alpha = 0.5
        btnContinue.isUserInteractionEnabled = false
        
        self.otpTextFieldView.fieldsCount = 6
        self.otpTextFieldView.fieldBorderWidth = 2
        self.otpTextFieldView.defaultBorderColor = UIColor.lightGray
        self.otpTextFieldView.filledBorderColor = UIColor.darkGray
        self.otpTextFieldView.cursorColor = UIColor.black
        self.otpTextFieldView.displayType = .square
        self.otpTextFieldView.fieldSize = 40
        self.otpTextFieldView.separatorSpace = 5
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }

    @IBAction func onClickContinue(_ sender: Any) {
        delegate.onClickContinue()
    }
    
}

extension ValidateOTP : OTPFieldViewDelegate{
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        print(otp)
        btnContinue.alpha = 1
        btnContinue.isUserInteractionEnabled = true
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        return true
    }
}
