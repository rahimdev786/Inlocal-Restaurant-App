//
//  DeclineMessageView.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 09/07/21.
//

import UIKit

class DeclineMessageView: UIView
{

    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var lblDeclinedMessage: UILabel!
    
    class func instanceFromNib() -> DeclineMessageView{
        let view = UINib(nibName: "DeclineMessageView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! DeclineMessageView
        
        return view
    }
    
    @IBAction func onClickDone(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}
