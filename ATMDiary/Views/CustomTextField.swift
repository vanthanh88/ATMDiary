//
//  CustomTextField.swift
//  ATMDiary
//
//  Created by  on 2/7/17.
//  Copyright © 2017 thanhnv. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {

    @IBInspectable var radius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = radius
            
        }
    }
    @IBInspectable var boderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = radius
            
        }
    }
    @IBInspectable var boderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = boderColor.cgColor
            
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
