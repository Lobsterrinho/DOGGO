//
//  ProfileModel.swift
//  DOGGO
//
//  Created by Lobster on 20.01.23.
//

import Foundation

struct Profile: Codable {
    var dogAvatar: Data
    var dogName: String
    var dogAge: String
    var dogWeight: String
}
