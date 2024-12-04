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
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
                
        return formatter.string(from: self as NSNumber) ?? ""
    }
    
}
