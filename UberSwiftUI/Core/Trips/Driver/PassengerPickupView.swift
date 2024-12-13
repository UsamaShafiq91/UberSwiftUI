//
//  PassengerPickupView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 12/12/2024.
//

import SwiftUI

struct PassengerPickupView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    let trip: Trip
    
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 60, height: 8)
                .foregroundStyle(Color(.systemGray5))
                .padding(.top, 10)
            
            VStack {
                HStack {
                    Text("Pickup \(trip.passengerName) at \(trip.pickupLocationName)")
                        .font(.headline)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                    
                    VStack {
                        Text("\(trip.estimateTimeToPassenger)")
                            .bold()
                        
                        Text("min")
                            .bold()
                    }
                    .frame(width: 56, height: 50)
                    .foregroundStyle(.white)
                    .background(Color(.systemBlue))
                    .clipShape(.rect(cornerRadius: 10))
                }
                .padding()
                
                Divider()
            }
            
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                    VStack(alignment: .leading) {
                        Text(trip.passengerName)
                            .font(.headline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(Color(.systemYellow))
                                .imageScale(.small)
                            
                            Text("4.8")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Earnings")
                            .fontWeight(.semibold)
                        
                        Text("\(trip.tripCost.toCurrency())")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
                
                Divider()
            }
            .padding()
            
            Button(action: {
                viewModel.cancelAsDriver()
            }, label: {
                Text("Cancel Trip")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: (UIScreen.main.bounds.width - 32),height: 56)
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 10))
            })
        }
        .padding(.bottom, 32)
        .background(Color.theme.backgroundColor)
        .clipShape(.rect(cornerRadius: 20))
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    PassengerPickupView(trip: MockData.trip)
}
