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
    @Published var trip: Trip?
    
    var destinationRoute: MKRoute?

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
    
    func tripCancelledMessage() -> String {
        guard let user = user,
              let trip = trip else { return "" }
        
        var message = ""
        
        if user.accountType == .passenger {
            if trip.state == .passengerCancelled {
                message = "Your trip is cancelled"
            }
            else if trip.state == .driverCancelled {
                message = "The driver cancelled the trip"
            }
        }
        else {
            if trip.state == .driverCancelled {
                message = "Your trip is cancelled"
            }
            else if trip.state == .passengerCancelled {
                message = "The trip is being cancelled by the passenger"
            }
        }
        
        return message
    }
    
    func fetchUser() {
        userService.$user
            .sink(receiveValue: { user in
                guard let user = user else { return }
                self.user = user
                
                if user.accountType == .passenger {
                    self.fetchDrivers()
                    self.addObserverForPassenger()
                }
                else {
                    self.addObserverForDriver()
                }
            })
            .store(in: &cancelable)
    }
    
    func deleteTrip() {
        guard let trip = trip else { return }
        
        Firestore.firestore().collection("trips").document(trip.id).delete(completion: {_ in 
            self.trip = nil
        })
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


// MARK: - Passenger APIs
extension HomeViewModel {
    
    func addObserverForPassenger() {
        guard let currentUser = user else { return }
        
        Firestore.firestore().collection("trips")
            .whereField("passengerUid", isEqualTo: currentUser.uid)
            .addSnapshotListener({snapshot, error in
                guard let documentChange = snapshot?.documentChanges.first,
                      documentChange.type == .added || documentChange.type == .modified else { return }
                
                guard let trip = try? documentChange.document.data(as: Trip.self) else { return }
                
                self.trip = trip
            })
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments(completion: { snapshot, error in
                if let documents = snapshot?.documents {
                    let users = documents.compactMap({try? $0.data(as: User.self)})
                    self.drivers = users
                }
            })
    }
    
    func requestTrip() {
        guard let driver = drivers.first,
              let passenger = user,
              let dropofflocation = selectedLocation,
              let coordinates = dropofflocation.coordinates else { return }
        
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: passenger.coordinates.latitude,
                                                       longitude: passenger.coordinates.longitude),
                                            completionHandler: { placemarks, errors in
            guard let placemark = placemarks?.first else { return }
            
            let tripCost = self.computeRidePrice(for: .uberX)
            
            let trip = Trip(passengerUid: passenger.uid,
                            driverUid: driver.uid,
                            passengerName: passenger.fullname,
                            driverName: driver.fullname,
                            passengerLocation: passenger.coordinates,
                            driverLocation: driver.coordinates,
                            pickupLocationName: placemark.name ?? "Current Location",
                            dropoffLocationName: dropofflocation.title,
                            pickupLocationAddress: placemark.getCompleteAddress(),
                            pickupLocation: passenger.coordinates,
                            dropoffLocation: GeoPoint(latitude: coordinates.latitude,
                                                      longitude: coordinates.longitude),
                            tripCost: tripCost,
                            state: .requested)
            
            guard let encodedTrip = try? Firestore.Encoder().encode(trip) else { return }
            
            Firestore.firestore().collection("trips").document().setData(encodedTrip, completion: {_ in
                
            })
        })
    }
    
    func cancelAsPassenger() {
        updateTripState(state: .passengerCancelled)
    }
}

// MARK: - Driver APIs
extension HomeViewModel {
    
    func addObserverForDriver() {
        guard let currentUser = user else { return }
        
        Firestore.firestore().collection("trips")
            .whereField("driverUid", isEqualTo: currentUser.uid)
            .addSnapshotListener({snapshot, error in
                guard let documentChange = snapshot?.documentChanges.first,
                      documentChange.type == .added || documentChange.type == .modified else { return }
                
                guard let trip = try? documentChange.document.data(as: Trip.self) else { return }
                
                self.trip = trip
                
                self.getDestinationRoute(userlocation: trip.driverLocation.toCoordinate(),
                                         destination: trip.pickupLocation.toCoordinate(),
                                         completion: { route in
                    self.destinationRoute = route
                    self.trip?.estimateTimeToPassenger = Int(route.expectedTravelTime / 60)
                    self.trip?.estimatedDistanceToPassenger = route.distance
                })
            })
    }
    
    func acceptTrip() {
        updateTripState(state: .accepted)
    }
    
    func rejectTrip() {
        updateTripState(state: .rejected)
    }
    
    func cancelAsDriver() {
        updateTripState(state: .driverCancelled)
    }
    
    private func updateTripState(state: TripState) {
        guard let trip = trip else { return }
        
        var data = ["state": state.rawValue]
        
        if state == .accepted {
            data["estimateTimeToPassenger"] = trip.estimateTimeToPassenger
        }
        
        Firestore.firestore().collection("trips").document(trip.id)
            .updateData(data,
                        completion: {_ in
                print("Updated trip state to \(state)")
            })
    }
}

extension HomeViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
