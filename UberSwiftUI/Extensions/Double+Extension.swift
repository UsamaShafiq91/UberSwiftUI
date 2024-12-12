//
//  Double+Extension.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 04/12/2024.
//

import Foundation

extension Double {
    
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 2
                
        return formatter.string(from: self as NSNumber) ?? ""
    }
    
    func toDistanceInMiles() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 1
                
        let miles = self/1600
        return formatter.string(from: miles as NSNumber) ?? ""
    }
}
