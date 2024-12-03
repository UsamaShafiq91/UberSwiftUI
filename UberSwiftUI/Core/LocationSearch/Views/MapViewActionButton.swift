//
//  LocationSearchActionButton.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 03/12/2024.
//

import SwiftUI

struct MapViewActionButton: View {
    var body: some View {
        HStack {
            Button(action: {
                
            }, label: {
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.black)
                
            })
            
            Spacer()
        }
    }
}

#Preview {
    MapViewActionButton()
}
