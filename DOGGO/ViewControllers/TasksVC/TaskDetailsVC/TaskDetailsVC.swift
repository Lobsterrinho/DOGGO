//
//  CreateTaskVC.swift
//  DOGGO
//
//  Created by Lobster on 22.01.23.
//

import Foundation
import UIKit

final class TaskDetailsVC: UIViewController {
    
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItem()
        registerCell()
        
    }
    
    var inEditMode: Bool = false
    
    var taskForUpdate = ToDoTask()
    
    private var isDelegateWorked = false
    
    private var toDoTask = ToDoTaskModel(title: "New task", date: Date(), taskType: "paw", id: UUID(), status: false)
    
}

extension TaskDetailsVC {
    
    private func setupBarItem() {
        navigationItem.title = "Details"
        let doneButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveDidTap))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func saveDidTap() {
        if inEditMode == false {
            saveData(task: toDoTask)
            navigationController?.popViewController(animated: true)
        } else {
            updateData(task: toDoTask)
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func registerCell() {
        let nibTextField = UINib(nibName: "\(PrototypeDetailsTableCell.self)", bundle: nil)
        tableView.register(nibTextField, forCellReuseIdentifier: "\(PrototypeDetailsTableCell.self)")
        
        let nibPicker = UINib(nibName: "\(PrototypePickerTableCell.self)", bundle: nil)
        tableView.register(nibPicker, forCellReuseIdentifier: "\(PrototypePickerTableCell.self)")
    }
    
}

extension TaskDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypeDetailsTableCell.self)", for: indexPath) as? PrototypeDetailsTableCell
            cell?.setupTextFieldPlaceHolder(indexPath: indexPath)
            if inEditMode == false {
                cell?.delegateTitle = self
            } else {
                cell?.delegateTitle = self
                cell?.setTitleField(title: taskForUpdate.title!)
            }
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypePickerTableCell.self)", for: indexPath) as? PrototypePickerTableCell
            cell?.setupNameLabel(indexPath: indexPath, title1: "Date", title2: nil, title3: "Activity type")
            if inEditMode == false {
                switch indexPath {
                case [1, 0]: cell?.optionValueLabel.text = dateFormatIntoString(date: toDoTask.date)
                case [2, 0] where toDoTask.taskType == "paw": cell?.optionValueLabel.isHidden = true
                case [2, 0]: cell?.optionValueLabel.text = toDoTask.taskType
                default: print("Some error")
                }
            } else {
                switch indexPath {
                case [1, 0]:
                    cell?.optionValueLabel.text = dateFormatIntoString(date: taskForUpdate.date!);
                    toDoTask.date = taskForUpdate.date!
                case [2, 0]: cell?.optionValueLabel.text = taskForUpdate.taskType
                    if isDelegateWorked == false {
                        toDoTask.taskType = taskForUpdate.taskType!
                    } else {
                        cell?.optionValueLabel.text = toDoTask.taskType
                    }
                    
                    
                default: print("Some error")
                }
            }
            return cell ?? UITableViewCell()
        }
    }
}

extension TaskDetailsVC: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return 55
        default: return 55
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? PrototypePickerTableCell
        switch indexPath {
        case [1, 0]: openDateAlert(style: .date, label: cell?.optionValueLabel ?? UILabel())
        case [2, 0]: openActivityTypes()
        default: print("Some error")
        }
    }
}

extension TaskDetailsVC {
    
    private func dateFormatIntoString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    private func saveData(task: ToDoTaskModel) {
        let context = TasksCoreDataService.context
        context.perform {
            let newTask = ToDoTask(context: context)
            newTask.title = task.title
            newTask.date = task.date
            newTask.taskType = task.taskType
            newTask.id = task.id
            newTask.status = task.status
            TasksCoreDataService.saveContext()
        }
    }
    
    private func updateData(task: ToDoTaskModel) {
        let context = TasksCoreDataService.context
        context.perform { [self] in
            taskForUpdate.title = task.title
            taskForUpdate.date = task.date
            taskForUpdate.taskType = task.taskType
            taskForUpdate.status = task.status
            TasksCoreDataService.saveContext()
        }
    }
    
    
    private func openActivityTypes() {
        let activityTypeVC = ActivityTypeVC(nibName: "\(ActivityTypeVC.self)", bundle: nil)
        activityTypeVC.delegate = self
        present(activityTypeVC, animated: true)
    }
    
    private func openDateAlert(style: UIDatePicker.Mode, label: UILabel) {
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = style
        datePicker.preferredDatePickerStyle = .wheels
        
        alert.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alert.view.heightAnchor.constraint(equalToConstant: 300.0),
            
            datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 160.0),
            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20.0)
        ])
        let okayButton = UIAlertAction(title: "OK", style: .default) { _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: datePicker.date)
            label.text = dateString
            self.toDoTask.date = datePicker.date
        }
        alert.addAction(okayButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
}

extension TaskDetailsVC: PrototypeDetailsTableCellTitleDelegate {
    
    func saveTitle(title: String) {
        toDoTask.title = title
    }
}

extension TaskDetailsVC: ActivityTypeDelegate {
    
    func saveImageAndTitle(imageNameAndTitle: String) {
        toDoTask.taskType = imageNameAndTitle
        isDelegateWorked = true
        tableView.reloadRows(at: [[2, 0]], with: .automatic)
    }
}

