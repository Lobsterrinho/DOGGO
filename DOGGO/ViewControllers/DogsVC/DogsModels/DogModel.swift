//
//  DogModel.swift
//  DOGGO
//
//  Created by Lobster on 25.01.23.
//

import Foundation

struct Dog: Decodable {
    var weight: Parameters
    var height: Parameters
    var id: Int
    var breedName: String
    var breedSpecification: String?
    var breedGroup: String?
    var lifeSpan: String
    var temperament: String?
    var origin: String?
    var referenceImageId: String
    var image: Image
    
    enum CodingKeys: String, CodingKey {
        case weight, height, id, temperament, origin, image
        case breedName = "name"
        case breedSpecification = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case referenceImageId = "reference_image_id"
    }
}

struct Parameters: Decodable {
    var imperial: String
    var metric: String
}

struct Image: Decodable {
    var id: String
    var width: Int
    var height: Int
    var url: String
}
