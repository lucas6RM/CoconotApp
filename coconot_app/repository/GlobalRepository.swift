//
//  GlobalRepository.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation
import Factory


@MainActor
@Observable
class GlobalRepository {
    
    private let apiService : ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getAllHotHousesWithPredictions() async throws -> [HotHouseWithPredictionModel] {
        let hotHousesWithPredictionsDto = try await apiService.getAllHotHousesWithPredictions()
        return hotHousesWithPredictionsDto.map { item in
            item.toModel()
        }
    }
    
    func getAllDailyReportForToday(date : Date = .now) async throws -> [DailyReportModel] {
        let dailyReportsDto = try await apiService.getAllHotHousesDailyReport()
        return dailyReportsDto.map { item in
            item.toModel()
        }
    }
    
    func addHumidity(dto : HumidityMeasureDto) async throws {
        try await apiService.addHumidity(dto: dto)
    }
    
    func getHotHouseById(id: String) async throws -> HotHouseModel {
        let hotHouseDto = try await apiService.getHotHouseById(id: id)
        return hotHouseDto.toModel()
    }
    
    func getAllHotHouses() async throws -> [HotHouseModel] {
        let hotHousesDto = try await apiService.getAllHotHouses()
        return hotHousesDto.map{ item in
                item.toModel()
        }
    }
    
    func createHotHouse(dto: CreateHotHouseDto) async throws {
        let _ : HotHouseDto = try await apiService.post("/hothouses", body: dto)
        
    }
    
    func updateHotHouse(dto: UpdateHotHouseDto) async throws {
        let _ : HotHouseDto = try await apiService.post("/hothouses/\(dto.id)", body: dto)
    }
    
    func deleteHotHouseById(id: String) async throws {
        try await apiService.delete("/hothouses/\(id)")
    }
    
}
    
