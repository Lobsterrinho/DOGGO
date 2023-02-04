//
//  PrototypeCollectionCellDogs.swift
//  DOGGO
//
//  Created by Lobster on 25.01.23.
//

import Foundation
import UIKit

final class PrototypeCollectionCellDogs: UICollectionViewCell {
    
    @IBOutlet weak var dogBreed: UILabel! {
        didSet {

        }
    }
    @IBOutlet weak var dogImage: UIImageView! {
        didSet {
            dogImage.layer.cornerRadius = 15.0
            dogImage.backgroundColor = .systemGray6
            dogImage.isUserInteractionEnabled = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCellView()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        dogImage.image = nil
    }
    
    
    
}

extension PrototypeCollectionCellDogs {
    
    private func setupCellView() {
        layer.backgroundColor = UIColor.green.cgColor
        layer.cornerRadius = 15.0
        dogBreed.textColor = .red
        contentView.isUserInteractionEnabled = false

    }
    
}
