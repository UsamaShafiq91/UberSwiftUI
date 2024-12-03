//
//  UberMapView.swift
//  UberSwiftUI
//
//  Created by UsamaShafiq on 02/12/2024.
//

import Foundation
import MapKit
import SwiftUI

struct UberMapView: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject private var locationSearchViewModel: LocationSearchViewModel
    @Binding var mapState: MapViewState

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        switch mapState {
        case .noInput:
            context.coordinator.clearAnnotationsAndOverlays()
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinates = locationSearchViewModel.selectedLocationCoordinates {
                context.coordinator.selectAndAnnotateLocation(coordinate: coordinates)
                context.coordinator.configurePolyline(destination: coordinates)
            }
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapView {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        let parent: UberMapView
        
        private var userlocation: CLLocationCoordinate2D?
        private var region: MKCoordinateRegion?

        init(parent: UberMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userlocation = userLocation.coordinate
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                                                           longitude: userLocation.coordinate.longitude),
                                            span: MKCoordinateSpan(latitudeDelta: 0.05,
                                                                   longitudeDelta: 0.05))
            
            parent.mapView.setRegion(region, animated: true)
            
            self.region = region
        }
        
        func selectAndAnnotateLocation(coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            
            parent.mapView.selectAnnotation(annotation, animated: true)
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let overlayRenderer = MKPolylineRenderer(overlay: overlay)
            overlayRenderer.strokeColor = .blue
            overlayRenderer.lineWidth = 6
            
            return overlayRenderer
        }
        
        func configurePolyline(destination: CLLocationCoordinate2D) {
            guard let userlocation = userlocation else { return }
            
            getDestinationRoute(userlocation: userlocation,
                                destination: destination,
                                completion: { route in
                self.parent.mapView.addOverlay(route.polyline)
            })
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
                completion(route)
            })
        }
        
        func clearAnnotationsAndOverlays() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let region = region {
                parent.mapView.setRegion(region, animated: true)
            }
        }
    }
}
