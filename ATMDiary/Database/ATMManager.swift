//
//  ATMManager.swift
//  ATMDiary
//
//  Created by  on 2/7/17.
//  Copyright © 2017 thanhnv. All rights reserved.
//

import UIKit
import CoreData

private let ATMEntityName = "ATMEntity"

class ATMManager: DataBaseManager {
    
    static let sharedInstance = ATMManager()
    
    init() {
        super.init(managedObjectContext: CoreDataService().managedObjectContext)
    }
    
    
    func listOfATM() -> [ATMEntity] {
        let fetchRequest:NSFetchRequest<ATMEntity> = ATMEntity.fetchRequest()
        let entity = NSEntityDescription.entity(forEntityName: ATMEntityName, in: coreDataContext)
        fetchRequest.entity = entity
        let sortDescriptions = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptions]
        var fetchObj: [ATMEntity] = []
        do {
            fetchObj = try coreDataContext.fetch(fetchRequest) as [ATMEntity]
            
        } catch _ {}
        return fetchObj
    }
    
    func newATM() -> ATMEntity {
        let atmEntity = NSEntityDescription.insertNewObject(forEntityName: ATMEntityName, into: coreDataContext) as! ATMEntity
        return atmEntity
    }
}
