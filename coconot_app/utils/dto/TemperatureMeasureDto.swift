//
//  TemperatureMeasureDto.swift
//  coconot_app
//
//  Created by lucas mercier on 17/10/2025.
//

import Foundation


struct TemperatureMeasureDto: Codable, Hashable {
    let hotHouseId: String
    let temperatureMeasuredInsideHotHouse : Double
    let temperatureFromWeather : Double
    let timestamp : Date
}
