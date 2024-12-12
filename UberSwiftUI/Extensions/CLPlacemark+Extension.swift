//
//  CLPlacemark+Extension.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 11/12/2024.
//

import Foundation
import MapKit

extension CLPlacemark {
    
    func getCompleteAddress() -> String {
        var address = ""
        
        if let thoroughfare = thoroughfare {
            address = address + thoroughfare
        }
        
        if let subThoroughfare = subThoroughfare {
            address = address + " " + subThoroughfare
        }
        
        if let administrativeArea = administrativeArea {
            address = address + " " + administrativeArea
        }
        
        return address
    }
}
