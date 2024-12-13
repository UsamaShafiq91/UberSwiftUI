//
//  Trip.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 11/12/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

enum TripState: Int, Codable {
    case requested
    case rejected
    case accepted
    case passengerCancelled
    case driverCancelled
}

struct Trip: Identifiable, Codable {
    @DocumentID var tripId: String?
    let passengerUid: String
    let driverUid: String
    let passengerName: String
    let driverName: String
    let passengerLocation: GeoPoint
    let driverLocation: GeoPoint
    let pickupLocationName: String
    let dropoffLocationName: String
    let pickupLocationAddress: String
    let pickupLocation: GeoPoint
    let dropoffLocation: GeoPoint
    let tripCost: Double
    var estimateTimeToPassenger: Int = 0
    var estimatedDistanceToPassenger: Double = 0
    var state: TripState
    
    var id: String {
        tripId ?? ""
    }

}
