//
//  UberSwiftUIApp.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 02/12/2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct UberSwiftUIApp: App {
    
    @StateObject private var locationSearchViewModel = LocationSearchViewModel()
    @StateObject private var authModel = AuthViewModel()
    @StateObject private var homeModel = HomeViewModel()

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationSearchViewModel)
                .environmentObject(authModel)
                .environmentObject(homeModel)
        }
    }
}
