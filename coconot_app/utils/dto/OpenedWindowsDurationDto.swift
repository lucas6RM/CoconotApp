//
//  OpenedWindowsDurationDto.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation


struct OpenedWindowsDurationDto: Codable, Hashable {
    let hotHouseId: String
    let openWindowTime: String
    let closeWindowTime: String
}
