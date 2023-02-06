//
//  PrototypeDetailsTableCell.swift
//  DOGGO
//
//  Created by Lobster on 30.01.23.
//

import UIKit

protocol PrototypeDetailsTableCellTitleDelegate {
    func saveTitle(title: String)
}

protocol PrototypeDetailsTableCellBodyDelegate {
    func saveBody(body: String)
}

final class PrototypeDetailsTableCell: UITableViewCell {
    
    var delegateTitle: PrototypeDetailsTableCellTitleDelegate?
    var delegateBody: PrototypeDetailsTableCellBodyDelegate?
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension PrototypeDetailsTableCell {
    func setupTextFieldPlaceHolder(indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]: textField.placeholder = "Title"
        case [0, 1]: textField.placeholder = "Body"
        default: print("some error")
        }
    }
    
}

extension PrototypeDetailsTableCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.placeholder == "Title" {
            if let savedText = textField.text, !savedText.isEmpty {
                delegateTitle?.saveTitle(title: savedText)
                print(savedText)
            }
        } else if textField.placeholder == "Body" {
            if let savedText = textField.text, !savedText.isEmpty {
                delegateBody?.saveBody(body: savedText)
                print(savedText)
            }
        }
        
    }
    
    
    
}
