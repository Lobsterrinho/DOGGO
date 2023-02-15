//
//  ActivityTypePrototypeTableCell.swift
//  DOGGO
//
//  Created by Lobster on 11.02.23.
//

import UIKit

final class ActivityTypePrototypeTableCell: UITableViewCell {
    
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .cellsColor
    }
    
}

extension ActivityTypePrototypeTableCell {
    
    func setupCell(indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]: activityImage.image = UIImage(named: "Food"); activityLabel.text = "Food"
        case [0, 1]: activityImage.image = UIImage(named: "Beauty"); activityLabel.text = "Beauty"
        case [0, 2]: activityImage.image = UIImage(named: "Medicine"); activityLabel.text = "Medicine"
        case [0, 3]: activityImage.image = UIImage(named: "Play"); activityLabel.text = "Play"
        case [0, 4]: activityImage.image = UIImage(named: "Walk"); activityLabel.text = "Walk"
        case [0, 5]: activityImage.image = UIImage(named: "Wash"); activityLabel.text = "Wash"
        default: print("Some error")
        }
    }
    
}
