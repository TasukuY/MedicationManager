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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reminderFiered),
                                               name: NSNotification.Name(rawValue: Strings.MedicationReminderReceived),
                                               object: nil)
        
    }
    
    //MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func emojiTapped(_ sender: UIButton) {
        
        guard let emoji = sender.titleLabel?.text else { return }
        delegate?.moodButtonTapped(with: emoji)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    @objc private func reminderFiered(){
        view.backgroundColor = .systemRed
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.view.backgroundColor = .systemCyan
        }
    }

}//End of class
