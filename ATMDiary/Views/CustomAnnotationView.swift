//
//  CustomAnnotationView.swift
//  ATMDiary
//
//  Created by ThanhNV on 2/7/17.
//  Copyright © 2017 thanhnv. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        var myFrame = self.frame
        myFrame.size.width = 40.0
        myFrame.size.height = 40.0
        self.frame = myFrame
        
        
        self.isOpaque = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
