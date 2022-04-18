//
//  DateFormatter+Extras.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/18/22.
//

import Foundation

extension DateFormatter{
    static let medicationTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
