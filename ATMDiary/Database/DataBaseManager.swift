//
//  DataBaseManager.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/9/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import UIKit
import CoreData

class DataBaseManager: NSObject {
    
    var coreDataContext: NSManagedObjectContext
    
    init(managedObjectContext context: NSManagedObjectContext) {
        self.coreDataContext = context
    }
    
    func saveData() throws -> Bool {
        if ((self.coreDataContext.hasChanges) == true) {
            do {
                try self.coreDataContext.save()
            }catch {
                self.coreDataContext.rollback()
                return false
            }
        }
        return true
    }

}
