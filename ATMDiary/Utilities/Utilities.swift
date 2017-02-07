//
//  Utilities.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/6/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    /**
     get document app folder
     
     - returns: document app folder
     */
    class func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDir = paths.firstObject as! String
        print(documentsDir)
        return documentsDir
    }
}
