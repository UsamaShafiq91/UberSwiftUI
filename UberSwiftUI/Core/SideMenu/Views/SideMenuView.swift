//
//  SideMenuView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 09/12/2024.
//

import SwiftUI

struct SideMenuView: View {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                    VStack(alignment: .leading) {
                        Text(user.fullname)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(user.email)
                            .tint(Color.theme.primaryTextColor)
                            .opacity(0.7)
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Do more with your account")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "dollarsign.square")
                            .font(.title2)
                            .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        
                        Text("Make Money Driving")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            Divider()
                .padding(.vertical)
            
            VStack(spacing: 40) {
                ForEach(SideMenuOptionViewModel.allCases) {menuOption in
                    NavigationLink(value: menuOption, label: {
                        SideMenuOptionView(menuOption: menuOption)
                    })
                }
            }
            .navigationDestination(for: SideMenuOptionViewModel.self, destination: { menuOption in
                switch menuOption {
                case .trips:
                    Text(menuOption.title)
                case .wallet:
                    Text(menuOption.title)
                case .settings:
                    SettingsView(user: user)
                case .messages:
                    Text(menuOption.title)
                }
                
            })
            
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.top, 32)
    }
}

#Preview {
    SideMenuView(user: User(uid: "123", fullname: "John Doe", email: "john111@gmail.com"))
}
