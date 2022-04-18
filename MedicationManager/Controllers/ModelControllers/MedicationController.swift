//
//  MedicationController.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/18/22.
//

import Foundation
import CoreData

class MedicationController {
    
    //MARK: - Properties
    static let shared = MedicationController()
    private init() {}
    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    var medications: [Medication] = []
    
    //MARK: - CRUD funcs
    func createMedication(with name: String, and timeOfday: Date){
        let medication = Medication(name: name, timeOfDay: timeOfday)
        medications.append(medication)
        CoreDataStack.saveContext()
    }
    
    func fetchMedications(){
        let medications = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        print(medications.count)
        self.medications = medications
    }
    
    func updateMedication(medication: Medication, name: String, timeOfDay: Date){
        medication.name = name
        medication.timeOfDay = timeOfDay
        CoreDataStack.saveContext()
    }
    
    func deleteMedication(){}
    
}//End of class
