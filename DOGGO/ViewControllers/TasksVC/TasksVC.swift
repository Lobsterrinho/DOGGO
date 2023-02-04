//
//  ToDoListVC.swift
//  DOGGO
//
//  Created by Lobster on 13.01.23.
//

import Foundation
import UIKit

final class TasksVC: UIViewController {
    
    @IBOutlet private weak var monthLabel: UILabel!
    
    
    @IBOutlet private weak var calendarCollectionView: UICollectionView!
    
    @IBOutlet private weak var tasksTableView: UITableView! {
        didSet {
            tasksTableView.dataSource = self
        }
    }
    
    var label: String = "" {
        didSet {
            tasksTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBarItem()
        
//        registrateCollectionCell()
        registerTableCell()
        
        
    }
    
}

// MARK: - UITableViewDataSource

extension TasksVC: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypeCellTasks.self)", for: indexPath) as? PrototypeCellTasks
        cell?.setup(title: label)
        
        return cell ?? UITableViewCell()
    }
    
//MARK: - simple extension for TasksVC
    
}

extension TasksVC {
    
    private func setupBarItem() {
        navigationItem.title = "Tasks"
        let addButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addDidTap))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addDidTap() {
        let taskDetailsVC = TaskDetailsVC(nibName: "\(TaskDetailsVC.self)", bundle: nil)
        navigationController?.pushViewController(taskDetailsVC, animated: true)
    }
    
    private func registerTableCell() {
        let nib = UINib(nibName: "\(PrototypeCellTasks.self)", bundle: nil)
        tasksTableView.register(nib, forCellReuseIdentifier: "\(PrototypeCellTasks.self)")
    }
    
    private func registrateCollectionCell() {
        let nib = UINib(nibName: "\(PrototypeCalendarCollectionCell.self)", bundle: nil)
        calendarCollectionView.register(nib, forCellWithReuseIdentifier: "\(PrototypeCalendarCollectionCell.self)")
    }
    
    @IBAction private func nextMonth() {
    }
    @IBAction private func previousMonth() {
    }
    
}
