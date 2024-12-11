//
//  AcceptTripView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 11/12/2024.
//

import SwiftUI
import MapKit

struct AcceptTripView: View {
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.334, longitude: -122.0090),
            span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        )
    )

    
    init() {
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
                        Text("10")
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
                        Text("STEPHAN")
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
                        
                        Text("$22.04")
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
                        Text("Apple Campus")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("Lane 1")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("5.2")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("mi")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)

                Map(position: $position)
                    .frame(height: 200)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.7), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding()

               Divider()
            }
            
            HStack {
                Button(action: {
                    
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
        }
    }
}

#Preview {
    AcceptTripView()
}
