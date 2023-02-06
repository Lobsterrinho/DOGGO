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
    
    
    
}

extension TaskDetailsVC {
    
    private func setupBarItem() {
        navigationItem.title = "Details"
        let doneButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveDidTap))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func saveDidTap() {
        
        navigationController?.popViewController(animated: true)
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
        case 0: return 2
        case 1: return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypeDetailsTableCell.self)", for: indexPath) as? PrototypeDetailsTableCell
            cell?.setupTextFieldPlaceHolder(indexPath: indexPath)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypePickerTableCell.self)", for: indexPath) as? PrototypePickerTableCell
            cell?.setupNameLabel(indexPath: indexPath)
            return cell ?? UITableViewCell()
        }
    }
}

extension TaskDetailsVC: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        case [1, 1]: openDateAlert(style: .time, label: cell?.optionValueLabel ?? UILabel())
        default: print("Some error")
        }
    }
}

extension TaskDetailsVC {
    
    private func openDateAlert(style: UIDatePicker.Mode, label: UILabel) {
        
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
            if datePicker.datePickerMode == .date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                let dateString = dateFormatter.string(from: datePicker.date)
                label.text = dateString
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "kk:mm"
                let dateString = dateFormatter.string(from: datePicker.date)
                label.text = dateString
            }
        }
        alert.addAction(okayButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelButton)
        
        
        present(alert, animated: true)
    }
}
