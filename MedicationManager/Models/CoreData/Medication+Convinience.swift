//
//  Medication+Convinience.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/18/22.
//

import Foundation
import CoreData

extension Medication {
    @discardableResult convenience init(name: String, timeOfDay: Date, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.name = name
        self.timeOfDay = timeOfDay
    }
    
}
