//
//  ATMAnnotation.swift
//  ATMDiary
//
//  Created by ThanhNV on 2/7/17.
//  Copyright © 2017 thanhnv. All rights reserved.
//

import UIKit
import MapKit

class ATMAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var entity: ATMEntity
    
    init(entity: ATMEntity) {
        self.entity = entity
        coordinate = CLLocationCoordinate2D(latitude: entity.lat, longitude: entity.long)
    }
}
