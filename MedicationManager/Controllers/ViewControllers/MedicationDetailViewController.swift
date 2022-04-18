//
//  MedicationDetailViewController.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/18/22.
//

import UIKit

class MedicationDetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var medication: Medication?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    //MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
              !name.isEmpty else { return }
        let timeOfDaty = datePicker.date
        if let medication = medication {
            MedicationController.shared.updateMedication(medication: medication, name: name, timeOfDay: timeOfDaty)
        }else{
            MedicationController.shared.createMedication(with: name, and: timeOfDaty)
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    func updateView(){
        if let medication = medication,
           let timeOfDay = medication.timeOfDay{
            title = "Medication Details"
            nameTextField.text = medication.name
            datePicker.date = timeOfDay
        }else{
            title = "Add Medication"
        }
    }
    

}//End of class
