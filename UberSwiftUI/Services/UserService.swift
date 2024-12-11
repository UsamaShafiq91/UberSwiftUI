//
//  UserService.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 10/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserService: ObservableObject {
    
    static let shared = UserService()
    
    @Published var user: User?
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        print("fetchUser: \(uid) -- \(Auth.auth().currentUser?.displayName)")
        
        Firestore.firestore().collection("users").document(uid).getDocument(completion: { snapshot, error in
            
            guard let snapshot = snapshot else { return }
            
            guard let user = try? snapshot.data(as: User.self) else { return }
            
            self.user = user
        })
    }
}
