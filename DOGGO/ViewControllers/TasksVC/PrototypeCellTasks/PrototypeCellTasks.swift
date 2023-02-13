//
//  PrototypeCellTasks.swift
//  DOGGO
//
//  Created by Lobster on 14.01.23.
//

import Foundation
import UIKit

protocol PrototypeCellTasksDelegate {
    func currentColor(color: UIColor)
}

final class PrototypeCellTasks: UITableViewCell {
    
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var imageOfTask: UIImageView!
    @IBOutlet private weak var statusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setButton()
        setupCell()
//        checkForStatus()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        checkForStatus()
    }
    
    var taskForUpdate = ToDoTask()
    var index = IndexPath()
    private var status = Bool()
    
}

extension PrototypeCellTasks {
    
    private func setupCell() {
        backgroundColor = .cellsColor
    }
    
    func setup(title: String, image: String) {
        titleLable.text = title
        imageOfTask.image = UIImage(named: image)
    }
    
    private func setButton() {
//        statusButton.backgroundColor = .clear
        statusButton.layer.borderColor = UIColor.orange.cgColor
        statusButton.layer.borderWidth = 2.0
        statusButton.layer.cornerRadius = statusButton.bounds.height / 2
//        statusButton.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
    }
    
//    @objc private func changeColor() {
//        if status == false {
//            statusButton.backgroundColor = .orange
//            print("\n\n\n\n\n\(index)\n\n\n\n")
//            updateStatus(statusMark: false)
//        } else {
//            statusButton.backgroundColor = .orange
//            updateStatus(statusMark: true)
//            print("\n\n\n\n\n\(index)\n\n\n\n")
//        }
//
//    }
//
//    private func updateStatus(statusMark: Bool) {
//        let context = TasksCoreDataService.context
//        context.perform { [self] in
//            switch statusMark {
//            case statusMark == true:
//                taskForUpdate.status = true
//                TasksCoreDataService.saveContext()
//            case statusMark == false:
//                taskForUpdate.status = false
//                TasksCoreDataService.saveContext()
//            default: break
//            }
//        }
//    }
//
//    func checkForStatus() {
//        status = taskForUpdate.status
//        if status == false {
//            statusButton.backgroundColor = .clear
//        } else {
//            statusButton.backgroundColor = .orange
//        }
//        print("\n\n\n\nThe status of task is: \(status)\n\n\n\n")
//    }
    
}
