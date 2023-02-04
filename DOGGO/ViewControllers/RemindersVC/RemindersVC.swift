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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        registerCell()
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
    
}

extension RemindersVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypeCellReminders.self)", for: indexPath) as? PrototypeCellReminders
        
        return cell ?? UITableViewCell()
    }
    
    
    
}
