//
//  HumidityMeasureDto.swift
//  coconot_app
//
//  Created by lucas mercier on 17/10/2025.
//

import Foundation


struct HumidityMeasureDto: Codable, Hashable {
    let hotHouseId: String
    let humidityMeasuredInsideHotHouse : Double
    let humidityFromWeather : Double
    let timestamp : Date
    
    
}
