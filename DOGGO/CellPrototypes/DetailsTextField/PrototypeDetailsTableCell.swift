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
            saveOptions()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        saveOptions()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        saveOptions()
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
        saveOptions()
        return true
    }
    
    func setTextField(textString: String?) {
        textField.text = textString
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        saveOptions()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text ?? "**Empty**")
        isEmpty()
        saveOptions()
    }
    
    
    
}
