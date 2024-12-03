//
//  LocationSearchResultView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 03/12/2024.
//

import SwiftUI

struct LocationSearchResultView: View {
    
    var title = ""
    var subTitle = ""
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.blue)
                .tint(.white)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(subTitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                Divider()
            }
            .padding(.leading, 4)
        }
        .padding(.leading)
    }
}

#Preview {
    LocationSearchResultView(title: "Coffee", subTitle: "123 main")
}
