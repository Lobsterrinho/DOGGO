//
//  ObtainImage.swift
//  DOGGO
//
//  Created by Lobster on 26.01.23.
//

import Foundation
import UIKit

final class ObtainImage {
    func obtainImage(imageURL: String, completion: @escaping (UIImage?) -> Void) {
        if let imageURL = URL(string: imageURL) {
            URLSession.shared.dataTask(with: imageURL) { data, responce, error in
                if let imageData = data {
                    let imageFromData = UIImage(data: imageData)
                    completion(imageFromData)
                }
            }.resume()
        }
    }
}
