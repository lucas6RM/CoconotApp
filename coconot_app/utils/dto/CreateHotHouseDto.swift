//
//  CreateHotHouseDto.swift
//  coconot_app
//
//  Created by lucas mercier on 17/10/2025.
//


struct CreateHotHouseDto: Codable, Hashable {
    let name: String
    let address: AddressDto
    let location: LocalisationGpsDto
    let temperatureThresholdMax: Double
    let temperatureThresholdMin: Double
    let humidityThresholdMax: Double
    let humidityThresholdMin: Double
}