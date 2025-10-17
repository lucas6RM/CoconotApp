//
//  MappingDtos.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//



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
        let predictions = predictionsOfTheDay.toModel()
        return HotHouseWithPredictionModel(hotHouse: house, predictionsOfTheDay: predictions)
    }
}
