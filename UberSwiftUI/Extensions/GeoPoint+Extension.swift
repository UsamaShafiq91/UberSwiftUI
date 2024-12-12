//
//  GeoPoint+Extension.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 11/12/2024.
//

import Foundation
import Firebase
import MapKit

extension GeoPoint {
    
    func toCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude,
                                      longitude: longitude)
    }
}
