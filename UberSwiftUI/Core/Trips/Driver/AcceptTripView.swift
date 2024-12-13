//
//  AcceptTripView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 11/12/2024.
//

import SwiftUI
import MapKit

struct AcceptTripView: View {
    
    @State private var position = MapCameraPosition.automatic
    let trip: Trip
    let annotation: UberLocation
    
    @EnvironmentObject private var homeViewModel: HomeViewModel

    init(trip: Trip) {
        self.trip = trip
        
        self.annotation = UberLocation(title: trip.pickupLocationName,
                                       coordinates: trip.pickupLocation.toCoordinate())

        position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: trip.pickupLocation.toCoordinate(),
                span: MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
            )
        )
    }
    
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 60, height: 8)
                .foregroundStyle(Color(.systemGray5))
                .padding(.top, 10)
            
            VStack {
                HStack {
                    Text("Would you like to pickup this passenger?")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
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
                            .foregroundStyle(.gray)
                        
                        Text("\(trip.tripCost.toCurrency())")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
                
                Divider()
            }
            .padding()
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(trip.pickupLocationName)
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text(trip.pickupLocationAddress)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(trip.estimatedDistanceToPassenger.toDistanceInMiles())
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("mi")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)

                Map(position: $position) {
                    Marker(trip.pickupLocationName,
                           coordinate: trip.pickupLocation.toCoordinate())
                }
                .frame(height: 200)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.7), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding()

               Divider()
            }
            
            HStack {
                Button(action: {
                    homeViewModel.rejectTrip()
                }, label: {
                    Text("Reject")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width/2 - 32),height: 56)
                        .background(Color(.systemRed))
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 4))
                })
                
                Spacer()
                
                Button(action: {
                    homeViewModel.acceptTrip()
                }, label: {
                    Text("Accept")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width/2 - 32),height: 56)
                        .background(Color(.systemBlue))
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 4))
                })
            }
            .padding()
            .padding(.bottom, 24)
        }
        .background(Color.theme.backgroundColor)
        .clipShape(.rect(cornerRadius: 20))
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    AcceptTripView(trip: MockData.trip)
}
