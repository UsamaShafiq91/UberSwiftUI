//
//  UberSwiftUIApp.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 02/12/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct UberSwiftUIApp: App {
    
    @StateObject private var locationSearchViewModel = LocationSearchViewModel()
    @StateObject private var authModel = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationSearchViewModel)
                .environmentObject(authModel)
        }
    }
}
