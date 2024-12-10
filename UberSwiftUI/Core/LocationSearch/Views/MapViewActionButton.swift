//
//  LocationSearchActionButton.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 03/12/2024.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var mapState: MapViewState
    @Binding var showSideMenu: Bool
    @EnvironmentObject private var locationSearchViewModel: LocationSearchViewModel
    @EnvironmentObject private var authModel: AuthViewModel

    var body: some View {
        Button(action: {
            withAnimation(.spring(), {
                peformActionFor(state: mapState)
            })
        }, label: {
            Image(systemName: getButtonImage())
                .font(.title2)
                .foregroundStyle(.black)
                .padding()
                .background(.white)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 6)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        })
    }
    
    func peformActionFor(state: MapViewState) {
        switch state {
        case .noInput:
            showSideMenu.toggle()
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected, .polylineAdded:
            mapState = .noInput
            locationSearchViewModel.selectedLocation = nil
        }
    }
    
    func getButtonImage() -> String {
        switch mapState {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected, .polylineAdded:
            return "arrow.left"
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInput), showSideMenu: .constant(false))
}
