//
//  DogsVC.swift
//  DOGGO
//
//  Created by Lobster on 13.01.23.
//

import Foundation
import UIKit

final class DogsVC: UIViewController {
    
    var cachedData: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        return cache
    }()
    
    private var dogs = [Dog]()
    private var filteredDogs = [Dog]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var networkService = JSONNetworkService()
    private var obtainImage = ObtainImage()
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.loadDogs { dogs in
            self.dogs = dogs
            self.collectionView.reloadData()
        }
        
        registerCollectionCell()
        setupBarItem()
    }
}


//MARK: - Simple extension of DogsVC
extension DogsVC {
    
    private func registerCollectionCell() {
        let nib = UINib(nibName: "\(PrototypeCollectionCellDogs.self)", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "\(PrototypeCollectionCellDogs.self)")
    }
    
    private func setupBarItem() {
        navigationItem.title = "Dogs"
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsCancelButton = true
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
}

//MARK: - UICollectionViewDataSource
extension DogsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if isFilteringNow() {
            return filteredDogs.count
        }
        return dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PrototypeCollectionCellDogs.self)", for: indexPath) as? PrototypeCollectionCellDogs
        var dog: Dog
//        let dog = dogs[indexPath.row]
        if isFilteringNow() {
            dog = filteredDogs[indexPath.row]
        } else {
            dog = dogs[indexPath.row]
        }
        cell?.dogBreed.text = dog.breedName
        let imageLink = dog.image.url
        if let cachedImage = cachedData.object(forKey: imageLink as NSString) {
            cell?.dogImage.image = cachedImage
        } else {
            let image = obtainImage.obtainImage(imageURL: imageLink) { [weak self] image in
                self?.cachedData.setObject(image!, forKey: imageLink as NSString)
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadItems(at: [indexPath])
                }
            }
        }
        return cell ?? UICollectionViewCell()
    }
}

extension DogsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dogDetailsVC = DogDetailsVC(nibName: "\(DogDetailsVC.self)", bundle: nil)
        let dog: Dog
        
        if isFilteringNow() {
            dog = filteredDogs[indexPath.row]
        } else {
            dog = dogs[indexPath.row]
        }
        
        let imageLink = dog.image.url
        if let cachedImage = cachedData.object(forKey: imageLink as NSString) {
            dogDetailsVC.dogImage = cachedImage
        }
        
        dogDetailsVC.dog = dog
        dogDetailsVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(dogDetailsVC, animated: true)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension DogsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.bounds.height / 3
        let width = view.bounds.width / 2.2
        return CGSize(width: width, height: height)
    }
}

extension DogsVC: UISearchResultsUpdating, UISearchControllerDelegate {
    
    private func searchIsEmpty() -> Bool {
        guard let text = searchController.searchBar.text
        else { return false }
        return text.isEmpty
    }
    
    private func isFilteringNow() -> Bool{
        return searchController.isActive && !searchIsEmpty()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filteredContentForSearchText(_ searchText: String) {
        filteredDogs = dogs.filter({ dog in
            return dog.breedName.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
    
}
