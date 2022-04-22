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
        self.id = UUID().uuidString
        self.name = name
        self.timeOfDay = timeOfDay
    }
    
    func wasTakenToday() -> Bool {
        if (takenDates as? Set<TakenDate>)?.contains(where: { takenDate in
            guard let date = takenDate.date else { return false}
            return Calendar.current.isDate(date, inSameDayAs: Date())
        }) == true{
            return true
        }
        return false
    }
}//End of extension
