//
//  WeatherManager.swift
//  TheWeatherApp
//
//  Created by Adithya Ramanathan on 3/16/24.
//

import Foundation
import CoreLocation

class WeatherManager {
    // Function to fetch current weather data from OpenWeatherMap API
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        // Construct the URL with the provided latitude and longitude coordinates
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=66e0467a84273d869c54980f6db3eb10&units=imperial") else {
            fatalError("Missing URL")
        }
        
        // Create a URL request with the constructed URL
        let urlRequest = URLRequest(url: url)
        
        // Perform an asynchronous network request to fetch data from the URL
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Check if the response status code indicates success (HTTP 200)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        
        // Decode the JSON response data into the ResponseBody struct
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        // Return the decoded weather data
        return decodedData
    }
}

// Model representing the response body from the OpenWeatherMap API
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    // Model for coordinates response
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    // Model for weather information response
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    // Model for main weather parameters response
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    // Model for wind information response
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

// Extension to provide computed properties for main weather response parameters
extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
