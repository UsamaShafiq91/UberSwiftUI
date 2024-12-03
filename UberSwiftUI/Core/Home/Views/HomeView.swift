//
//  HomeView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 02/12/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    
    var body: some View {
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
    }
}

#Preview {
    HomeView()
}
