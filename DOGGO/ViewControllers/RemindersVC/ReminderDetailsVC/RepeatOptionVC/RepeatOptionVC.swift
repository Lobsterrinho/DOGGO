//
//  RepeatOptionVC.swift
//  DOGGO
//
//  Created by Lobster on 1.02.23.
//

import UIKit

final class RepeatOptionVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        registerCell()
    }
    
}

extension RepeatOptionVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PrototypeOptionsTableCell.self)", for: indexPath) as? PrototypeOptionsTableCell
        cell?.setupLabels(indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
}

extension RepeatOptionVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}

extension RepeatOptionVC {
    
    private func registerCell() {
        let nib = UINib(nibName: "\(PrototypeOptionsTableCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(PrototypeOptionsTableCell.self)")
    }
    
}
