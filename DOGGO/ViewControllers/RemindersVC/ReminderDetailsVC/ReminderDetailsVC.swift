//
//  ReminderDetailsVC.swift
//  DOGGO
//
//  Created by Lobster on 30.01.23.
//

import UIKit

final class ReminderDetailsVC: UIViewController {
    
    
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
    }
    
    private func registerCell() {
        let nibTextField = UINib(nibName: "\(PrototypeDetailsTableCell.self)", bundle: nil)
        tableView.register(nibTextField, forCellReuseIdentifier: "\(PrototypeDetailsTableCell.self)")
        
        let nibPicker = UINib(nibName: "\(PrototypePickerTableCell.self)", bundle: nil)
        tableView.register(nibPicker, forCellReuseIdentifier: "\(PrototypePickerTableCell.self)")
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
            switch indexPath {
            case [0, 0]: cell?.setupTextField(placeholder: "Title")
            case [0, 1]: cell?.setupTextField(placeholder: "Notes")
            default: print("Some error")
            }
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypePickerTableCell.self)", for: indexPath) as? PrototypePickerTableCell
            cell?.setupNameLabel(indexPath: indexPath)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypePickerTableCell.self)", for: indexPath) as? PrototypePickerTableCell
        switch indexPath {
        case [1, 0]: openDateAlert(style: .date)
        case [1, 1]: openDateAlert(style: .time)
        case [2, 0]: openRepeatOptions()
        default:
            print("Some error")
        }
    }
}

extension ReminderDetailsVC {
    
    private func openDateAlert(style: UIDatePicker.Mode/*, label: UILabel*/) {
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        let nowDate = Date()
        datePicker.datePickerMode = style
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = nowDate
        
        alert.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alert.view.heightAnchor.constraint(equalToConstant: 300.0),
            
            datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 160.0),
            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20.0)
        ])
        let okayButton = UIAlertAction(title: "OK", style: .default) { _ in
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd.MM.yyyy"
//            let dateString = dateFormatter.string(from: datePicker.date)
//            label.text = dateString
        }
        alert.addAction(okayButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelButton)
        
        
        present(alert, animated: true)
    }
    
    private func openRepeatOptions() {
        let repeatOptionVC = RepeatOptionVC(nibName: "\(RepeatOptionVC.self)", bundle: nil)
        present(repeatOptionVC, animated: true)
    }
    
}
