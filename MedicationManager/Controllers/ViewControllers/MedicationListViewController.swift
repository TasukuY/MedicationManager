//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/18/22.
//

import UIKit

class MedicationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        MedicationController.shared.fetchMedications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func addButtonTapped(_ sender: Any) {}
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "toMedicationDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? MedicationDetailViewController else { return }
            let medicationToSend = MedicationController.shared.medications[indexPath.row]
            destination.medication = medicationToSend
        }else if segue.identifier == "toNewMedication" {
            
        }
        
    }

}//End of class

extension MedicationListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MedicationController.shared.medications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicineTableViewCell else { return UITableViewCell()}
        
        let medication = MedicationController.shared.medications[indexPath.row]
        
        cell.configure(with: medication)
        
        return cell
    }

}

extension MedicationListViewController: UITableViewDelegate{}
