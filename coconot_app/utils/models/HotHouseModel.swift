//
//  HotHouseDto.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation

struct HotHouseModel {
    let id: String
    let name: String
    var address: Address? = nil
    let location: LocalisationGps
    let temperatureThresholdMax: Double
    let temperatureThresholdMin: Double
    let humidityThresholdMax: Double
    let humidityThresholdMin: Double
}










