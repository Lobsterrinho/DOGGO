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
    
    func setupNameLabel(indexPath: IndexPath) {
        switch indexPath {
        case [1, 0]: optionNameLable.text = "Date"
        case [1, 1]: optionNameLable.text = "Time"
        case [2, 0]: optionNameLable.text = "Repeat"
        default: return
        }
    }
    
//    func setOptionValue(value: String) {
//
//    }
    
}

