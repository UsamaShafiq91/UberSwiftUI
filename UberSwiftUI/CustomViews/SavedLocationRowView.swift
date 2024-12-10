//
//  SavedLocationRowView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import SwiftUI

struct SavedLocationRowView: View {
    
    let viewModel: SavedLocationViewModel
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: viewModel.icon)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(Color(.systemBlue))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.primaryTextColor)
                
                Text(viewModel.subtitleFor(user: user))
                    .font(.caption)
                    .foregroundStyle(Color.theme.primaryTextColor.opacity(0.7))
            }
            
            Spacer()
        }
    }
}

#Preview {
    SavedLocationRowView(viewModel: .home,
                         user: User(uid: "1111",
                                    fullname: "john",
                                    email: "john@gmail.com",
                                    homeLocation: nil,
                                    workLocation: nil))
}
