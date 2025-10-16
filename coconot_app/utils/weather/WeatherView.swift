//
//  ContentView.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//


//
//  ContentView.swift
//  WeatherBuddy
//
//  Created by Yuga Samuel on 30/11/23.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @State private var weatherManager = WeatherManager()
    
    let jakarta = LocalisationGps(latitude: -6.21462, longitude: 106.84513)
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: weatherManager.icon)
                .font(.largeTitle)
                .shadow(radius: 2)
                .padding()
            Text("Temperature: \(weatherManager.temperature)")
            Text("Humidity: \(weatherManager.humidity)")
        }
        .onAppear {
            Task {
                await weatherManager.getWeather(location: jakarta)
            }
        }
        .font(.title3)
    }
}

#Preview {
    ContentView()
}
