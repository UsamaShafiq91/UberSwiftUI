//
//  SavedLocationSearchView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import SwiftUI

struct SavedLocationSearchView: View {
    
    @StateObject private var locationSearchViewModel = LocationSearchViewModel()
    let viewModel: SavedLocationViewModel
        
    var body: some View {
        VStack {
            TextField("Search for a location", text: $locationSearchViewModel.searchQuery)
                .frame(height: 32)
                .padding(.leading)
                .background(Color(.systemGray5))
                .padding()
            
            LocationSearchResultView(locationSearchViewModel: locationSearchViewModel, config: .savedLocation(viewModel))
        }
        .navigationTitle(viewModel.subtitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SavedLocationSearchView(viewModel: .home)
}
