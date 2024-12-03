//
//  LocationSearchView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 03/12/2024.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText = ""
    @Binding var mapState: MapViewState

    @EnvironmentObject private var locationSearchViewModel: LocationSearchViewModel

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack {
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGray5))
                    
                    TextField("Where to?", text: $locationSearchViewModel.searchQuery)
                        .frame(height: 32)
                        .background(Color(.systemGray3))
                }
                .padding(.leading)
            }
            .padding(.horizontal)
            .padding(.top, 72)
            
            Divider()
                .padding(.vertical)
                .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ForEach(locationSearchViewModel.results, id: \.self) {result in
                        LocationSearchResultView(title: result.title, subTitle: result.subtitle)
                            .onTapGesture {
                                locationSearchViewModel.selectLocation(location: result)
                                
                                mapState = .locationSelected
                            }
                    }
                }
            }
        }
        .background(.white)
    }
}

#Preview {
    LocationSearchView(mapState: .constant(MapViewState.noInput))
        .environmentObject(LocationSearchViewModel())
}
