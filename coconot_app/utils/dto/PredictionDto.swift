//
//  PredictionDto.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//


struct PredictionDto: Codable, Hashable {
    let hotHouseId: String
    let openedWindowsDurationsPredicted: [OpenedWindowsDurationDto]

    enum CodingKeys: String, CodingKey {
        case hotHouseId = "hot_house_id"
        case openedWindowsDurationsPredicted = "opened_windows_durations_predicted"
    }
}
