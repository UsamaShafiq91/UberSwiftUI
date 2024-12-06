//
//  HomeView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 02/12/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject private var locationSearchViewModel: LocationSearchViewModel
    @EnvironmentObject private var authModel: AuthViewModel

    var body: some View {
        Group {
            if authModel.userSession == nil {
                LoginView()
            }
            else {
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
                        
                        MapViewActionButton(mapState: $mapState)
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
            }
        }
    }
}

#Preview {
    HomeView()
}
