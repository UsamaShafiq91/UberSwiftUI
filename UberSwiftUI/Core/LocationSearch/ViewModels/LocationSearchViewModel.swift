//
//  LocationSearchViewModel.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 03/12/2024.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinates: CLLocationCoordinate2D?
    
    private var searchCompletor = MKLocalSearchCompleter()
    var searchQuery = "" {
        didSet {
            searchCompletor.queryFragment = searchQuery
        }
    }
    
    override init() {
        super.init()
        
        searchCompletor.delegate = self
        searchCompletor.queryFragment = searchQuery
    }
    
    func selectLocation(location: MKLocalSearchCompletion) {
        searchLocation(localSearch: location,
                       completionHandler: {(response, error) in
            if let error = error {
                print(error.localizedDescription)
                
                return
            }
            
            guard let location = response?.mapItems.first else { return }
            
            self.selectedLocationCoordinates = location.placemark.coordinate
            
            print("coordinates: \(self.selectedLocationCoordinates)")
        })
    }
    
    func searchLocation(localSearch: MKLocalSearchCompletion, completionHandler: @escaping MKLocalSearch.CompletionHandler) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: completionHandler)
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
