//
//  DogDetailsVC.swift
//  DOGGO
//
//  Created by Lobster on 27.01.23.
//

import UIKit

final class DogDetailsVC: UIViewController {
    
    @IBOutlet private weak var dogPhoto: UIImageView! {
        didSet {
            dogPhoto.layer.cornerRadius = 30.0
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.layer.cornerRadius = 30.0
        }
    }
    
    var dog: Dog!
    var dogImage: UIImage?
    
    private var dogDescriptions: [String] = ["Breed name",
                                             "Height imperial",
                                             "Height metric",
                                             "Weight imperial",
                                             "Weight metric",
                                             "Life span",
                                             "Origin",
                                             "Breed specification",
                                             "Temperament",
                                             "Breed group"]
    
    private var dogDescriptionParameters: [String?] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDescriptionParameters()
        registerCell()
        setupImage()
        setupBarItem()
    }
    
    
}

extension DogDetailsVC {
    
    private func setupBarItem() {
        navigationItem.title = "Dog details"
    }
    
    func setupDescriptionParameters() {
        dogDescriptionParameters = [dog.breedName,
                                    dog.height.imperial,
                                    dog.height.metric,
                                    dog.weight.imperial,
                                    dog.height.metric,
                                    dog.lifeSpan,
                                    dog.origin,
                                    dog.breedSpecification,
                                    dog.temperament,
                                    dog.breedGroup]
    }
    
    func setupImage() {
        if let image = dogImage {
            dogPhoto.image = image
        }
    }
    
    func registerCell() {
        let nib = UINib(nibName: "\(DogDetailsPrototypeTableCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(DogDetailsPrototypeTableCell.self)")
    }
    
}


extension DogDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dogDescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(DogDetailsPrototypeTableCell.self)", for: indexPath) as? DogDetailsPrototypeTableCell
        let parameter = dogDescriptionParameters[indexPath.row]
        let description = dogDescriptions[indexPath.row]
        
        cell?.descriptionLabel.text = "\(description): \(parameter ?? "No info")"
        return cell ?? UITableViewCell()
    }
    
    
}

