//
//  HotHouseDto.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation

struct HotHouseModel {
    let id: String
    var name: String
    var address: Address? = nil
    var location: LocalisationGps? = nil
    var temperatureThresholdMax: Double
    var temperatureThresholdMin: Double
    var humidityThresholdMax: Double
    var humidityThresholdMin: Double
}

extension HotHouseModel {
    static func empty() -> HotHouseModel {
        .init(
            id: UUID().uuidString,
            name: "",
            address: Address(addressStreet: "", postalCode: "", city: ""),
            location: nil,
            temperatureThresholdMax: 0,
            temperatureThresholdMin: 0,
            humidityThresholdMax: 0,
            humidityThresholdMin: 0
        )
    }
}






