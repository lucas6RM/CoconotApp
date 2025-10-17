//
//  OpenedWindowsDurationDto.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//


struct OpenedWindowsDurationDto: Codable, Hashable {
    let hotHouseId: String
    let openWindowTime: String
    let closeWindowTime: String

    enum CodingKeys: String, CodingKey {
        case hotHouseId = "hot_house_id"
        case openWindowTime = "open_window_time"
        case closeWindowTime = "close_window_time"
    }
    
}
