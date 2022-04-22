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
    let notificationScheduler = NotificationScheduler()
    
    private init() {}
    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    var sections: [[Medication]] { [notTakenMeds, takenMeds] }
    private var notTakenMeds: [Medication] = []
    private var takenMeds: [Medication] = []
    
    //MARK: - CRUD funcs
    func createMedication(with name: String, and timeOfday: Date){
        let medication = Medication(name: name, timeOfDay: timeOfday)
        notTakenMeds.append(medication)
        CoreDataStack.saveContext()
        //Schedule notification
        notificationScheduler.scheduleNotification(for: medication)
    }
    
    func fetchMedications(){
        let medications = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        takenMeds = medications.filter{ $0.wasTakenToday() }
        notTakenMeds = medications.filter{ !$0.wasTakenToday() }
    }
    
    func updateMedication(medication: Medication, name: String, timeOfDay: Date){
        medication.name = name
        medication.timeOfDay = timeOfDay
        CoreDataStack.saveContext()
        notificationScheduler.cancelNotification(for: medication)
        notificationScheduler.scheduleNotification(for: medication)
    }
    
    func markMedicationTaken(medication: Medication, wasTaken: Bool){
        if wasTaken {
            TakenDate(date: Date(), medication: medication)
            if let index = notTakenMeds.firstIndex(of: medication) {
                notTakenMeds.remove(at: index)
                takenMeds.append(medication)
            }
        }else{
            let mutableTakenDates = medication.mutableSetValue(forKey: "takenDates")
            if let takenDate = (mutableTakenDates as? Set<TakenDate>)?.first(where: { takenDate in
                guard let date = takenDate.date else { return false }
                
                return Calendar.current.isDate(date, inSameDayAs: Date())
            }) {
                mutableTakenDates.remove(takenDate)
                if let index = takenMeds.firstIndex(of: medication) {
                    takenMeds.remove(at: index)
                    notTakenMeds.append(medication)
                }
            }
        }
        CoreDataStack.saveContext()
    }
    
    func markMedicationTaken(with id: String) {
        guard let medication = notTakenMeds.first(where: { $0.id == id })
        else { return }
        
        markMedicationTaken(medication: medication, wasTaken: true)
    }
    
    func deleteMedication(_ medication: Medication){
        if let index = notTakenMeds.firstIndex(of: medication){
            notTakenMeds.remove(at: index)
        }else if let index = takenMeds.firstIndex(of: medication){
            takenMeds.remove(at: index)
        }
        CoreDataStack.context.delete(medication)
        CoreDataStack.saveContext()
        notificationScheduler.cancelNotification(for: medication)
    }
    
}//End of class
