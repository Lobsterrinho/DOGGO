//
//  PrototypeOptionsTableCell.swift
//  DOGGO
//
//  Created by Lobster on 1.02.23.
//

import UIKit

final class PrototypeOptionsTableCell: UITableViewCell {
    
    @IBOutlet weak var optionNameLabel: UILabel!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .cellsColor
    }
}

extension PrototypeOptionsTableCell {
    
    func setupLabels(indexPath: IndexPath) {
        optionNameLabel.text = nameOptionArray[indexPath.row]
    }
}
