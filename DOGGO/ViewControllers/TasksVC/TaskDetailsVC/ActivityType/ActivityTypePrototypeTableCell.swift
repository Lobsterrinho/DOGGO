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
        case [0, 0]: activityImage.image = UIImage(named: "food"); activityLabel.text = "food"
        case [0, 1]: activityImage.image = UIImage(named: "beauty"); activityLabel.text = "beauty"
        case [0, 2]: activityImage.image = UIImage(named: "pill"); activityLabel.text = "pill"
        case [0, 3]: activityImage.image = UIImage(named: "play"); activityLabel.text = "play"
        case [0, 4]: activityImage.image = UIImage(named: "walk"); activityLabel.text = "walk"
        case [0, 5]: activityImage.image = UIImage(named: "wash"); activityLabel.text = "wash"
        default: print("Some error")
        }
    }
    
}
