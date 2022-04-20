//
//  MoodSurvey+Convinience.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/19/22.
//

import Foundation
import CoreData

extension MoodSurvey {
    @discardableResult convenience init(mentalState: String, date: Date, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.mentalState = mentalState
        self.date = date
    }
}
