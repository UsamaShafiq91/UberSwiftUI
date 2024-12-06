//
//  CustomInputField.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 06/12/2024.
//

import SwiftUI

struct CustomInputField: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .foregroundStyle(.white)
            }
            else {
                TextField(placeholder, text: $text)
                    .foregroundStyle(.white)
                    .tint(.white)
                    .textInputAutocapitalization(.never)
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.white.opacity(0.2))
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CustomInputField(title: "Email Address",
                     placeholder: "Enter your email",
                     text: .constant(""))
}
