//
//  ActivityTypeVC.swift
//  DOGGO
//
//  Created by Lobster on 11.02.23.
//

import UIKit

protocol ActivityTypeDelegate {
    func saveImageAndTitle(imageNameAndTitle: String)
}

final class ActivityTypeVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var delegate: ActivityTypeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
    }

}

extension ActivityTypeVC {
    
    private func registerCell() {
        let nib = UINib(nibName: "\(ActivityTypePrototypeTableCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(ActivityTypePrototypeTableCell.self)")
    }
    
}

extension ActivityTypeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ActivityTypePrototypeTableCell.self)", for: indexPath) as? ActivityTypePrototypeTableCell
        cell?.setupCell(indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
}

extension ActivityTypeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? ActivityTypePrototypeTableCell
        if let imageAndTitle = cell?.activityLabel.text {
            delegate?.saveImageAndTitle(imageNameAndTitle: imageAndTitle)
        }
        dismiss(animated: true)
    }
    
}
