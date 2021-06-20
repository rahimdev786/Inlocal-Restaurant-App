//
//  NoOfGuestView.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 19/06/21.
//

import UIKit

protocol NoOfGuestDelegate {
    func onClickCancel()
    func onClickDone(guestCount: String)
}

class NoOfGuestView: UIView {

    
    @IBOutlet weak var imgViewBackground: UIImageView!
    @IBOutlet weak var lblCount: UILabel!
    var delegate : NoOfGuestDelegate!
    
    class func instanceFromNib() -> NoOfGuestView{
        let view = UINib(nibName: "NoOfGuestView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! NoOfGuestView
        
        return view
    }
    
    @IBAction func onClickPlus(_ sender: Any) {
        var count = Int((lblCount.text!))
        count = count! + 1
        lblCount.text = String(count!)
    }
    
    @IBAction func onClickMinus(_ sender: Any) {
        var count = Int((lblCount.text!))!
        if count > 1{
            count = count - 1
            lblCount.text = String(count)
        }
    }
    
    @IBAction func onClickDone(_ sender: Any) {
        let guestCount = lblCount.text!
        delegate.onClickDone(guestCount: guestCount)
        self.removeFromSuperview()
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        delegate.onClickCancel()
        self.removeFromSuperview()
    }
}
