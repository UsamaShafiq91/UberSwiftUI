//
//  SideMenuOptionView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 09/12/2024.
//

import SwiftUI

struct SideMenuOptionView: View {
    
    let menuOption: SideMenuOptionViewModel
    
    var body: some View {
        HStack {
            Image(systemName: menuOption.imageName)
                .font(.title2)
                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
            
            Text(menuOption.title)
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .foregroundStyle(Color.theme.primaryTextColor)
    }
}

#Preview {
    SideMenuOptionView(menuOption: .wallet)
}
