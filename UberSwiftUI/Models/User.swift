//
//  User.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 06/12/2024.
//

import Foundation
import FirebaseFirestore

enum AccountType: Int, Codable {
    case passenger
    case driver
}

struct User: Codable {
    let uid: String
    let fullname: String
    let email: String
    var accountType: AccountType
    var coordinates: GeoPoint
    var homeLocation: SavedLocation?
    var workLocation: SavedLocation?
}
