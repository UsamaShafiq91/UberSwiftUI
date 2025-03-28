//
//  MapViewState.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 03/12/2024.
//

import Foundation

enum MapViewState {
    case noInput
    case searchingForLocation
    case locationSelected
    case polylineAdded
    case tripRequested
    case tripRejected
    case tripAccepted
    case tripCancelledByPassenger
    case tripCancelledByDriver
}
