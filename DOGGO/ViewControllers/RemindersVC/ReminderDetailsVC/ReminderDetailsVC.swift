//
//  ReminderDetailsVC.swift
//  DOGGO
//
//  Created by Lobster on 30.01.23.
//

import UIKit

final class ReminderDetailsVC: UIViewController {
    
    var reminderCoreData = Reminder()
    var isEdit: Bool = false
    private var reminder = ReminderModel()
    
    private var VC = RemindersVC()
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        registerCell()
    }
    
    
    
}

extension ReminderDetailsVC {
    
    func setNavigationItem() {
        navigationItem.title = "Deteils"
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveDidTap))
        
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func saveDidTap() {
        saveData(reminder: reminder)
        navigationController?.popViewController(animated: true)
    }
    
    private func registerCell() {
        let nibTextField = UINib(nibName: "\(PrototypeDetailsTableCell.self)", bundle: nil)
        tableView.register(nibTextField, forCellReuseIdentifier: "\(PrototypeDetailsTableCell.self)")
        
        let nibPicker = UINib(nibName: "\(PrototypePickerTableCell.self)", bundle: nil)
        tableView.register(nibPicker, forCellReuseIdentifier: "\(PrototypePickerTableCell.self)")
    }
    
    private func saveData(reminder: ReminderModel) {
        
        
        let context = RemindersCoreData.context
        context.perform { [self] in
            
            if self.isEdit == false {
                let newReminder = Reminder(context: context)
                
                newReminder.id = UUID()
                newReminder.title = reminder.title
                newReminder.body = reminder.body
                newReminder.date = reminder.date
                newReminder.time = reminder.time
                newReminder.repeatOption = reminder.repeatOption
                RemindersCoreData.saveContext()
            } else {
                reminderCoreData.title = reminder.title
                reminderCoreData.body = reminder.body
                reminderCoreData.date = reminder.date
                reminderCoreData.time = reminder.time
                reminderCoreData.repeatOption = reminder.repeatOption
                RemindersCoreData.saveContext()
            }
        }
    }
    
    private func openDateAlert(style: UIDatePicker.Mode, label: UILabel, completion: @escaping (Date) -> Void) {
        
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
            if datePicker.datePickerMode == .date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                let dateString = dateFormatter.string(from: datePicker.date)
                let date = datePicker.date
                label.text = dateString
                completion(date)
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "kk:mm"
                let dateString = dateFormatter.string(from: datePicker.date)
                let time = datePicker.date
                label.text = dateString
                completion(time)
            }
        }
        alert.addAction(okayButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelButton)
        
        
        present(alert, animated: true)
    }
    
    private func openRepeatOptions() {
        let repeatOptionVC = RepeatOptionVC(nibName: "\(RepeatOptionVC.self)", bundle: nil)
        repeatOptionVC.delegate = self
        present(repeatOptionVC, animated: true)
    }
    
    private func stringFromDate(dateType: Date, reminder: Reminder, completion: @escaping (String) -> Void) {
        if dateType == reminder.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: dateType)
            completion(dateString)
        } else if dateType == reminder.time {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "kk:mm"
            let timeString = dateFormatter.string(from: dateType)
            completion(timeString)
        }
    }
    
}

extension ReminderDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 2
        case 2: return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypeDetailsTableCell.self)", for: indexPath) as? PrototypeDetailsTableCell
            if isEdit {
                cell?.setupTextFieldPlaceHolder(indexPath: indexPath)
                cell?.delegateTitle = self
                cell?.delegateBody = self
                switch indexPath {
                case [0, 0]: cell?.textField.text = reminderCoreData.title
                case [0, 1]: cell?.textField.text = reminderCoreData.body
                default: print("Some error")
                }
            } else {
                cell?.setupTextFieldPlaceHolder(indexPath: indexPath)
                cell?.delegateTitle = self
                cell?.delegateBody = self
            }
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypePickerTableCell.self)", for: indexPath) as? PrototypePickerTableCell
            
            if isEdit {
                cell?.setupNameLabel(indexPath: indexPath)
                if indexPath == [2, 0] {
                    cell?.optionValueLabel.text = reminder.repeatOption
                }
                switch indexPath {
                case [1, 0]: VC.stringFromDate(dateType: reminderCoreData.date ?? Date(), reminder: reminderCoreData, completion: { date in
                    cell?.optionValueLabel.text = date
                })
                case [1, 1]: VC.stringFromDate(dateType: reminderCoreData.time ?? Date(), reminder: reminderCoreData, completion: { time in
                    cell?.optionValueLabel.text = time
                })
                case [2, 0]: cell?.optionValueLabel.text = reminderCoreData.repeatOption
                default: print("Some error")
                }
            } else {
                cell?.setupNameLabel(indexPath: indexPath)
                if indexPath == [2, 0] {
                    cell?.optionValueLabel.text = reminder.repeatOption
                }
            }
            return cell ?? UITableViewCell()
        }
    }
    
    
    
}

extension ReminderDetailsVC: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return 55
        case 2: return 55
        default: return 55
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? PrototypePickerTableCell
        switch indexPath {
        case [1, 0]: openDateAlert(style: .date, label: cell?.optionValueLabel ?? UILabel()) { date in
            self.reminder.date = date
        }
        case [1, 1]: openDateAlert(style: .time, label: cell?.optionValueLabel ?? UILabel()) { time in
            self.reminder.time = time
        }
        case [2, 0]: openRepeatOptions();
        default:
            print("Some error")
        }
    }
}

extension ReminderDetailsVC: RepeatOptionVCDelegate {
    
    func repeatOptionDidSelect(option: String) {
        reminder.repeatOption = option
        tableView.reloadRows(at: [[2, 0]], with: .none)
    }
}

extension ReminderDetailsVC: PrototypeDetailsTableCellTitleDelegate {
    
    func saveTitle(title: String) {
        reminder.title = title
    }
}

extension ReminderDetailsVC: PrototypeDetailsTableCellBodyDelegate {
    
    func saveBody(body: String) {
        reminder.body = body
    }
}
