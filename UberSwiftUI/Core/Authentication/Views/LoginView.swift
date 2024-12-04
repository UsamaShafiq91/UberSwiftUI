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

    var body: some View {
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
                    VStack(alignment: .leading) {
                        Text("Email Address")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                        
                        
                        TextField("name@example.com", text: $email)
                            .foregroundStyle(.white)
                            .tint(.white)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.white.opacity(0.2))
                            
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Password")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                        
                        TextField("Enter your password", text: $password)
                            .foregroundStyle(.white)
                            .tint(.white)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.white.opacity(0.2))
                    }
                    
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
                            .font(.system(size: 14, weight: .semibold))
                        
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
                    
                }, label: {
                    HStack {
                        Text("SIGN IN")
                            .foregroundStyle(.black)
                        
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.black)
                    }
                })
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.white)
                .clipShape(.rect(cornerRadius: 8))
                .padding(.horizontal)

                Spacer()
                
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("Do you have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign Up")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundStyle(.white)
                })
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
