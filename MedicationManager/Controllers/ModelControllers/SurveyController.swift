//
//  SurveyController.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/19/22.
//

import Foundation
import CoreData

class SurveyController {
    //MARK: - Properties
    static let shared = SurveyController()
    var todayMoodSurvey: MoodSurvey?
    private init() {}
    private lazy var fetchRequest: NSFetchRequest<MoodSurvey> = {
        let request = NSFetchRequest<MoodSurvey>(entityName: "MoodSurvey")
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let endOfToday = Calendar.current.date(byAdding: .day, value: 1, to: startOfToday) ?? Date()
        let afterPredicate = NSPredicate(format: "date > %@", startOfToday as NSDate)
        let beforePredicate = NSPredicate(format: "date < %@", endOfToday as NSDate)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [afterPredicate, beforePredicate])
        return request
    }()
    
    //MARK: - CRUD funcs
    private func createMoodSurvey(mentalState: String){
        let moodSurvey = MoodSurvey(mentalState: mentalState, date: Date())
        todayMoodSurvey = moodSurvey
        CoreDataStack.saveContext()
    }
    
    func fetchTodaySurvey() -> MoodSurvey?{
        guard let todayMoodSurvey = try? CoreDataStack.context.fetch(fetchRequest).first else { return nil}
        self.todayMoodSurvey = todayMoodSurvey
        return todayMoodSurvey
    }
    
    private func update(newMentalState: String){
        guard let todayMoodSurvey = todayMoodSurvey else { return }
        todayMoodSurvey.mentalState = newMentalState
        CoreDataStack.saveContext()
    }
    
    func didTapMoodEmoji(emoji: String){
        if todayMoodSurvey != nil {
            update(newMentalState: emoji)
        }else{
            createMoodSurvey(mentalState: emoji)
        }
    }
    
}//End of class
