//
//  TakenDate+Convinience.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/19/22.
//

import Foundation
import CoreData

extension TakenDate {
    convenience init(date: Date, medication: Medication, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.date = date
        self.medication = medication
    }
}
