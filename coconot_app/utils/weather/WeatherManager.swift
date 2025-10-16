//
//  WeatherManager.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//


//
//  WeatherManager.swift
//  WeatherBuddy
//
//  Created by Yuga Samuel on 30/11/23.
//

import Foundation
import WeatherKit
internal import _LocationEssentials

@Observable class WeatherManager {
    private let weatherService = WeatherService()
    var weather: Weather?
    
    func getWeather(location: LocalisationGps) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) { [weak self] in
                return try await self?.weatherService.weather(for: .init(latitude: location.latitude, longitude: location.longitude))
            }.value
            
        } catch {
            print("Failed to get weather data. \(error)")
        }
    }

    var icon: String {
        guard let iconName = weather?.currentWeather.symbolName else { return "--" }
        
        return iconName
    }
    
    var temperature: String {
        guard let temp = weather?.currentWeather.temperature else { return "--" }
        let convert = temp.converted(to: .celsius).value
        
        return String(Int(convert)) + "°C"
    }
    
    var humidity: String {
        guard let humidity = weather?.currentWeather.humidity else { return "--" }
        let computedHumidity = humidity * 100
        
        return String(Int(computedHumidity)) + "%"
    }
}
