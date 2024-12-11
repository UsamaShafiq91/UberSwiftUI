//
//  AuthViewModel.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 06/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var user: User?
    
    let userService = UserService.shared
    private var cancelable = Set<AnyCancellable>()

    init() {
        userSession = Auth.auth().currentUser
        print("userSession: \(userSession)")
        fetchUser()
    }
    
    func registerUser(withEmail email: String, password: String, fullName: String) {
        guard let location = LocationManager.shared.userLocation else { return }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(result, error) in
            if let error = error {
                print(error.localizedDescription)
                
                return
            }
            
            guard let firebaseUser = result?.user else { return }
            self.userSession = firebaseUser
            
            let user = User(uid: firebaseUser.uid,
                            fullname: fullName,
                            email: email,
                            accountType: .driver,
                            coordinates: GeoPoint(latitude: location.latitude,
                                                  longitude: location.longitude))
            
            guard let encoded = try? Firestore.Encoder().encode(user) else { return }
            
            Firestore.firestore().collection("users").document(user.uid).setData(encoded)
            self.user = user
        })
    }
    
    func signinUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if let error = error {
                print(error.localizedDescription)
                
                return
            }
            
            self.userSession = result?.user
            self.fetchUser()
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
        userService.$user
            .sink(receiveValue: { user in
                guard let user = user else { return }
                
                self.user = user
            })
            .store(in: &cancelable)
    }
}
