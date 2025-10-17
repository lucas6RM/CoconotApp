//
//  HotHouseWithPredictionsDto.swift
//  coconot_app
//
//  Created by Assistant on 16/10/2025.
//

import Foundation


// Top-level payload: one hot house with its predictions
struct HotHouseWithPredictionDto: Codable, Hashable {
    let hotHouse: HotHouseDto
    let predictionsOfTheDay: PredictionDto?
    
}
