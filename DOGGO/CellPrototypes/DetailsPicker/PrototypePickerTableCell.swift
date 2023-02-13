//
//  PrototypePickerTableCell.swift
//  DOGGO
//
//  Created by Lobster on 31.01.23.
//

import UIKit

class PrototypePickerTableCell: UITableViewCell {
    
    @IBOutlet private weak var optionNameLable: UILabel!
    @IBOutlet weak var optionValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .cellsColor
        optionValueLabel.text = nil
    }
    
    func setupNameLabel(indexPath: IndexPath, title1: String?, title2: String?, title3: String) {
        switch indexPath {
        case [1, 0]: optionNameLable.text = title1
        case [1, 1]: optionNameLable.text = title2
        case [2, 0]: optionNameLable.text = title3
        default: print("Some error")
        }
    }
    
    
}

