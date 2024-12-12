//
//  TripLoadingView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 12/12/2024.
//

import SwiftUI

struct TripLoadingView: View {
    var body: some View {
        VStack {
            Capsule()
                .fill(Color(.systemGray5))
                .frame(width: 64, height: 10)
                .padding(.top, 8)
            
            HStack {
                Text("Connecting you to a driver")
                    .font(.headline)
                    .padding(.leading)
                
                Spacer()
                
                Spinner(lineWidth: 6,
                        height: 64,
                        width: 64)
                .padding()
            }
            .padding(.bottom, 32)
        }
        .background(Color.theme.backgroundColor)
        .clipShape(.rect(cornerRadius: 20))
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    TripLoadingView()
}
