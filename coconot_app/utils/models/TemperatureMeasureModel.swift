//
//  TemperatureMeasureModel.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation

struct TemperatureMeasureModel : Identifiable {
    let id = UUID()
    let hotHouseId: String
    let temperatureMeasuredInsideHotHouse : Double
    let temperatureFromWeather : Double
    let timestamp : Date
}


