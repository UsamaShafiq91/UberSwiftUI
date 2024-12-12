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
    
    static let trip = Trip(passengerUid: "pass1",
                           driverUid: "driv1",
                           passengerName: "passenger",
                           driverName: "driver1",
                           passengerLocation: GeoPoint(latitude: 38.37, longitude: -122.07),
                           driverLocation: GeoPoint(latitude: 38.6, longitude: -122.07),
                           pickupLocationName: "Office",
                           dropoffLocationName: "home",
                           pickupLocationAddress: "IT HUB",
                           pickupLocation: GeoPoint(latitude: 38.37, longitude: -122.07),
                           dropoffLocation: GeoPoint(latitude: 38.9, longitude: -122.07),
                           tripCost: 100,
                           state: .requested)
}
