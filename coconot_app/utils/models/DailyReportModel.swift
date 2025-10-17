//
//  DailyReportModel.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation



struct DailyReportModel {
    let hotHouseId : String
    let temperatureMeasurements : [TemperatureMeasureModel]
    let humidityMeasurements : [HumidityMeasureModel]
    let openedWindowsDurations : [OpenedWindowsDurationModel]
    let rateOfTheDay : Int
    let date : Date
    let predictionOfTheDay : PredictionModel
}

