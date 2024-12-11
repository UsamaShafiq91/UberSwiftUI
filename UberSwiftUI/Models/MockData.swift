//
//  MockData.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import Foundation
import Firebase

class MockData {
    static let user = User(uid: UUID().uuidString,
                           fullname: "John Doe",
                           email: "johndoe@gmail.com",
                           accountType: .passenger,
                           coordinates: GeoPoint(latitude: 38.37, longitude: -122.07))
}
