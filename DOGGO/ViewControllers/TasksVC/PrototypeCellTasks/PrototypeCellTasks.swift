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
    
}

extension PrototypeCellTasks {
    
    func setup(title: String) {
        titleLable.text = title
        imageOfTask.image = UIImage(named: "hamster")
    }
    
}
