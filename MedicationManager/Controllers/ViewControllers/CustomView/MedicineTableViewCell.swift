//
//  MedicineTableViewCell.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/18/22.
//

import UIKit

class MedicineTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wasTakenButton: UIButton!
    
    //MARK: - IBActions
    @IBAction func wasTakenButtonTapped(_ sender: Any) {
        print("was taken button tapped")
    }
    
    func configure(with medication: Medication){
        nameLabel.text = medication.name
        timeLabel.text = DateFormatter.medicationTime.string(from: medication.timeOfDay ?? Date())
    }
    
}//End of class
