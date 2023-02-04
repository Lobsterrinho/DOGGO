//
//  PrototypeDetailsTableCell.swift
//  DOGGO
//
//  Created by Lobster on 30.01.23.
//

import UIKit

final class PrototypeDetailsTableCell: UITableViewCell {
    
    @IBOutlet private weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupTextField(placeholder title: String) {
        textField.placeholder = title
    }
    
}

extension PrototypeDetailsTableCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
