//
//  SavedLocation.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import Foundation
import FirebaseFirestore

struct SavedLocation: Codable {
    let title: String
    let address: String
    let coordinates: GeoPoint
}
