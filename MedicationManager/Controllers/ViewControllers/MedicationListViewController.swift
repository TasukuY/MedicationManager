//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/18/22.
//

import UIKit

class MedicationListViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moodSurveyButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        MedicationController.shared.fetchMedications()
        guard let survey = SurveyController.shared.fetchTodaySurvey() else { return }
        
        moodSurveyButton.setTitle(survey.mentalState, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func addButtonTapped(_ sender: Any) {}
    
    @IBAction func surveyButtonTapped(_ sender: Any) {
        guard let surveyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "surveryVC") as? SurveyViewController else { return }
        surveyViewController.delegate = self
        navigationController?.present(surveyViewController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "toMedicationDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? MedicationDetailViewController else { return }
            let medicationToSend = MedicationController.shared.sections[indexPath.section][indexPath.row  ]
            destination.medication = medicationToSend
        }else if segue.identifier == "toNewMedication" {}
    }

}//End of class

extension MedicationListViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return MedicationController.shared.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MedicationController.shared.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicineTableViewCell else { return UITableViewCell()}
        cell.delegate = self
        let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
        cell.configure(with: medication)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Not Taken"
        } else if section == 1 {
            return "Taken"
        } else {
            return nil
        }
    }
}

extension MedicationListViewController: UITableViewDelegate{}
extension MedicationListViewController: MedicationTableViewCellDelegate{
    func medicationTakenButtonTapped(medication: Medication, wasTaken: Bool) {
        MedicationController.shared.markMedicationTaken(medication: medication, wasTaken: wasTaken)
        tableView.reloadData()
    }
}

extension MedicationListViewController: SurveyVCDelegate{
    func moodButtonTapped(with emoji: String) {
        SurveyController.shared.didTapMoodEmoji(emoji: emoji)
        moodSurveyButton.setTitle(emoji, for: .normal )
        tableView.reloadData()
    }
}
