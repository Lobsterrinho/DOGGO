//
//  PrototypeOptionsTableCell.swift
//  DOGGO
//
//  Created by Lobster on 1.02.23.
//

import UIKit

final class PrototypeOptionsTableCell: UITableViewCell {
    
    @IBOutlet private weak var optionNameLabel: UILabel!
    
    private let nameOptionArray: [String] = [
        "Never",
        "Daily",
        "Weekdays",
        "Weekends",
        "Weekly",
        "Fortnightly",
        "Monthly",
        "every 3 Month",
        "every 6 Month",
        "Yearly"
    ]
}

extension PrototypeOptionsTableCell {
    
    func setupLabels(indexPath: IndexPath) {
        optionNameLabel.text = nameOptionArray[indexPath.row]
    }
}
