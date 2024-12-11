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
    @EnvironmentObject private var locationSearchViewModel: LocationSearchViewModel
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
                            
                            if mapState == .locationSelected || mapState == .polylineAdded {
                                RideRequestView()
                            }
                        }
                        .ignoresSafeArea(edges: .bottom)
                        .onReceive(LocationManager.shared.$userLocation, perform: { userLocation in
                            locationSearchViewModel.userLocation = userLocation
                        })
                        .onReceive(locationSearchViewModel.$selectedLocation, perform: { location in
                            if location != nil {
                                mapState = .locationSelected
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
