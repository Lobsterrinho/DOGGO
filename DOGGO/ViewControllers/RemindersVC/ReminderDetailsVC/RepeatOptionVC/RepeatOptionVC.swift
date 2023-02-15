//
//  RepeatOptionVC.swift
//  DOGGO
//
//  Created by Lobster on 1.02.23.
//

import UIKit

protocol RepeatOptionVCDelegate {
    func repeatOptionDidSelect(option: String)
}

final class RepeatOptionVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var delegate: RepeatOptionVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
}

extension RepeatOptionVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? PrototypeOptionsTableCell
        if let repeatOption = cell?.optionNameLabel.text {
            delegate?.repeatOptionDidSelect(option: repeatOption)
        }
        
        dismiss(animated: true)
    }
}

extension RepeatOptionVC {
    
    private func registerCell() {
        let nib = UINib(nibName: "\(PrototypeOptionsTableCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(PrototypeOptionsTableCell.self)")
    }
    
}
