//
//  HomeViewModel.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var drivers: [User] = []
    @Published var user: User?

    let userService = UserService.shared
    private var cancelable = Set<AnyCancellable>()
    
    init() {
        fetchUser()
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments(completion: { snapshot, error in
                if let documents = snapshot?.documents {
                    let users = documents.compactMap({try? $0.data(as: User.self)})
                    self.drivers = users
                    
                    print("Drivers: \(users)")
                }
            })
    }
    
    func fetchUser() {
        userService.$user
            .sink(receiveValue: { user in
                guard let user = user else { return }
                self.user = user
                
                guard user.accountType == .passenger else { return }
                self.fetchDrivers()
            })
            .store(in: &cancelable)
    }
}
