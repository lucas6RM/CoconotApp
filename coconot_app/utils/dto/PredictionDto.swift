//
//  PredictionDto.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//


struct PredictionDto: Codable, Hashable {
    let hotHouseId: String
    let openedWindowsDurationsPredicted: [OpenedWindowsDurationDto]

    
}
