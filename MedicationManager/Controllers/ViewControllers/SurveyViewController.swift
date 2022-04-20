//
//  SurveyViewController.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/19/22.
//

import UIKit

protocol SurveyVCDelegate: AnyObject{
    func moodButtonTapped(with emoji: String)
}

class SurveyViewController: UIViewController {

    //MARK: - Properties
    weak var delegate: SurveyVCDelegate?
    
    //MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func emojiTapped(_ sender: UIButton) {
        
        guard let emoji = sender.titleLabel?.text else { return }
        delegate?.moodButtonTapped(with: emoji)
        dismiss(animated: true, completion: nil)
    }

}//End of class
