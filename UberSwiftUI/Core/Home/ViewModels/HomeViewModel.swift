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
import MapKit
import FirebaseAuth

class HomeViewModel: NSObject, ObservableObject {
    
    @Published var drivers: [User] = []
    @Published var user: User?

    let userService = UserService.shared
    private var cancelable = Set<AnyCancellable>()
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocation: UberLocation?
    @Published var startTime: String?
    @Published var endTime: String?
    var userLocation: CLLocationCoordinate2D?

    private var searchCompletor = MKLocalSearchCompleter()
    var searchQuery = "" {
        didSet {
            searchCompletor.queryFragment = searchQuery
        }
    }
        
    override init() {
        super.init()
        
        fetchUser()

        searchCompletor.delegate = self
        searchCompletor.queryFragment = searchQuery
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

extension HomeViewModel {
    
    func selectLocation(location: MKLocalSearchCompletion, config: LocationResultViewConfig) {
        searchLocation(localSearch: location,
                       completionHandler: {(response, error) in
            if let error = error {
                print(error.localizedDescription)
                
                return
            }
            
            guard let locationItem = response?.mapItems.first else { return }
            
            let coordinates = locationItem.placemark.coordinate
            
            switch config {
            case .ride:
                self.selectedLocation = UberLocation(title: location.title,
                                                     coordinates: coordinates)
            case .savedLocation(let viewModel):
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let savedLocation = SavedLocation(title: location.title,
                                                  address: location.subtitle,
                                                  coordinates: GeoPoint(latitude: coordinates.latitude,
                                                                        longitude: coordinates.longitude))
                
                guard let encodedLocation = try? Firestore.Encoder().encode(savedLocation) else { return }
                
                Firestore.firestore().collection("users").document(uid).updateData([
                    viewModel.databaseKey: encodedLocation
                ])
            }
        })
        
        switch config {
        case .ride:
            searchLocation(localSearch: location,
                           completionHandler: {(response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    
                    return
                }
                
                guard let locationItem = response?.mapItems.first else { return }
                
                
                self.selectedLocation = UberLocation(title: location.title,
                                                     coordinates: locationItem.placemark.coordinate)
            })
        case .savedLocation:
            print("Saved location")
        }
    }
    
    func searchLocation(localSearch: MKLocalSearchCompletion, completionHandler: @escaping MKLocalSearch.CompletionHandler) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: completionHandler)
    }
    
    func computeRidePrice(for type: RideType) -> Double {
        guard let start = userLocation,
              let destination = selectedLocation?.coordinates else { return 0.0 }
        
        let userLocation = CLLocation(latitude: start.latitude, longitude: start.longitude)
        let destinationLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)

        let tripDistance = userLocation.distance(from: destinationLocation)
        
        return type.computeRidePrice(distanceInMeters: tripDistance)
    }
    
    func getDestinationRoute(userlocation: CLLocationCoordinate2D,
                             destination: CLLocationCoordinate2D,
                             completion: @escaping(MKRoute) -> Void) {
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userlocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))

        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: { response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let route = response?.routes.first else { return }
            
            self.setTripTime(expectedTravelTime: route.expectedTravelTime)
            
            completion(route)
        })
    }
    
    func setTripTime(expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        startTime = formatter.string(from: Date())
        endTime = formatter.string(from: Date() + expectedTravelTime)
    }
}

extension HomeViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
