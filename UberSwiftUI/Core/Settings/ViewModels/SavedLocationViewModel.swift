//
//  SavedLocationViewModel.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import Foundation

enum SavedLocationViewModel: Int, CaseIterable, Identifiable {
    
    case home
    case work
    
    var icon: String {
        switch self {
        case .home:
            return "house.circle.fill"
        case .work:
            return "archivebox.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .work:
            return "Work"
        }
    }
    
    var subtitle: String {
        switch self {
        case .home:
            return "Add Home"
        case .work:
            return "Add Work"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .home:
            return "homeLocation"
        case .work:
            return "workLocation"
        }
    }
    
    func subtitleFor(user: User) -> String {
        switch self {
        case .home:
            if let homeLocation = user.homeLocation {
                return homeLocation.title
            }
            else {
                return "Add Home"
            }
        case .work:
            if let workLocation = user.workLocation {
                return workLocation.title
            }
            else {
                return "Add Work"
            }
        }
    }
    
    var id: Int { rawValue }
}
