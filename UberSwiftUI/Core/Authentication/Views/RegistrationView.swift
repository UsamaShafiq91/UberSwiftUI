//
//  RegistrationView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 06/12/2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var authModel: AuthViewModel

    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.largeTitle)
                })
                .padding(.vertical)
                
                Text("Create new account")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 50) {
                    CustomInputField(title: "Full Name",
                                     placeholder: "Enter your name",
                                     text: $name)
                    
                    CustomInputField(title: "Email Address",
                                     placeholder: "Enter your email",
                                     text: $email)
                    
                    CustomInputField(title: "Password",
                                     placeholder: "Enter your password",
                                     text: $password,
                                     isSecureField: true)
                }
                
                Spacer()
                
                Button(action: {
                    authModel.registerUser(withEmail: email,
                                           password: password,
                                           fullName: name)
                }, label: {
                    HStack {
                        Text("SIGN UP")
                            .foregroundStyle(.black)
                        
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.black)
                    }
                    .frame(maxWidth: .infinity)
                })
                .frame(height: 50)
                .background(.white)
                .clipShape(.rect(cornerRadius: 8))
                .padding(.horizontal)

                Spacer()
                
            }
            .padding()
            .foregroundStyle(.white)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegistrationView()
}
