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
    @IBOutlet private weak var calendarCollectionView: UICollectionView! {
        didSet {
            calendarCollectionView.delegate = self
            calendarCollectionView.dataSource = self
            calendarCollectionView.collectionViewLayout = createLayout()
        }
    }
    @IBOutlet private weak var tasksTableView: UITableView! {
        didSet {
            tasksTableView.dataSource = self
            tasksTableView.delegate = self
        }
    }
    
    var totalSquares = [Date]()
    var selectedDate = Date()
    
    var label: String = "" {
        didSet {
            tasksTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItem()
        registerTableCell()
    
//        leftSwipeGesture()
//        rightSwipeGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasksTableView.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegate

extension TasksVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        calendarCollectionView.reloadData()
        tasksTableView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource

extension TasksVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: "\(PrototypeCalendarCollectionCell.self)", for: indexPath) as? PrototypeCalendarCollectionCell
        let date = totalSquares[indexPath.item]
        cell?.numbeOfDayLabel.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == selectedDate) {
            cell?.contentView.backgroundColor = UIColor.systemGreen
        } else {
            cell?.contentView.backgroundColor = UIColor.white
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TasksVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2)
        return CGSize(width: width, height: height)
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
}

// MARK: - UITableViewDelegate

extension TasksVC: UITableViewDelegate {
    
    
}

//MARK: - simple extension for TasksVC

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
    
    func setWeekView() {
        totalSquares.removeAll()
        
        var current = CalendarHelper().mondayForDate(date: selectedDate)
        let nextMonday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextMonday) {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        calendarCollectionView.reloadData()
        tasksTableView.reloadData()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            return self.createCalendarSection()
        }
    }
    
    private func createCalendarSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1 / 7), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.98), heightDimension: .fractionalHeight(1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        return section
    }
    
}
