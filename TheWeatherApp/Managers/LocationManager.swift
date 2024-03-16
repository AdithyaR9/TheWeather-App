//
//  LocationManager.swift
//  TheWeatherApp
//
//  Created by Adithya Ramanathan on 3/16/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // Creating an instance of CLLocationManager to manage location services
    let manager = CLLocationManager()
    
    // Published properties to notify changes in location and loading state
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    // Initializing the LocationManager
    override init() {
        super.init()
        
        // Assigning a delegate to handle location updates
        manager.delegate = self
    }
    
    // Requesting the one-time delivery of the user’s current location
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    // CLLocationManagerDelegate method called when location updates are available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Update the location variable with the latest coordinates
        location = locations.first?.coordinate
        // Update loading state
        isLoading = false
    }
    
    // CLLocationManagerDelegate method called when an error occurs while retrieving location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Print error message to the console
        print("Error getting location", error)
        // Update loading state
        isLoading = false
    }
}
