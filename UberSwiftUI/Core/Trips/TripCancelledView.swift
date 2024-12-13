//
//  TripCancelledView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 13/12/2024.
//

import SwiftUI

struct TripCancelledView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color(.systemGray5))
                .frame(width: 64, height: 10)
                .padding(.top, 8)
            
            Text(viewModel.tripCancelledMessage())
                .font(.headline)
                .padding(.vertical)
            
            Button(action: {
                guard let user = viewModel.user,
                      let trip = viewModel.trip else { return }

                if user.accountType == .passenger {
                    if trip.state == .passengerCancelled {
                        viewModel.trip = nil
                    }
                    else if trip.state == .driverCancelled {
                        viewModel.deleteTrip()
                    }
                }
                else {
                    if trip.state == .driverCancelled {
                        viewModel.trip = nil
                    }
                    else if trip.state == .passengerCancelled {
                        viewModel.deleteTrip()
                    }
                }
                
            }, label: {
                Text("Ok")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: (UIScreen.main.bounds.width - 32),height: 56)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 10))
            })
        }
        .frame(maxWidth: .infinity)
        .background(Color.theme.backgroundColor)
        .clipShape(.rect(cornerRadius: 20))
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    TripCancelledView()
}
