//
//  LoginView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 04/12/2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject private var authModel: AuthViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    VStack(spacing: -20) {
                        Image("logo")
                            .resizable()
                            .frame(width: 200, height: 200)
                        
                        Text("UBER")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    
                    VStack(spacing: 24) {
                        
                        CustomInputField(title: "Email Address", 
                                         placeholder: "name@example.com",
                                         text: $email)
                        
                        CustomInputField(title: "Password",
                                         placeholder: "Enter your password",
                                         text: $password,
                                         isSecureField: true)
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Forgot Password?")
                                .foregroundStyle(.white)
                                .font(.caption)
                                .fontWeight(.semibold)
                        })
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                    }
                    .padding()
                    
                    VStack(spacing: 20) {
                        HStack(spacing: 12) {
                            Rectangle()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 1)
                                .foregroundStyle(.white.opacity(0.5))
                            
                            Text("Sign in with Social")
                                .foregroundStyle(.white)
                                .font(.system(size: 15, weight: .semibold))
                            
                            Rectangle()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 1)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                
                            }, label: {
                                Image("facebook")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            })
                            
                            Button(action: {
                                
                            }, label: {
                                Image("google")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            })
                        }
                        
                        Spacer()
                        
                    }
                    .padding()
                    
                    Button(action: {
                        authModel.signinUser(withEmail: email, password: password)
                    }, label: {
                        HStack {
                            Text("SIGN IN")
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
                    
                    NavigationLink(destination: {
                        RegistrationView()
                    }, label: {
                        HStack {
                            Text("Do you have an account?")
                                .font(.system(size: 14))
                            
                            Text("Sign Up")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundStyle(.white)
                        .padding()
                    })
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
