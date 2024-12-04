//
//  Color+Extension.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 04/12/2024.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ThemeColor()
}

struct ThemeColor {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
}
