//
//  TextFieldView.swift
//  KML
//
//  Created by Sudipta Patel on 29/08/19.
//  Copyright © 2019 SANDEEP DUTTA. All rights reserved.
//

import UIKit

enum InputFieldType{
    case email
    case firstName
    case password
    case lastName
    case otp
    case cnfrmPassword
    case newPassword
    case oldPassword
    case landmark
    case zipcode
    case country
    case address
    case city
    case phone
    case prdctCity
    case deliveryType
    case timeSlot
    case date
    
}

  @objc protocol TextFieldDelegate: class {
    func textFieldViewDidChangeEditing(_ textFieldView: TextFieldView, string: String)
    func textFieldViewShouldReturn(_ textFieldView: TextFieldView) -> Bool
    func forgotPwdClicked()
    func textFiedViewDidEndEditing(_ textFieldView: TextFieldView)
    @objc optional func didTapOnSelectCountryCode()
    @objc optional func shouldBeginEditing(_ textFieldView: TextFieldView)
}

class TextFieldView: UIView {
    
    @IBOutlet weak var txtFldInput : UITextField!
    @IBOutlet weak var viewErrorHolder: UIView!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var imgViewLeftIcon: UIImageView!
    @IBOutlet weak var imgViewRightIcon: UIImageView!
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnShowPwd: UIButton!
    @IBOutlet weak var stckViewCountryCode: UIStackView!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var imgViewCountryFlag: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewTxtFieldBack: UIView!
    @IBOutlet weak var imgDropdown: UIImageView!
    
    var delegate : TextFieldDelegate?
    var fieldType:InputFieldType!
    let tapGuestureTxtFld = UITapGestureRecognizer(target: self, action: #selector(didTapTxtFld(sender:)))

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(didTapCountryCode(sender:)))
        stckViewCountryCode.addGestureRecognizer(tapGuesture)
        
        viewTxtFieldBack.layer.cornerRadius = viewTxtFieldBack.frame.height / 2
        viewTxtFieldBack.layer.masksToBounds = true
    }
    
 /*   class func instanceFromNib() -> TextFieldView{
        return UINib(nibName: "TextFieldView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! TextFieldView
    }*/
    
   
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
     
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
    
     
    func commonInit() {
           Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)
           contentView.fixInView(self)
       }
    
    @objc func didTapCountryCode(sender: UIGestureRecognizer){
         
             delegate?.didTapOnSelectCountryCode?()
    }
    
    @objc func didTapTxtFld(sender: UIGestureRecognizer){
        
    }
    
    func populateWithData(text:String?, placeholderText:String?, fieldType:InputFieldType) {
        
        txtFldInput.text = text
        self.fieldType = fieldType
        stckViewCountryCode.isHidden = true
        viewErrorHolder.isHidden = true
        lblError.isHidden = true
        UIColor.init(hexString: "#Ed5661")
        //lblError.textColor = UIColor.darkGray //UIColor.init(hexString: "#Ed5661")
        imgViewRightIcon.isHidden = true
        btnShowPwd.isHidden = true
        btnForgot.isHidden = true
        btnForgot.setTitle("Forgot", for: .normal)
        txtFldInput.placeholder = placeholderText
        txtFldInput.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        switch fieldType {
        case .phone:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .phonePad
            stckViewCountryCode.isHidden = true
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            
        case .email:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .emailAddress
            txtFldInput.autocapitalizationType = .none
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            
        case .firstName:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .words
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            
        case .password:
            txtFldInput.isSecureTextEntry = true
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            btnForgot.isHidden = true
            txtFldInput.textContentType = UITextContentType(rawValue: "")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            btnShowPwd.isHidden = false
            btnShowPwd.setImage(#imageLiteral(resourceName: "hide_password"), for: .normal)

        case .lastName:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .words
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "name")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            
        case .city:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "landmark")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true

        case .otp:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .numberPad
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "otp")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            

        case .cnfrmPassword:
            txtFldInput.isSecureTextEntry = true
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "password")
            txtFldInput.textContentType = UITextContentType(rawValue: "")
            

            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            btnShowPwd.isHidden = false
            btnShowPwd.setImage(#imageLiteral(resourceName: "hide_password"), for: .normal)
            
        case .newPassword:
            txtFldInput.isSecureTextEntry = true
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "password")
            txtFldInput.textContentType = UITextContentType(rawValue: "")

            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            btnShowPwd.isHidden = false
            btnShowPwd.setImage(#imageLiteral(resourceName: "hide_password"), for: .normal)
            
        case .oldPassword:
            txtFldInput.isSecureTextEntry = true
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "password")
            txtFldInput.textContentType = UITextContentType(rawValue: "")

            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            btnShowPwd.isHidden = false
            btnShowPwd.setImage(#imageLiteral(resourceName: "hide_password"), for: .normal)
                        
        case .landmark:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "landmark")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            
        case .address:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "address")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            
        case .country:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "country")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            imgViewRightIcon.image = UIImage(named: "arrow_down")
                        
        case .zipcode:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .numberPad
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "zip_code")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            
        case .prdctCity:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "landmark")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            self.addGestureRecognizer(tapGuestureTxtFld)

        case .date:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "datePlaceholder")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            self.addGestureRecognizer(tapGuestureTxtFld)

        case .deliveryType:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "delivery_type")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            self.addGestureRecognizer(tapGuestureTxtFld)

        case .timeSlot:
            txtFldInput.isSecureTextEntry = false
            txtFldInput.keyboardType = .default
            txtFldInput.autocapitalizationType = .none
            //imgViewLeftIcon.image = #imageLiteral(resourceName: "time_slot")
            imgViewLeftIcon.isHidden = true
            imgViewRightIcon.isHidden = true
            self.addGestureRecognizer(tapGuestureTxtFld)

        }
        
    }
    
    func showError(with errorText: String) {
        lblError.isHidden = false
        viewErrorHolder.isHidden = false
        lblError.text = errorText
    }
    
    func hideError() {
        
        lblError.isHidden = true
        viewErrorHolder.isHidden = true
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        //your code
        
        
        delegate?.textFieldViewDidChangeEditing(self, string: textField.text ?? "")
    }
    
    @IBAction func onClickForgot(_ sender: Any) {
        delegate?.forgotPwdClicked()
    }
    
    @IBAction func onClickShowPassword(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            sender.setImage(#imageLiteral(resourceName: "hide_password"), for: .normal)
            txtFldInput.isSecureTextEntry = true
        } else{
            sender.isSelected = true
            sender.setImage(#imageLiteral(resourceName: "show_password"), for: .normal)
            txtFldInput.isSecureTextEntry = false
        }
       // delegate?.showPassword(isHide: sender.isSelected)
    }
    
}

extension TextFieldView: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFiedViewDidEndEditing(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        return delegate?.textFieldViewShouldReturn(self) ?? false
    }
   
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
//        if fieldType == .otp{
//            return newString.length <= 4
//        } else
//            if fieldType == .zipcode{
//            return newString.length <= 6
//
//        } else if fieldType == .phone{
//            return newString.length <= 10
//
//        } else{
            return true
        //}
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//         delegate?.shouldBeginEditing!(self)
//        return true
//    }
}

extension UIView{
    
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
