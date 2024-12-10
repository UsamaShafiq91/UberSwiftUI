//
//  SettingsRowView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import SwiftUI

struct SettingsRowView: View {
    
    let icon: String
    let title: String
    let tint: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(tint)
            
            Text(title)
                .foregroundStyle(Color.theme.primaryTextColor)
            
            Spacer()
        }
        .padding(4)
    }
}

#Preview {
    SettingsRowView(icon: "bell.circle.fill", title: "Notifications", tint: .purple)
}
