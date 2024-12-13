//
//  HomeView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 02/12/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @State private var showSideMenu = false
    @EnvironmentObject private var authModel: AuthViewModel
    @EnvironmentObject private var homeModel: HomeViewModel

    var body: some View {
        Group {
            if authModel.userSession == nil {
                LoginView()
            }
            else if let user = authModel.user {
                NavigationStack {
                    ZStack {
                        if showSideMenu {
                            SideMenuView(user: user)
                        }
                        
                        ZStack(alignment: .bottom) {
                            ZStack(alignment: .top) {
                                UberMapView(mapState: $mapState)
                                    .ignoresSafeArea()
                                
                                if mapState == .searchingForLocation {
                                    LocationSearchView(mapState: $mapState)
                                }
                                else if mapState == .noInput {
                                    LocationSearchActivationView()
                                        .padding(.top, 72)
                                        .padding(.horizontal)
                                        .onTapGesture {
                                            withAnimation(.spring, {
                                                mapState = .searchingForLocation
                                            })
                                        }
                                }
                                
                                MapViewActionButton(mapState: $mapState, showSideMenu: $showSideMenu)
                                    .padding(.top, 5)
                                    .padding(.horizontal)
                            }
                            
                            if let user = authModel.user {
                                if user.accountType == .passenger {
                                    if mapState == .locationSelected || mapState == .polylineAdded {
                                        RideRequestView()
                                            .transition(.move(edge: .bottom))
                                    }
                                    else if mapState == .tripRequested {
                                        TripLoadingView()
                                            .transition(.move(edge: .bottom))
                                    }
                                    else if mapState == .tripAccepted {
                                        TripAcceptedView()
                                            .transition(.move(edge: .bottom))
                                    }
                                    else if mapState == .tripCancelledByPassenger {
                                        
                                    }
                                }
                                else {
                                    if let trip = homeModel.trip {
                                        if mapState == .tripRequested {
                                            AcceptTripView(trip: trip)
                                                .transition(.move(edge: .bottom))
                                        }
                                        else if mapState == .tripAccepted {
                                            PassengerPickupView(trip: trip)
                                                .transition(.move(edge: .bottom))
                                        }
                                        else if mapState == .tripCancelledByDriver {
                                            
                                        }
                                    }
                                }
                            }
                        }
                        .ignoresSafeArea(edges: .bottom)
                        .onReceive(LocationManager.shared.$userLocation, perform: { userLocation in
                            homeModel.userLocation = userLocation
                        })
                        .onReceive(homeModel.$selectedLocation, perform: { location in
                            if location != nil {
                                mapState = .locationSelected
                            }
                        })
                        .onReceive(homeModel.$trip, perform: { trip in
                            guard let trip = trip else { return }
                            
                            withAnimation(.spring) {
                                switch trip.state {
                                case .requested:
                                    self.mapState = .tripRequested
                                case .rejected:
                                    self.mapState = .tripRejected
                                case .accepted:
                                    self.mapState = .tripAccepted
                                case .passengerCancelled:
                                    self.mapState = .tripCancelledByPassenger
                                case .driverCancelled:
                                    self.mapState = .tripCancelledByDriver
                                }
                            }
                        })
                        .offset(x: showSideMenu ? 300 : 0)
                        .shadow(color: showSideMenu ? .black : .clear, radius: 10)
                    }
                    .onAppear(perform: {
                        showSideMenu = false
                    })
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LocationSearchViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(HomeViewModel())
    
}
