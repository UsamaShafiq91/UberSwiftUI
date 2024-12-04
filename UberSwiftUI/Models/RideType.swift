//
//  RideType.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 04/12/2024.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    
    case uberX
    case black
    case uberXL
    
    var id: Int { return rawValue }
    
    var name: String {
        switch self {
        case .uberX:
            return "Uber-X"
        case .black:
            return "Uber-Black"
        case .uberXL:
            return "Uber-XL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX:
            return "uber-x"
        case .black:
            return "uber-black"
        case .uberXL:
            return "uber-x"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .uberX:
            return 5
        case .black:
            return 20
        case .uberXL:
            return 10
        }
    }
    
    func computeRidePrice(distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters/1600
        
        switch self {
        case .uberX:
            return distanceInMiles * 1.5 + baseFare
        case .black:
            return distanceInMiles * 2.0 + baseFare
        case .uberXL:
            return distanceInMiles * 1.75 + baseFare
        }
    }
}
