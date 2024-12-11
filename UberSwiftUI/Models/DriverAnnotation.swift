//
//  DriverAnnotation.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import Foundation
import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var uid: String
    
    init(driver: User) {
        coordinate = CLLocationCoordinate2D(latitude: driver.coordinates.latitude,
                                            longitude: driver.coordinates.longitude)
        
        uid = driver.uid
    }
}
