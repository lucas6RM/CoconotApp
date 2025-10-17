//
//  LocalisationGpsDto.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//


struct LocalisationGpsDto: Codable, Hashable {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
}
