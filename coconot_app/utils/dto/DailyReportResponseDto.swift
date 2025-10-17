//
//  DailyReportDto.swift
//  coconot_app
//
//  Created by lucas mercier on 17/10/2025.
//

import Foundation


struct DailyReportResponseDto: Codable, Hashable {
    let id: String
    let hotHouseId: String
    let hotHouseName: String
    let isSubmitted: Bool
    let temperatureMeasurements: [TemperatureMeasureResponseDto]
    let humidityMeasurements: [HumidityMeasureResponseDto]
    let openedWindowsDurations: [OpenedWindowsDurationDto]
    let rateOfTheDay: Int?
    let date: Date
    let predictionOfTheDay: PredictionDto?
}
