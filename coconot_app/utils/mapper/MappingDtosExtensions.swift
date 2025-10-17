//
//  MappingDtos.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//



import Foundation
extension AddressDto {
    func toModel() -> Address {
        Address(addressStreet: addressStreet, postalCode: postalCode, city: city)
    }
}

extension LocalisationGpsDto {
    func toModel() -> LocalisationGps {
        LocalisationGps(latitude: latitude, longitude: longitude)
    }
}

extension OpenedWindowsDurationDto {
    func toModel() -> OpenedWindowsDurationModel {
        OpenedWindowsDurationModel(hotHouseId: hotHouseId, openWindowTime: openWindowTime, closeWindowTime: closeWindowTime)
    }
}

extension PredictionDto {
    func toModel() -> PredictionModel {
        PredictionModel(
            hotHouseId: hotHouseId,
            openedWindowsDurationsPredicted: openedWindowsDurationsPredicted.map { $0.toModel() }
        )
    }
}

extension HotHouseDto {
    func toModel() -> HotHouseModel {
        HotHouseModel(
            id: id,
            name: name,
            address: address.toModel(),
            location: location.toModel(),
            temperatureThresholdMax: temperatureThresholdMax,
            temperatureThresholdMin: temperatureThresholdMin,
            humidityThresholdMax: humidityThresholdMax,
            humidityThresholdMin: humidityThresholdMin
        )
    }
}

extension HotHouseWithPredictionDto {
    func toModel() -> HotHouseWithPredictionModel {
        let house = hotHouse.toModel()
        let predictions = predictionsOfTheDay?.toModel()
        return HotHouseWithPredictionModel(hotHouse: house, predictionsOfTheDay: predictions)
    }
}


extension DailyReportDto {
    func toModel() -> DailyReportModel {
        DailyReportModel(
            hotHouseId: hotHouseId,
            temperatureMeasurements: temperatureMeasurements.map { $0.toModel() },
            humidityMeasurements: humidityMeasurements.map { $0.toModel() },
            openedWindowsDurations: openedWindowsDurations.map { $0.toModel(hotHouseId: hotHouseId) },
            rateOfTheDay: rateOfTheDay,
            date: date,
            predictionOfTheDay: predictionOfTheDay?.toModel() ?? PredictionModel(hotHouseId: hotHouseId, openedWindowsDurationsPredicted: [])
        )
    }
}

extension TemperatureMeasureResponseDto {
    func toModel() -> TemperatureMeasureModel {
        TemperatureMeasureModel(
            hotHouseId: hotHouseId,
            temperatureMeasuredInsideHotHouse: temperatureMeasuredInsideHotHouse,
            temperatureFromWeather: temperatureFromWeather,
            timestamp: timestamp
        )
    }
}

extension HumidityMeasureResponseDto {
    func toModel() -> HumidityMeasureModel {
        HumidityMeasureModel(
            hotHouseId: hotHouseId,
            humidityMeasuredInsideHotHouse: humidityMeasuredInsideHotHouse,
            humidityFromWeather: humidityFromWeather,
            timestamp: timestamp
        )
    }
}

extension OpenedWindowsDurationDto {
    func toModel(hotHouseId: String) -> OpenedWindowsDurationModel {
        OpenedWindowsDurationModel(
            hotHouseId: hotHouseId,
            openWindowTime: formatHour(openWindowTime),
            closeWindowTime: formatHour(closeWindowTime),
        )
    }

    private func formatHour(_ hourString: String) -> String {
        let components = hourString.split(separator: ":")
        guard components.count == 2,
              let h = Int(components[0]),
              let m = Int(components[1]) else { return hourString }
        return "\(h)h\(String(format: "%02d", m))"
    }
}
