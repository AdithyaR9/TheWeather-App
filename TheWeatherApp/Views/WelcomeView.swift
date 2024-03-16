//
//  WelcomeView.swift
//  TheWeatherApp
//
//  Created by Adithya Ramanathan on 3/16/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("This is The Weather App")
                    .bold()
                    .font(.title)

                Text("Gimme Ur Addy")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()

            LocationButton(.shareCurrentLocation) {
                            locationManager.requestLocation()
                    }
                    .cornerRadius(30)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)    }
}

#Preview {
    WelcomeView()
}
