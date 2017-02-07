//
//  ATMEntity+CoreDataProperties.swift
//  ATMDiary
//
//  Created by  on 2/7/17.
//  Copyright © 2017 thanhnv. All rights reserved.
//

import Foundation
import CoreData


extension ATMEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ATMEntity> {
        return NSFetchRequest<ATMEntity>(entityName: "ATMEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var lat: Double
    @NSManaged public var long: Double

}
