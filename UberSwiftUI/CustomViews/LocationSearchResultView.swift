//
//  LocationSearchResultView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import SwiftUI

enum LocationResultViewConfig {
    case ride
    case savedLocation(SavedLocationViewModel)
}

struct LocationSearchResultView: View {
    
    @StateObject var locationSearchViewModel: LocationSearchViewModel
    let config: LocationResultViewConfig
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(locationSearchViewModel.results, id: \.self) {result in
                    LocationSearchResultCellView(title: result.title, subTitle: result.subtitle)
                        .onTapGesture {
                            withAnimation(.spring, {
                                locationSearchViewModel.selectLocation(location: result, config: config)
                            })
                        }
                }
            }
        }
    }
}

#Preview {
    LocationSearchResultView(locationSearchViewModel: LocationSearchViewModel(), config: .ride)
}
