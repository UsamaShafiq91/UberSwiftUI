//
//  AuthViewModel.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 06/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var user: User?

    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func registerUser(withEmail email: String, password: String, fullName: String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {(result, error) in
            if let error = error {
                print(error.localizedDescription)
                
                return
            }
            
            guard let firebaseUser = result?.user else { return }
            self.userSession = firebaseUser
            
            let user = User(uid: firebaseUser.uid, fullname: fullName, email: email)
            
            guard let encoded = try? Firestore.Encoder().encode(user) else { return }
            
            Firestore.firestore().collection("users").document(user.uid).setData(encoded)
        })
    }
    
    func signinUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if let error = error {
                print(error.localizedDescription)
                
                return
            }
            
            self.userSession = result?.user
        })
    }
    
    func signoutUser() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        }
        catch {
            print("Signout error: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument(completion: { snapshot, error in
            
            guard let snapshot = snapshot else { return }
            
            guard let user = try? snapshot.data(as: User.self) else { return }
            
            self.user = user
        })
    }
}
