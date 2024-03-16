//
//  WeatherView.swift
//  TheWeatherApp
//
//  Created by Adithya Ramanathan on 3/16/24.
//

import SwiftUI

struct WeatherView: View {
    // Weather data received from API
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    // City name
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    // Current date
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            // Weather icon
                            Image(systemName: "cloud")
                                .font(.system(size: 40))
                            
                            // Weather description
                            Text("\(weather.weather[0].main)")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        // Current temperature
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 75))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height:  80)
                    
                    // Additional weather details
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Additional weather details view
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Outside Status")
                        .bold()
                        .padding(.bottom)
                    
                    // Min and Max temperature, wind speed, humidity
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Temperature Low", value: (weather.main.tempMin.roundDouble() + ("°")))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Temperature High", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color.indigo)
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.indigo)
        .preferredColorScheme(.dark)
    }
}

// Previewing the WeatherView with sample data
#Preview {
    WeatherView(weather: previewWeather)
}
