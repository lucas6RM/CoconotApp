//
//  HotHouseDto.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation

struct HotHouseModel {
    let id: String
    let name: String
    let address: Address
    let location: LocalisationGps
    let temperatureThresholdMax: Double
    let temperatureThresholdMin: Double
    let humidityThresholdMax: Double
    let humidityThresholdMin: Double
}

struct TemperatureMeasureModel {
    let temperatureMeasuredInsideHotHouse : Double
    let temperatureFromWeather : Double
    let timestamp : Date
}

struct HumidityMeasureModel {
    let humidityMeasuredInsideHotHouse : Double
    let humidityFromWeather : Double
    let timestamp : Date
}

struct OpenedWindowsDurationModel {
    let openWindowTime : String
    let closeWindowTime : String
}

struct DailyReportModel {
    let hotHouseId : String
    let temperatureMeasurements : [TemperatureMeasureModel]
    let humidityMeasurements : [HumidityMeasureModel]
    let openedWindowsDurations : [OpenedWindowsDurationModel]
    let rateOfTheDay : Int
    let date : Date
    let predictionOfTheDay : PredictionModel
}

struct PredictionModel {
    let hotHouseId : String
    let openedWindowsDurationsPredicted : [OpenedWindowsDurationModel]
}

struct PredictionsOfTheDayModel {
    let predictionsOfTheDay : [PredictionModel]
}

struct Address: Codable, Hashable {
    var addressStreet: String
    var postalCode: String
    var city: String
    
    func getFullAddress() -> String {
        return "\(addressStreet) \(postalCode) \(city)"
    }
}

struct LocalisationGps {
    let latitude: Double
    let longitude: Double
    
}
