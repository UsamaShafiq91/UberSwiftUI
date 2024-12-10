//
//  SettingsView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var authModel: AuthViewModel

    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            List {
                Section {
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
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .imageScale(.small)
                            .foregroundStyle(.gray)
                    }
                }
                
                Section("Favorites") {
                    ForEach(SavedLocationViewModel.allCases) { viewModel in
                        NavigationLink(destination: {
                            SavedLocationSearchView(viewModel: viewModel)
                        }, label: {
                            SavedLocationRowView(viewModel: viewModel, user: user)
                        })
                    }
                }
                
                Section("Settings") {
                    SettingsRowView(icon: "bell.circle.fill",
                                    title: "Notifications",
                                    tint: .purple)
                    
                    SettingsRowView(icon: "creditcard.circle.fill",
                                    title: "Payment Methods",
                                    tint: Color(.systemBlue))
                }
                
                Section("Account") {
                    SettingsRowView(icon: "dollarsign.circle.fill",
                                    title: "Make money driving",
                                    tint: .green)
                    
                    SettingsRowView(icon: "arrow.backward.circle.fill",
                                    title: "Sign Out",
                                    tint: .red)
                    .onTapGesture {
                        authModel.signoutUser()
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SettingsView(user: User(uid: "123", fullname: "John Doe", email: "john111@gmail.com"))
    }
}
