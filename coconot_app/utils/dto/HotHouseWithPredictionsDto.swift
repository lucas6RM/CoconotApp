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
    let predictionsOfTheDay: PredictionDto

    enum CodingKeys: String, CodingKey {
        case hotHouse = "hot_house"
        case predictionsOfTheDay = "predictions_of_the_day"
    }
}

// Optional wrapper if your endpoint returns a list
struct HotHousesWithPredictionsResponseDto: Codable, Hashable {
    let items: [HotHouseWithPredictionDto]

    enum CodingKeys: String, CodingKey {
        case items
    }
}
