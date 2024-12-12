//
//  TripAcceptedView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 12/12/2024.
//

import SwiftUI

struct TripAcceptedView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color(.systemGray5))
                .frame(width: 64, height: 10)
                .padding(.top, 8)
            
            if let trip = viewModel.trip {
                VStack {
                    HStack {
                        Text("Meet your driver at \(trip.pickupLocationName) for your trip to \(trip.dropoffLocationName)")
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
                            Text(trip.driverName)
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
                        
                        VStack(spacing: 10) {
                            Image("uber-x")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 60)
                            
                            HStack {
                                Text("Mercedes - S")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.gray)
                                
                                Text("804SK")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                            }
                            .frame(width: 130)
                        }
                        .padding()
                    }
                    
                    Divider()
                }
                .padding()
            }
            
            Button(action: {
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
    TripAcceptedView()
}
