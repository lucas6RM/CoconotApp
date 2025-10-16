//
//  HotHouseDto.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//


struct HotHouseDto: Codable, Hashable {
    let id: String
    let name: String
    let address: AddressDto
    let location: LocalisationGpsDto
    let temperatureThresholdMax: Double
    let temperatureThresholdMin: Double
    let humidityThresholdMax: Double
    let humidityThresholdMin: Double

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case location
        case temperatureThresholdMax = "temperature_threshold_max"
        case temperatureThresholdMin = "temperature_threshold_min"
        case humidityThresholdMax = "humidity_threshold_max"
        case humidityThresholdMin = "humidity_threshold_min"
    }
}