//
//  PrototypeCellTasks.swift
//  DOGGO
//
//  Created by Lobster on 14.01.23.
//

import Foundation
import UIKit

final class PrototypeCellTasks: UITableViewCell {
    
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var imageOfTask: UIImageView!
    @IBOutlet private weak var statusButton: UIButton! {
        didSet {
            statusButton.addTarget(self, action: #selector(changeColor(_:)), for: .touchUpInside)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setButton()
    }
    
}

extension PrototypeCellTasks {
    
    func setup(title: String) {
        titleLable.text = title
        imageOfTask.image = UIImage(named: "food2")
    }
    
    private func setButton() {
        statusButton.backgroundColor = .clear
        statusButton.layer.borderColor = UIColor.orange.cgColor
        statusButton.layer.borderWidth = 2.0
        statusButton.layer.cornerRadius = statusButton.bounds.height / 2
    }
    
    @objc private func changeColor(_ sender: UIButton) {
        if sender.backgroundColor == .clear {
            sender.backgroundColor = .orange
        } else {
            sender.backgroundColor = .clear
        }
       
    }
    
}
