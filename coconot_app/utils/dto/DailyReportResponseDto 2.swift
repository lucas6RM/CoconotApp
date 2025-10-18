//
//  DailyReportDto.swift
//  coconot_app
//
//  Created by lucas mercier on 17/10/2025.
//

import Foundation


struct SubmitRateDailyReportDto: Codable, Hashable {
    let hotHouseId: String
    let isSubmitted: Bool
    let rateOfTheDay: Int
}
