//
//  ToDoListVC.swift
//  DOGGO
//
//  Created by Lobster on 13.01.23.
//

import UIKit
import FSCalendar

final class TasksVC: UIViewController {
    
    @IBOutlet private weak var dateLabel: UILabel! {
        didSet {
            dateLabel.text = dateToStringFromDate(date: Date(), format: "dd   E MMMM yyyy")
        }
    }
    @IBOutlet private weak var calendarView: FSCalendar!
    
    
    @IBOutlet private weak var tasksTableView: UITableView! {
        didSet {
            tasksTableView.dataSource = self
            tasksTableView.delegate = self
        }
    }
    
    private var tasksList = [ToDoTask]() {
        didSet {
            tasksTableView.reloadData()
            print(tasksList)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItem()
        registerTableCell()
        setupCalendarView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasksTableView.reloadData()
        loadData(date: Date())
        calendarView.select(Date())
    }
    
}



// MARK: - UITableViewDataSource

extension TasksVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypeCellTasks.self)", for: indexPath) as? PrototypeCellTasks
        let task = tasksList[indexPath.section]
        print(task)
        cell?.taskForUpdate = task
        cell?.index = [indexPath.section]
        cell?.setup(title: task.title!, image: task.taskType!)
        
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension TasksVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        deleteData(indexPath: indexPath)
        self.tasksList.remove(at: indexPath.section)
        self.tasksTableView.deleteSections([indexPath.item], with: .none)
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let cell = tableView.cellForRow(at: indexPath) as? PrototypeCellTasks
        let task = tasksList[indexPath.section]
        let taskDetailsVC = TaskDetailsVC(nibName: "\(TaskDetailsVC.self)", bundle: nil)
        taskDetailsVC.inEditMode = true
        taskDetailsVC.taskForUpdate = task
        taskDetailsVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(taskDetailsVC, animated: true)
    }
    
}

//MARK: - simple extension for TasksVC

extension TasksVC {
    
    private func deleteData(indexPath: IndexPath) {
        let context = TasksCoreDataService.context
        let task = tasksList[indexPath.section]
        context.perform {
            context.delete(task)
            TasksCoreDataService.saveContext()
        }
    }
    
    
    private func setupBarItem() {
        navigationItem.title = "Tasks"
        let addButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addDidTap))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addDidTap() {
        let taskDetailsVC = TaskDetailsVC(nibName: "\(TaskDetailsVC.self)", bundle: nil)
        taskDetailsVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(taskDetailsVC, animated: true)
    }
    
    private func registerTableCell() {
        let nib = UINib(nibName: "\(PrototypeCellTasks.self)", bundle: nil)
        tasksTableView.register(nib, forCellReuseIdentifier: "\(PrototypeCellTasks.self)")
    }
    
    private func loadData(date: Date) {
        let request = ToDoTask.fetchRequest()
        let startDate = Calendar.current.startOfDay(for: date)
        var components = DateComponents()
               components.day = 1
               components.second = -1
        let endDate = Calendar.current.date(byAdding: components, to: startDate)!
        request.predicate = NSPredicate(format: "\(#keyPath(ToDoTask.date)) >= %@ AND \(#keyPath(ToDoTask.date)) <= %@", startDate as NSDate, endDate as NSDate)
        let sortDescriptor = NSSortDescriptor(key: "\(#keyPath(ToDoTask.date))", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        let fetchedData = try? TasksCoreDataService.context.fetch(request)
        tasksList = fetchedData?.reversed() ?? []
    }
}

extension TasksVC: FSCalendarDelegate & FSCalendarDataSource {
    
    private func setupCalendarView() {
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.select(Date())
        calendarView.scope = .week
        calendarView.appearance.titleTodayColor = .selectedItem
        calendarView.appearance.subtitleTodayColor = .selectedItem
        calendarView.appearance.subtitleDefaultColor = .black
        calendarView.appearance.selectionColor = .selectedItem
        calendarView.appearance.todayColor = .clear
        calendarView.appearance.borderRadius = 0.4
        calendarView.appearance.calendar.weekdayHeight = 0.0
        calendarView.firstWeekday = 2
        calendarView.headerHeight = 0.0
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        calendarView.appearance.subtitleFont = UIFont.boldSystemFont(ofSize: 19.0)
        calendarView.appearance.titleFont = UIFont.boldSystemFont(ofSize: 20.0)
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return dateToStringFromDate(date: date, format: "E")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        loadData(date: date)
        tasksTableView.reloadData()
        dateLabel.text = dateToStringFromDate(date: date, format: "dd   E MMMM yyyy")
    }
    
    
    
    private func dateToStringFromDate(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}


