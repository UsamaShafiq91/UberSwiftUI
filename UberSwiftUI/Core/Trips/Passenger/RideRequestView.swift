//
//  RideRequestView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 04/12/2024.
//

import SwiftUI

struct RideRequestView: View {
    
    @State private var selectedRide = RideType.uberX
    @EnvironmentObject private var homeViewModel: HomeViewModel

    var body: some View {
        VStack {
            Capsule()
                .fill(Color(.systemGray5))
                .frame(width: 64, height: 10)
                .padding(.top, 8)
            
            HStack {
                VStack {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(width: 8, height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(width: 1, height: 32)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                }
                
                VStack(alignment: .leading, spacing: 34) {
                    HStack {
                        Text("Current location")
                            .foregroundStyle(.gray)
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        
                        Text(homeViewModel.startTime ?? "")
                            .foregroundStyle(.gray)
                            .font(.system(size: 16, weight: .semibold))
                    }
                    
                    if let selectedLocation = homeViewModel.selectedLocation {
                        HStack {
                            Text(selectedLocation.title)
                                .foregroundStyle(Color.theme.primaryTextColor)
                                .font(.system(size: 16, weight: .semibold))
                            
                            Spacer()
                            
                            Text(homeViewModel.endTime ?? "")
                                .foregroundStyle(.gray)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                }
            }
            .padding()
            
            Divider()
                .padding()
            
            Text("SUGGESTED RIDES")
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.gray)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.horizontal)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) {type in
                        VStack(alignment: .leading) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading) {
                                Text(type.name)
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text(homeViewModel.computeRidePrice(for: type).toCurrency())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding()
                        }
                        .frame(width: 112, height: 140)
                        .foregroundStyle(selectedRide == type ? .white : Color.theme.primaryTextColor)
                        .background(selectedRide == type ? .blue : Color.theme.secondaryBackgroundColor)
                        .scaleEffect(selectedRide == type ? 1.25 : 1.0)
                        .clipShape(.rect(cornerRadius: 16))
                        .onTapGesture(perform: {
                            withAnimation(.spring, {
                                selectedRide = type
                            })
                        })
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding()
            
            HStack {
                Text("VISA")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(8)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .padding()
                
                Text("**** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color.theme.secondaryBackgroundColor)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal)
            
            Button(action: {
                homeViewModel.requestTrip()
            }, label: {
                Text("CONFIRM RIDE")
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 50)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
            })
            .padding(.bottom, 32)

        }
        .background(Color.theme.backgroundColor)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    RideRequestView()
}
