//
//  ReminderVC.swift
//  DOGGO
//
//  Created by Lobster on 13.01.23.
//

import Foundation
import UIKit

final class RemindersVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    private var remindersList = [Reminder]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    
    
}

extension RemindersVC {
    
    func setNavigationItem() {
        navigationItem.title = "Reminders"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDidTap))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addDidTap() {
        let reminderDetailsVC = ReminderDetailsVC(nibName: "\(ReminderDetailsVC.self)", bundle: nil)
        navigationController?.pushViewController(reminderDetailsVC, animated: true)
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "\(PrototypeCellReminders.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(PrototypeCellReminders.self)")
    }
    
    private func loadData() {
        let request = Reminder.fetchRequest()
        let fetchedData = try? RemindersCoreData.context.fetch(request)
        print(fetchedData)
        remindersList = fetchedData ?? []
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
    
    extension RemindersVC: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return remindersList.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypeCellReminders.self)", for: indexPath) as? PrototypeCellReminders
            let reminder = remindersList[indexPath.row]
            var stringDate = String()
            var stringTime = String()
            var repeatOption = String()
            if let date = reminder.date {
                stringFromDate(dateType: date, reminder: reminder) { date in
                    stringDate = date
                }
            }
            if let time = reminder.time {
                stringFromDate(dateType: time, reminder: reminder) { time in
                    stringTime = time
                }
            }
            if let repeatOptionNonOpt = reminder.repeatOption {
                repeatOption = repeatOptionNonOpt
            }
            cell?.reminderTitleLable.text = reminder.title
            cell?.dateTimeAndRepeatLable.text = "\(stringDate), \(stringTime), \(repeatOption)"
            return cell ?? UITableViewCell()
        }
        
        
        
    }
