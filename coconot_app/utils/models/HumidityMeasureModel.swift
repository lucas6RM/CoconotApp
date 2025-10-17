//
//  HumidityMeasureModel.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation


struct HumidityMeasureModel : Identifiable {
    let id = UUID()
    let hotHouseId: String
    let humidityMeasuredInsideHotHouse : Double
    let humidityFromWeather : Double
    let timestamp : Date
}


