//
//  MedicineTableViewCell.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/18/22.
//

import UIKit

protocol MedicationTableViewCellDelegate: AnyObject{
    func medicationTakenButtonTapped(medication: Medication, wasTaken: Bool)
}

class MedicineTableViewCell: UITableViewCell {
    //MARK: - Properties
    weak var delegate: MedicationTableViewCellDelegate?
    private var medication: Medication?
    private var wasTakenToday: Bool = false
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wasTakenButton: UIButton!
    
    //MARK: - IBActions
    @IBAction func wasTakenButtonTapped(_ sender: Any) {
        guard let medication = medication else { return }
        
        wasTakenToday.toggle()
        delegate?.medicationTakenButtonTapped(medication: medication, wasTaken: wasTakenToday)
    }
    
    func configure(with medication: Medication){
        self.medication = medication
        wasTakenToday = medication.wasTakenToday()
        nameLabel.text = medication.name
        timeLabel.text = DateFormatter.medicationTime.string(from: medication.timeOfDay ?? Date())
        let image = wasTakenToday ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        wasTakenButton.setImage(image, for: .normal)
    }
    
}//End of class
