//
//  ContentView.swift
//  TheWeatherApp
//
//  Created by Adithya Ramanathan on 3/16/24.
//

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    // State object for managing location updates
    @StateObject var locationManager = LocationManager()
    
    // Weather manager for fetching weather data
    var weatherManager = WeatherManager()
    
    // State variable to hold weather data
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            // Check if location is available
            if let location = locationManager.location {
                // Check if weather data is available
                if let weather = weather {
                    // Display weather information
                    WeatherView(weather: weather)
                } else {
                    // Display loading view while fetching weather data
                    LoadingView()
                        .task {
                            do {
                                // Fetch weather data using coordinates
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                // Check if location data is being loaded
                if locationManager.isLoading {
                    // Display loading view
                    LoadingView()
                } else {
                    // Display welcome view to prompt user for location permission
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color.indigo)
        .preferredColorScheme(.dark)
    }
}

// Previewing the ContentView
#Preview {
    ContentView()
}
