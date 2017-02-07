//
//  RoundView.swift
//  ATMDiary
//
//  Created by  on 2/7/17.
//  Copyright © 2017 thanhnv. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {

    @IBInspectable var radius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = radius

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
