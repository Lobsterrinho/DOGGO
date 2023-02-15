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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkForStatus(status: status)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setButton()
        setupCell()
    }
    
    
    
    
    private var taskForUpdate = ToDoTask()
    private var index = IndexPath()
    private var status = Bool()
    
}

extension PrototypeCellTasks {
    
    private func setupCell() {
        backgroundColor = .cellsColor
    }
    
    func setup(title: String, image: String) {
        titleLable.text = title
        imageOfTask.image = UIImage(named: image)
        if status {
            statusButton.backgroundColor = .orange
        } else {
            statusButton.backgroundColor = .clear
        }
        
    }
    
    private func setButton() {
        statusButton.backgroundColor = .clear
        statusButton.layer.borderColor = UIColor.orange.cgColor
        statusButton.layer.borderWidth = 2.0
        statusButton.layer.cornerRadius = statusButton.bounds.height / 2
        statusButton.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
    }
    
    func setInfoForUpdate(task: ToDoTask, indexPath: IndexPath) {
        taskForUpdate = task
        index = indexPath
        status = task.status
    }
    
    @objc private func changeColor() {
        if status {
            statusButton.backgroundColor = .clear
        } else {
            statusButton.backgroundColor = .orange
        }
        status.toggle()
        updateStatus(statusMark: status)
    }

    private func updateStatus(statusMark: Bool) {
        let context = TasksCoreDataService.context
        context.perform { [self] in
            taskForUpdate.status = statusMark
            TasksCoreDataService.saveContext()
        }
    }
    
    private func checkForStatus(status: Bool) {
        if !status {
            statusButton.backgroundColor = .clear
        } else {
            statusButton.backgroundColor = .orange
        }
    }
    
}
