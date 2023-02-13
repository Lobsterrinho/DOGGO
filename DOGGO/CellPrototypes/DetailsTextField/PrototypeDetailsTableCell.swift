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
        super .awakeFromNib()
        backgroundColor = .cellsColor
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
    
    private func isEmpty() {
        if !textField.hasText {
            contentView.backgroundColor = UIColor.init(red: 255.0 / 255.0, green: 150.0 / 255.0, blue: 171.0 / 255.0, alpha: 0.2)
        } else {
            contentView.backgroundColor = UIColor.clear
        }
    }
    
    private func saveOptions() {
        if textField.placeholder == "Title" {
            if let savedText = textField.text, !savedText.isEmpty {
                delegateTitle?.saveTitle(title: savedText)
            }
        } else if textField.placeholder == "Body" {
            if let savedText = textField.text, !savedText.isEmpty {
                delegateBody?.saveBody(body: savedText)
            }
        }
    }
    
}

extension PrototypeDetailsTableCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        saveOptions()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        isEmpty()
        saveOptions()
    }
    
    func setTitleField(title: String) {
        textField.text = title
        delegateTitle?.saveTitle(title: title)
    }
    
    func setBodyField(body: String) {
        textField.text = body
        delegateBody?.saveBody(body: body)
    }
    
    
    
}
