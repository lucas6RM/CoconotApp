//
//  DailyReportModel.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation



struct DailyReportModel : Identifiable {
    let id: String
    let hotHouseId : String
    let hotHouseName : String
    let isSubmitted : Bool
    let temperatureMeasurements : [TemperatureMeasureModel]
    let humidityMeasurements : [HumidityMeasureModel]
    let openedWindowsDurations : [OpenedWindowsDurationModel]
    let rateOfTheDay : Int?
    let date : Date
    let predictionOfTheDay : PredictionModel
}

