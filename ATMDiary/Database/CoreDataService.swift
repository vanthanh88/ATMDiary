//
//  CoreDataService.swift
//  UlaaiApp
//
//  Created by Ulaai on 11/9/15.
//  Copyright © 2015 Ulaai. All rights reserved.
//

import UIKit
import CoreData

class CoreDataService: NSObject {
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let url = Bundle.main.url(forResource: "ATMData", withExtension: "momd")! as NSURL
        var mom = NSManagedObjectModel(contentsOf: url as URL)
        return mom!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        var persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let storeUrl = Utilities.documentsDirectory() + "/ATMData.sql"
        do{
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: NSURL(fileURLWithPath: storeUrl) as URL, options: nil)
        }
        catch let error as NSError {
            print("error \(error)")
            abort()
        }
        
        return persistentStoreCoordinator
    }()
    
    static let sharedInstance = CoreDataService()
    
    override init(){
        super.init()
    }
    
    
    func prepareCoreDataForUlaai() throws -> Bool {
        let result = true
        
        
        //do import data from json here
        
        return result
    }
    
    

}
